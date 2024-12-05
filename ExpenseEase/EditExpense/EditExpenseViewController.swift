//
//  EditExpenseViewController.swift
//  ExpenseEase
//
//  Created by Xihuan Liu on 11/18/24.
//

import UIKit
import PhotosUI
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class EditExpenseViewController: UIViewController {
    let editExpenseView = EditExpenseView()
    let childProgressView = ProgressSpinnerViewController()
    
    let database = Firestore.firestore()
    var currentUser = Auth.auth().currentUser
    
    var delegate: HomePageViewController!

    var expense: Expense!
    var expenseId: String!
    var categoryButtons = [UIButton]()
    var amount: Double
    var selectedDate: Date
    var selectedCategory: String
    var note: String?
    var selectedImageUrl: String?
    var newImage: UIImage?

    init(expense: Expense) {
        self.expense = expense
        self.expenseId = expense.id
        self.amount = expense.amount
        self.selectedDate = expense.dateTime
        self.selectedCategory = expense.category
        self.note = expense.note
        self.selectedImageUrl = expense.imageUrl

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = editExpenseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit Expense"

        setupCategoryButtons()
        populateExpense()
        setupActions()
    }
    
    @objc func onCancelBarButtonTapped() {
        print("Cancel button tapped")
        navigationController?.popViewController(animated: true)
    }

    // populate the view with existing data
    func populateExpense(){
        editExpenseView.amountTextField.text = String(amount)
        editExpenseView.datePicker.date = selectedDate
        if note != nil {
            editExpenseView.noteTextView.text = note!
        }
        if selectedImageUrl != nil {
            loadImageFromStorage(path: selectedImageUrl!)
        }
    }

    // retrieve image from storage
    func loadImageFromStorage(path: String) {
        let storageRef = Storage.storage().reference().child(path)
        storageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
            } else if let data = data {
                self.editExpenseView.imageView.image = UIImage(data: data)
            }
        }
    }

    func setupActions() {
        // Handle the "Save" button tap
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onSaveBarButtonTapped))
        
        // Handle the "Cancel" button tap
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onCancelBarButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton

        // Handle date picker select
        editExpenseView.datePicker.addTarget(self, action: #selector(datePickerTapped(_:)), for: .valueChanged)

        // Handle camera button tap
        editExpenseView.cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)

        // Handle gallery button tap
        editExpenseView.galleryButton.addTarget(self, action: #selector(galleryButtonTapped), for: .touchUpInside)

        // Handle keyboard collapse
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }

    @objc func datePickerTapped(_ sender: UIDatePicker) {
        self.selectedDate = sender.date
        print("Date Picker tapped: \(String(describing: sender.date))")
    }

    @objc func onSaveBarButtonTapped() {
        // unwrap required fields
        guard let amountText = editExpenseView.amountTextField.text else {
            print("Error: Missing data")
            showErrorAlert(message: "Missing data!")
            return
        }
        self.amount = Double(amountText) ?? self.amount
        
        if editExpenseView.noteTextView.text != editExpenseView.notePlaceholder {
            self.note = editExpenseView.noteTextView.text
        }
        
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                self.showActivityIndicator()
            }
        }

        // proceed with image upload only if an image exists
        updateImageToStorage { [weak self] imageUrl in
            guard let self = self else { return }
            
            print("EDIT: amount:\(self.amount), date:\(self.selectedDate), category:\(self.selectedCategory), note:\(String(describing: self.note)), image:\(String(describing: imageUrl))")

            // update Expense with new data
            self.updateExpenseToFirestore(expenseId, imageUrl:imageUrl) { success in
                DispatchQueue.main.async {
                    if success {
                        print("Expense updated successfully")
                        self.delegate.updateSelectedDate(self.selectedDate)
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        print("Failed to save expense")
                        if let imageUrl = imageUrl {
                            self.deleteImageFromStorage(imageUrl) { deletionSuccess in
                                print(deletionSuccess ? "Newly uploaded image deleted successfully" : "Failed to delete the newly uploaded image")
                            }
                        }
                    }
                    self.hideActivityIndicator()
                }
            }
        }
    }

    //MARK: hide Keyboard
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
        print("Gallery button tapped: \(String(describing: newImage))")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == editExpenseView.amountTextField else { return true }

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

    //MARK: Alert for empty entries
    func showErrorAlert(message: String){
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        self.present(alert, animated: true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditExpenseViewController: ProgressSpinnerDelegate {
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
