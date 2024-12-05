//
//  LoginScreen.swift
//  ExpenseEase
//
//  Created by Chang Lin on 10/23/24.
//

import UIKit

class LoginScreen: UIView {
    
    var labelLogin: UILabel!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var buttonPasswordVisible: UIButton!
    var buttonLogin: UIButton!
    var labelNoAccount: UILabel!
    var buttonSignup: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelLogin()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupButtonPasswordVisible()
        setupButtonLogin()
        setupLabelNoAccount()
        setupButtonSignup()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabelLogin() {
        labelLogin = UILabel()
        labelLogin.text = "Login"
        labelLogin.font = UIFont.systemFont(ofSize: 22)
        labelLogin.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelLogin)
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
    
    func setupButtonPasswordVisible() {
        buttonPasswordVisible = UIButton(type: .system)
        buttonPasswordVisible.setTitle("🐵 Show Password", for: .normal)
        buttonPasswordVisible.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        buttonPasswordVisible.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonPasswordVisible)
    }
    
    func setupButtonLogin() {
        buttonLogin = UIButton(type: .system)
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.setTitleColor(UIColor.black, for: .normal)
        buttonLogin.backgroundColor = .systemBlue
        buttonLogin.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogin)
    }
    
    func setupLabelNoAccount() {
        labelNoAccount = UILabel()
        labelNoAccount.text = "Don't have an account?"
        labelNoAccount.font = UIFont.systemFont(ofSize: 14)
        labelNoAccount.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelNoAccount)
    }
    
    func setupButtonSignup() {
        buttonSignup = UIButton(type: . system)
        buttonSignup.setTitle("Sign up", for: .normal)
        buttonSignup.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSignup)
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
            labelLogin.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            labelLogin.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            textFieldEmail.topAnchor.constraint(equalTo: labelLogin.bottomAnchor, constant: 50),
            textFieldEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 65),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -65),
            textFieldEmail.heightAnchor.constraint(equalToConstant: 40),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 20),
            textFieldPassword.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 65),
            textFieldPassword.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -65),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 40),
            
            buttonPasswordVisible.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor),
            buttonPasswordVisible.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 26),
            buttonPasswordVisible.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -150),
            
            buttonLogin.topAnchor.constraint(equalTo: buttonPasswordVisible.bottomAnchor, constant: 50),
            buttonLogin.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonLogin.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 65),
            buttonLogin.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -65),
            
            labelNoAccount.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 15),
            labelNoAccount.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 65),
            labelNoAccount.trailingAnchor.constraint(lessThanOrEqualTo: buttonLogin.trailingAnchor),
            
            buttonSignup.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 8),
            buttonSignup.leadingAnchor.constraint(equalTo: labelNoAccount.trailingAnchor),
            buttonSignup.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -100)
            
            
        ])
    }

}
