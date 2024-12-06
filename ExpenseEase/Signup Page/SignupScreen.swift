//
//  SignupScreen.swift
//  ExpenseEase
//
//  Created by Chang Lin on 10/23/24.
//

import UIKit

class SignupScreen: UIView {
    
    var labelSignup: UILabel!
    var textFieldFirstName: UITextField!
    var textFieldLastName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var buttonAgreed: UIButton!
    var labelAgreement: UILabel!
    var buttonSignup: UIButton!
    var labelAlreadyHaveAccount: UILabel!
    var buttonLogin: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelSignup()
        setupTextFieldFirstName()
        setupTextFieldLastName()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupButtonAgreed()
        setupLabelAgreement()
        setupButtonSignup()
        setupLabelAlreadyHaveAccount()
        setupButtonLogin()
        
        initConstraints()
    }
    
    func setupLabelSignup() {
        labelSignup = UILabel()
        labelSignup.text = "Sign up"
        labelSignup.font = UIFont.systemFont(ofSize: 22)
        labelSignup.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelSignup)
    }
    
    func setupTextFieldFirstName() {
        textFieldFirstName = UITextField()
        textFieldFirstName.placeholder = "First Name"
        textFieldFirstName.keyboardType = .emailAddress
        setupTextFieldRoundedCorners(textFieldFirstName)
        textFieldFirstName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldFirstName)
    }
    
    func setupTextFieldLastName() {
        textFieldLastName = UITextField()
        textFieldLastName.placeholder = "Last Name"
        textFieldLastName.keyboardType = .emailAddress
        setupTextFieldRoundedCorners(textFieldLastName)
        textFieldLastName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldLastName)
    }
    
    func setupTextFieldEmail() {
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.autocapitalizationType = .none
        setupTextFieldRoundedCorners(textFieldEmail)
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setupTextFieldPassword() {
        textFieldPassword = UITextField()
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.placeholder = "Password"
        textFieldPassword.autocapitalizationType = .none
        setupTextFieldRoundedCorners(textFieldPassword)
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setupButtonAgreed() {
        buttonAgreed = UIButton(type: .system)
        buttonAgreed.setImage(UIImage(systemName: "square"), for: .normal)
        buttonAgreed.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonAgreed)
    }
    
    func setupLabelAgreement() {
        labelAgreement = UILabel()
        labelAgreement.text = "I agree to the terms and conditions"
        labelAgreement.font = UIFont.systemFont(ofSize: 13.7)
        labelAgreement.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAgreement)
    }
    
    func setupButtonSignup() {
        buttonSignup = UIButton(type: .system)
        buttonSignup.setTitle("Sign up", for: .normal)
        buttonSignup.setTitleColor(UIColor.black, for: .normal)
        buttonSignup.backgroundColor = .systemBlue
        buttonSignup.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonSignup.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSignup)
    }
    
    func setupLabelAlreadyHaveAccount() {
        labelAlreadyHaveAccount = UILabel()
        labelAlreadyHaveAccount.text = "Already have an account?"
        labelAlreadyHaveAccount.font = UIFont.systemFont(ofSize: 14)
        labelAlreadyHaveAccount.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAlreadyHaveAccount)
    }
    
    func setupButtonLogin() {
        buttonLogin = UIButton(type: . system)
        buttonLogin.setTitle("Log in", for: .normal)
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogin)
    }
    
    func setupTextFieldRoundedCorners(_ textField: UITextField) {
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.clipsToBounds = true
        textField.frame = CGRect(x: 50, y: 100, width: 300, height: 100)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelSignup.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            labelSignup.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            textFieldFirstName.topAnchor.constraint(equalTo: labelSignup.bottomAnchor, constant: 50),
            textFieldFirstName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldFirstName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 65),
            textFieldFirstName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -65),
            textFieldFirstName.heightAnchor.constraint(equalToConstant: 35),
            
            textFieldLastName.topAnchor.constraint(equalTo: textFieldFirstName.bottomAnchor, constant: 20),
            textFieldLastName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldLastName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 65),
            textFieldLastName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -65),
            textFieldLastName.heightAnchor.constraint(equalToConstant: 35),
            
            textFieldEmail.topAnchor.constraint(equalTo: textFieldLastName.bottomAnchor, constant: 20),
            textFieldEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 65),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -65),
            textFieldEmail.heightAnchor.constraint(equalToConstant: 35),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 20),
            textFieldPassword.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 65),
            textFieldPassword.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -65),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 35),
            
            buttonAgreed.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 15),
            buttonAgreed.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 65),
            buttonAgreed.trailingAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            labelAgreement.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 18),
            labelAgreement.leadingAnchor.constraint(equalTo: buttonAgreed.trailingAnchor),
            labelAgreement.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80),

            buttonSignup.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 90),
            buttonSignup.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonSignup.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 65),
            buttonSignup.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -65),
            
            labelAlreadyHaveAccount.topAnchor.constraint(equalTo: buttonSignup.bottomAnchor, constant: 15),
            labelAlreadyHaveAccount.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 65),
            labelAlreadyHaveAccount.trailingAnchor.constraint(lessThanOrEqualTo: buttonSignup.trailingAnchor),
            
            buttonLogin.topAnchor.constraint(equalTo: buttonSignup.bottomAnchor, constant: 8),
            buttonLogin.leadingAnchor.constraint(equalTo: labelAlreadyHaveAccount.trailingAnchor),
            buttonLogin.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -100)
            
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

