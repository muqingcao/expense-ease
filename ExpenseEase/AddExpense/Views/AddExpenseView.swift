//
//  AddExpenseView.swift
//  ExpenseEase
//
//  Created by Xihuan Liu on 10/20/24.
//


import UIKit

class AddExpenseView: UIView, UITextViewDelegate {
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var datePicker: UIDatePicker!
    var datePickerContainer: UIView!
    var toolbar: UIToolbar!
    var confirmButton: UIButton!
    var cancelButton: UIButton!
    var amountTextField: UITextField!
    var noteTextView: UITextView!
    var categoriesStackView: UIStackView!
    var uploadLabel: UILabel!
    var uploadStackView: UIStackView!
    var cameraButton: UIButton!
    var galleryButton: UIButton!
    var imageSelectedLabel: UILabel!
    var imageView: UIImageView!
    
    let notePlaceholder = "Enter your notes here..."

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupScrollView()
        setupContentView()
        
        setupDatePicker()
        setupAmountTextField()
        setupCategorieStackView()
        setupNoteTextView()
        setupUploadLabel()
        setupUploadStackView()
        setupCameraButton()
        setupGalleryButton()
        setupImageSelectedLabel()
        setupImageView()
        initConstraints()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupContentView() {
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    func setupDatePicker(){
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.maximumDate = Date()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(datePicker)
    }

    func setupAmountTextField(){
        amountTextField = UITextField()
        amountTextField.placeholder = "0.00"
        amountTextField.font = UIFont.systemFont(ofSize: 28)
        amountTextField.textAlignment = .center
        amountTextField.keyboardType = .decimalPad
        amountTextField.borderStyle = .none
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(amountTextField)
    }
    
    func setupCategorieStackView() {
        categoriesStackView = UIStackView()
        categoriesStackView.axis = .vertical
        categoriesStackView.spacing = 16
        categoriesStackView.alignment = .center
        categoriesStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoriesStackView)
    }
    
    func setupNoteTextView() {
        noteTextView = UITextView()
        noteTextView.font = UIFont.systemFont(ofSize: 16)
        noteTextView.textColor = .lightGray
        noteTextView.text = notePlaceholder
        noteTextView.layer.borderColor = UIColor.lightGray.cgColor
        noteTextView.layer.borderWidth = 1.0
        noteTextView.layer.cornerRadius = 8
        noteTextView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        noteTextView.isScrollEnabled = true
        noteTextView.delegate = self
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(noteTextView)
    }
    
    func setupUploadLabel(){
        uploadLabel = UILabel()
        uploadLabel.text = "Upload a receipt"
        uploadLabel.font = UIFont.systemFont(ofSize: 16)
        uploadLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(uploadLabel)
    }
    
    func setupUploadStackView(){
        uploadStackView = UIStackView()
        uploadStackView.axis = .horizontal
        uploadStackView.alignment = .center
        uploadStackView.spacing = 16
        uploadStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(uploadStackView)
    }
    
    func setupCameraButton(){
        cameraButton = UIButton()
        cameraButton.setImage(UIImage(systemName: "camera"), for: .normal)
        cameraButton.tintColor = .black
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        uploadStackView.addArrangedSubview(cameraButton)
    }
    
    func setupGalleryButton(){
        galleryButton = UIButton()
        galleryButton.setImage(UIImage(systemName: "photo"), for: .normal)
        galleryButton.tintColor = .black
        galleryButton.translatesAutoresizingMaskIntoConstraints = false
        uploadStackView.addArrangedSubview(galleryButton)
    }
    
    func setupImageSelectedLabel(){
        imageSelectedLabel = UILabel()
        imageSelectedLabel.text = "No image selected"
        imageSelectedLabel.font = UIFont.systemFont(ofSize: 14)
        imageSelectedLabel.textColor = .gray
        imageSelectedLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageSelectedLabel)
    }

    func setupImageView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            datePicker.widthAnchor.constraint(equalToConstant: 150),
            
            amountTextField.centerYAnchor.constraint(equalTo: datePicker.centerYAnchor),
            amountTextField.leadingAnchor.constraint(equalTo: datePicker.trailingAnchor, constant: 16),
            amountTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            categoriesStackView.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 32),
            categoriesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoriesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            noteTextView.topAnchor.constraint(equalTo: categoriesStackView.bottomAnchor, constant: 16),
            noteTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            noteTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            noteTextView.heightAnchor.constraint(equalToConstant: 50),
            
            uploadLabel.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 32),
            uploadLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            uploadStackView.topAnchor.constraint(equalTo: uploadLabel.bottomAnchor, constant: 16),
            uploadStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            imageSelectedLabel.topAnchor.constraint(equalTo: uploadStackView.bottomAnchor, constant: 16),
            imageSelectedLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: imageSelectedLabel.bottomAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == notePlaceholder {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = notePlaceholder
            textView.textColor = .lightGray
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
