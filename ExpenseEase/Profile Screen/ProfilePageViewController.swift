//
//  ProfilePageViewController.swift
//  ExpenseEase
//
//  Created by Guangmei Xiang on 10/23/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfilePageViewController: UIViewController {
    var delegate: ViewController!
    var currentUser: User?
    let database = Firestore.firestore()
    let profileScreen = ProfilePageView()
    var listener: ListenerRegistration?
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    
    override func loadView() {
        view = profileScreen
        title = "Settings"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let backButton = UIBarButtonItem()
//        backButton.title = ""
//        navigationItem.backBarButtonItem = backButton
        
        profileScreen.editProfileButton.addTarget(self, action: #selector(editPorfileButtonTapped), for: .touchUpInside)
        profileScreen.helpFeedbackButton.addTarget(self, action: #selector(helpFeedbackButtonTapped), for: .touchUpInside)
        profileScreen.closeAccountButton.addTarget(self, action: #selector(closeAccountButtonTapped), for: .touchUpInside)
        profileScreen.privatePolicyButton.addTarget(self, action: #selector(privatePolicyButtonTapped), for: .touchUpInside)
        profileScreen.logoutButton.addTarget(self, action: #selector(onLogOutBarButtonTapped), for: .touchUpInside)
        profileScreen.resetPasswordButton.addTarget(self, action: #selector(onResetPasswordTapped), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleAuth = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }
            
            if let user = user, let email = user.email {
                let userDocument = self.database.collection("users").document(email)
                
                self.listener = userDocument.addSnapshotListener { [weak self] documentSnapshot, error in
                    guard let self = self else { return }
                    
                    if let error = error {
                        print("Error listening to user data: \(error)")
                        return
                    }
                    
                    guard let document = documentSnapshot, document.exists, let data = document.data() else {
                        print("User data does not exist.")
                        return
                    }
                    
                    if let firstName = data["firstName"] as? String,
                       let lastName = data["lastName"] as? String,
                       let photoUrl = data["photoUrl"] as? String {
                        self.currentUser = User(firstName: firstName, lastName: lastName, email: email, photoUrl: photoUrl)
                        DispatchQueue.main.async {
                            self.updateProfile()
                        }
                    }
                }
            } else {
                self.showErrorAlert(title: "Error", message: "Please login")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        listener?.remove()
        listener = nil
        
        if let handleAuth = handleAuth {
            Auth.auth().removeStateDidChangeListener(handleAuth)
            self.handleAuth = nil
        }
    }
    
    
    @objc func editPorfileButtonTapped(){
        let editProfileViewController = EditProfilePageViewController()
        editProfileViewController.delegate = self
        editProfileViewController.currentUser = currentUser
        //editProfileViewController.profileImage = profileScreen.profileImage.image
        navigationController?.pushViewController(editProfileViewController, animated: true)
    }
    
    @objc func onResetPasswordTapped() {
        let resetPasswordScreen = ResetPasswordViewController()
        navigationController?.pushViewController(resetPasswordScreen, animated: true)
    }
    
    @objc func helpFeedbackButtonTapped() {
        let helpFeedbackScreen = HelpAndFeedbackViewController()
        navigationController?.pushViewController(helpFeedbackScreen, animated: true)
    }
    
    @objc func privatePolicyButtonTapped() {
        let privatePolicyScreen = PrivatePolicyViewController()
        navigationController?.pushViewController(privatePolicyScreen, animated: true)
    }
    
    @objc func onLogOutBarButtonTapped() {
        let logoutAlert = UIAlertController(title: "Log out",
                                            message: "Are you sure you want to log out?",
                                            preferredStyle: .actionSheet)
        
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .destructive, handler: { _ in
            
            self.handleLogout()
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(logoutAlert, animated: true, completion: nil)
    }
    
    func handleLogout() {
        do {
        
            listener?.remove()
            listener = nil
            
            if let handleAuth = handleAuth {
                Auth.auth().removeStateDidChangeListener(handleAuth)
                self.handleAuth = nil
            }
            
            try Auth.auth().signOut()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.navigateToWelcomeScreen()
            }
        } catch let error {
            print("Failed to sign out: \(error.localizedDescription)")
        }
    }

    
    @objc func closeAccountButtonTapped() {
        let alert = UIAlertController(
            title: "Are you sure?",
            message: "All of your data will be deleted.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Close My Account", style: .destructive, handler: { _ in
            self.deleteUserAccount()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteUserAccount() {
        guard let currentUser = Auth.auth().currentUser, let email = currentUser.email else {
            print("No authenticated user")
            return
        }

        // Delete Firestore user data
        let user = database.collection("users").document(email)
        user.delete { error in
            if let error = error {
                print("Error deleting user data from Firestore: \(error)")
                self.showErrorAlert(title: "Error", message: "Failed to delete user data. Please try again.")
                return
            }
            
            // Delete Authentication
            currentUser.delete { error in
                if let error = error {
                    print("Error deleting user from Authentication: \(error)")
                    self.showErrorAlert(title: "Error", message: "Failed to delete user account. Please try again.")
                    return
                }
                
                self.navigateToWelcomeScreen()
            }
        }
    }

//    func navigateToLoginScreen() {
//        let loginViewController = LoginViewController()
//        let navController = UINavigationController(rootViewController: loginViewController)
//        navController.modalPresentationStyle = .fullScreen
//        DispatchQueue.main.async {
//            
//            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//               let window = windowScene.windows.first {
//                window.rootViewController = navController
//                window.makeKeyAndVisible()
//            } else {
//                print("No valid UIWindowScene found.")
//            }
//        }
//    }

    func updateProfile() {
        guard let user = currentUser else { return }
        profileScreen.emailLabel.text = user.email ?? "Enter your Email Address"
        profileScreen.updateProfileButtonTitle(with: "\(user.firstName ?? "") \(user.lastName ?? "")")
        
        if let photoUrl = user.photoUrl, let url = URL(string: photoUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error loading image: \(error)")
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    print("Failed to decode image")
                    return
                }
                
                DispatchQueue.main.async {
                    self.profileScreen.profileImage.image = image
                }
            }.resume()
        }
        
    }
 
//    func showErrorAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
    
    func updateProfileButtonTitle(with name: String) {
        profileScreen.updateProfileButtonTitle(with: name)
    }
    
}

extension ProfilePageViewController: EditProfileDelegate {
        func didUpdateProfile(_ updatedUser: User) {
            currentUser = updatedUser
            updateProfile()
        }
    }
    
    

