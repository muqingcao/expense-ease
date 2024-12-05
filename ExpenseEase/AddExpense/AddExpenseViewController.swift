//
//  ViewController.swift
//  ExpenseEase
//
//  Created by Xihuan Liu on 10/20/24.
//

import UIKit
import PhotosUI
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class AddExpenseViewController: UIViewController, UITextFieldDelegate {
    let addExpenseView = AddExpenseView()
    let childProgressView = ProgressSpinnerViewController()
    
    let database = Firestore.firestore()
    var currentUser = Auth.auth().currentUser
    
    var delegate: HomePageViewController!
    
    var selectedDate:Date? = Date()
    var selectedCategory: String?
    var categoryButtons = [UIButton]()
    var note: String?
    var selectedImage:UIImage?
    
    override func loadView() {
        view = addExpenseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Expense"
        
        // limit input to 2 digits after decimal point
        addExpenseView.amountTextField.delegate = self
        
        setupCategoryButtons()
        setupActions()
    }
    
    @objc func onCancelBarButtonTapped() {
        print("Cancel button tapped")
        navigationController?.popViewController(animated: true)
    }

    func setupActions() {
        // Handle the "Save" button tap
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onSaveBarButtonTapped))
        
        // Handle the "Cancel" button tap
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onCancelBarButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
        
        // Handle date picker select
        addExpenseView.datePicker.addTarget(self, action: #selector(datePickerTapped(_:)), for: .valueChanged)
        
        // Handle camera button tap
        addExpenseView.cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        
        // Handle gallery button tap
        addExpenseView.galleryButton.addTarget(self, action: #selector(galleryButtonTapped), for: .touchUpInside)
        
        // Handle keyboard collapse
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func datePickerTapped(_ sender: UIDatePicker) {
        selectedDate = sender.date
        print("Date Picker tapped: \(String(describing: selectedDate))")
    }

    @objc func onSaveBarButtonTapped() {
        // Unwrap required fields
        guard let amountText = addExpenseView.amountTextField.text,
              let amount = Double(amountText),
              let category = self.selectedCategory,
              let date = self.selectedDate else {
            print("Error: Missing data")
            showErrorAlert(message: "Missing data!")
            return
        }
        
        if addExpenseView.noteTextView.text != addExpenseView.notePlaceholder {
            note = addExpenseView.noteTextView.text
        }
        
        // Proceed with image upload only if an image exists
        uploadImageToStorage { [weak self] imageUrl in
            guard let self = self else { return }
            
            // Create Expense object with optional imageUrl
            let expense = Expense(amount: amount, dateTime: date, category: category, note: note, imageUrl: imageUrl)
            
            print("ADD: amount:\(amount), date:\(date), category:\(category), note:\(String(describing: note)), image:\(String(describing: imageUrl))")
            
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    self.showActivityIndicator()
                }
            }
            
            // Save Expense to Firestore
            self.saveExpenseToFirestore(expense) { success in
                print("start save to db")
                if success {
                    print("Expense saved successfully")
                    // pop screen, delegate date
                    self.delegate.updateSelectedDate(self.selectedDate!)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    print("Failed to save expense")
                    // Optionally handle image deletion here if necessary
                    if let imageUrl = imageUrl {
                        self.deleteImageFromStorage(imageUrl)
                    }
                }
            }
        }
    }
    
    //MARK: Hide Keyboard
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    @objc func cameraButtonTapped() {
        let cameralController = UIImagePickerController()
        cameralController.sourceType = .camera
        cameralController.allowsEditing = true
        cameralController.delegate = self
        present(cameralController, animated: true)
        
        print("Camera button tapped")
    }
    
    @objc func galleryButtonTapped() {
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
        print("Gallery button tapped: \(String(describing: selectedImage))")
    }
    
    // MARK: regulate amount entry
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == addExpenseView.amountTextField else { return true }
        
        // validate input
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        if string.rangeOfCharacter(from: allowedCharacters.inverted) != nil {
            return false
        }
        
        // get input string
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // check number of decimal point
        if updatedText.components(separatedBy: ".").count - 1 > 1 {
            return false
        }
        
        // digits after decimal point
        if let decimalIndex = updatedText.firstIndex(of: ".") {
            let decimalPart = updatedText[decimalIndex...]
            if decimalPart.count > 3 { // including decimal point
                return false
            }
        }
        return true
    }
    
    //MARK: alert for empty entries
    func showErrorAlert(message: String){
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
}

extension AddExpenseViewController: ProgressSpinnerDelegate {
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
