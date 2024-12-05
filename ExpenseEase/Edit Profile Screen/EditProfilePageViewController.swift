//
//  EditProfilePageViewController.swift
//  ExpenseEase
//
//  Created by Guangmei Xiang on 10/23/24.
//

import UIKit
import PhotosUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
//import SDWebImage

protocol EditProfileDelegate: AnyObject {
    func didUpdateProfile(_ updatedUser: User)
}

class EditProfilePageViewController: UIViewController {
    weak var delegate: EditProfileDelegate?
    let editProfileScreen = EditProfilePageView()
    var selectedImage: UIImage?
    var currentUser: User?
    let storage = Storage.storage()
    let database = Firestore.firestore()
    var listener: ListenerRegistration?
    let childProgressView = ProgressSpinnerViewController()

    
    override func loadView() {
        view = editProfileScreen
        title = "Edit Profile"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        navigationItem.leftBarButtonItem = cancelButton
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(onSaveButtonTapped)
        )
        
        
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)],
            for: .normal
        )
        
        editProfileScreen.profileImageButton.menu = getMenuImagePicker()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDatabaseListener()
    }
        
//        // used the profile image from profile screen, avoid fetching the URL from database
//            if let profileImage = profileImage {
//                let circularImage = cropImageToCircle(image: profileImage)
//                editProfileScreen.profileImageButton.setImage(
//                    circularImage.withRenderingMode(.alwaysOriginal),
//                    for: .normal
//                )
//            }
//
//            if let currentUser = currentUser {
//                editProfileScreen.textFieldfirstName.text = currentUser.firstName
//                editProfileScreen.textFieldlastName.text = currentUser.lastName
//            } else {
//                // if there is no data, we need to call the function to fetch data on our own
//                setupDatabaseListener()
//            }
//        }
    
    
    private func setupDatabaseListener() {
           guard let email = Auth.auth().currentUser?.email else {
               print("No authenticated user")
               return
           }
           
           let userDocument = database.collection("users").document(email)
           listener = userDocument.addSnapshotListener { [weak self] documentSnapshot, error in
               guard let self = self else { return }
               
               if let error = error {
                   print("Error listening to user data: \(error)")
                   return
               }
               
               guard let document = documentSnapshot, document.exists, let data = document.data() else {
                   print("User data does not exist.")
                   return
               }
               print("User document data received: \(data)")
               self.fetchUserData(with: data, email: email)
           }
       }

       private func fetchUserData(with data: [String: Any], email: String) {
           if let firstName = data["firstName"] as? String,
              let lastName = data["lastName"] as? String,
              let photoUrlString = data["photoUrl"] as? String {
               print("Loaded user data:")
                       print("First Name: \(firstName)")
                       print("Last Name: \(lastName)")
                       print("Photo URL: \(photoUrlString)")
               
               self.currentUser = User(firstName: firstName, lastName: lastName, email: email, photoUrl: photoUrlString)
               
               // Update UI
               DispatchQueue.main.async {
                   self.editProfileScreen.textFieldfirstName.text = firstName
                   self.editProfileScreen.textFieldlastName.text = lastName
                   self.fetchProfileImage(from: photoUrlString)
                   
                   print("First Name second try: \(firstName)")
                   print("Last Name second try: \(lastName)")
                   print("Photo URL second try: \(photoUrlString)")
               }
           }
       }

   
       private func fetchProfileImage(from photoUrlString: String) {
           guard let photoUrl = URL(string: photoUrlString) else {
               print("Invalid photo URL")
               return
           }
           
           DispatchQueue.global(qos: .background).async {
               do {
                   let imageData = try Data(contentsOf: photoUrl)
                   print("Successfully fetched image data from URL: \(photoUrlString)")
                   
                   if let image = UIImage(data: imageData) {
                       //let circularImage = self.cropImageToCircle(image: image)
                       DispatchQueue.main.async {
                           self.editProfileScreen.profileImageButton.setImage(
                              image.withRenderingMode(.alwaysOriginal),
                               for: .normal
                           )
                       }
                   }
               } catch {
                print("Error loading image data: \(error)")
            }
        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener?.remove()
    }
    
    func getMenuImagePicker() -> UIMenu {
        let menuItems = [
            UIAction(title: "Camera", handler: { _ in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery", handler: { _ in
                self.pickPhotoFromGallery()
            })
        ]
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    func pickUsingCamera() {
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    func pickPhotoFromGallery() {
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.images
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        photoPicker.delegate = self
        present(photoPicker, animated: true)
    }
    
    
    @objc func onSaveButtonTapped() {
        guard let firstName = editProfileScreen.textFieldfirstName.text, !firstName.isEmpty else {
            print("First name is empty")
            return
        }
        guard let lastName = editProfileScreen.textFieldlastName.text, !lastName.isEmpty else {
            print("Last name is empty")
            return
        }
        
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                self.showActivityIndicator() 
            }
        }
        
        currentUser?.firstName = firstName
        currentUser?.lastName = lastName
        
        if let image = selectedImage {
            uploadProfilePhoto(image: image, firstName: firstName, lastName: lastName)
            
        } else {
            updateUserInfo(firstName: firstName, lastName: lastName, photoURL: nil)
        }
    }
    
    
    func uploadProfilePhoto(image: UIImage, firstName: String, lastName: String) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Failed to convert image to JPEG data")
            updateUserInfo(firstName: firstName, lastName: lastName, photoURL: nil)
            return
        }
        
        let storageRef = storage.reference()
        let imagesRepo = storageRef.child("imagesUsers")
        let imageRef = imagesRepo.child("\(UUID().uuidString).jpg")
        
        imageRef.putData(imageData, metadata: nil) { [weak self] _, error in
            if let error = error {
                print("Error uploading image: \(error)")
                self?.updateUserInfo(firstName: firstName, lastName: lastName, photoURL: nil)
                return
            }
            
            imageRef.downloadURL { [weak self] url, error in
                if let error = error {
                    print("Error getting download URL: \(error)")
                    self?.updateUserInfo(firstName: firstName, lastName: lastName, photoURL: nil)
                    return
                }
                
                self?.updateUserInfo(firstName: firstName, lastName: lastName, photoURL: url)
            }
        }
    }
    
    func updateUserInfo(firstName: String, lastName: String, photoURL: URL?){
        guard let currentUser = Auth.auth().currentUser else { return }
        let userRef = database.collection("users").document(currentUser.email ?? "")

        var userData: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName
        ]
        if let photoURL = photoURL {
            userData["photoUrl"] = photoURL.absoluteString
        }
        
        userRef.updateData(userData) { [weak self] error in
            if let error = error {
                print("Error Updating user data: \(error)")
                return
            }
            print("Successfully updating user data")
           self?.updateAuthProfile(firstName: firstName, lastName: lastName, photoURL: photoURL)
        }
    }

    func updateAuthProfile(firstName: String, lastName: String, photoURL: URL?) {
        let fullName = "\(firstName) \(lastName)"
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = fullName
        changeRequest?.photoURL = photoURL
        changeRequest?.commitChanges { [weak self] error in
            if let error = error {
                print("Error Updating auth user data: \(error)")
                return
            }
            print("Successfully updating auth user data")
            self?.navigationController?.popViewController(animated: true)
        }
    }

    
    @objc func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func cropImageToCircle(image: UIImage) -> UIImage {
            let minEdge = min(image.size.width, image.size.height)
            let size = CGSize(width: minEdge, height: minEdge)

            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            let context = UIGraphicsGetCurrentContext()
            
            let rect = CGRect(origin: .zero, size: size)
            context?.addEllipse(in: rect)
            context?.clip()
            image.draw(in: rect)
            
            let circularImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return circularImage ?? image
        }
    
    }


extension EditProfilePageViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        let itemProviders = results.map(\.itemProvider)
        
        for item in itemProviders {
            if item.canLoadObject(ofClass: UIImage.self) {
                item.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                    DispatchQueue.main.async {
                        if let uwImage = image as? UIImage {
                            let circularImage = self?.cropImageToCircle(image: uwImage)
                            self?.editProfileScreen.profileImageButton.setImage(
                                circularImage?.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self?.selectedImage = circularImage
                        }
                    }
                }
            }
        }
    }
}



extension EditProfilePageViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        print("ImagePickerController finished")
        
        if let image = info[.editedImage] as? UIImage {
            print("Successfully picked edited image with size: \(image.size)")
            editProfileScreen.profileImageButton.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            selectedImage = image
        }
    }
}

extension EditProfilePageViewController: ProgressSpinnerDelegate {
    func showActivityIndicator() {
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator() {
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
