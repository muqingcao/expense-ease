//
//  WelcomeScreen.swift
//  ExpenseEase
//
//  Created by Chang Lin on 10/20/24.
//

import UIKit

class WelcomeScreen: UIView {
    var labelWelcome: UILabel!
    var buttonLogin: UIButton!
    var buttonSignup: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelWelcome()
        setupButtonLogin()
        setupButtonSignup()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabelWelcome() {
        labelWelcome = UILabel()
        labelWelcome.text = "Hiii, welcome 😉"
        labelWelcome.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelWelcome)
    }
    
    func setupButtonLogin() {
        buttonLogin = UIButton(type: .system)
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.setTitleColor(UIColor.black, for: .normal)
        buttonLogin.layer.borderWidth = 2.0
        buttonLogin.layer.cornerRadius = 10.0
        buttonLogin.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonLogin.clipsToBounds = true
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogin)
    }
    
    func setupButtonSignup() {
        buttonSignup = UIButton(type: .system)
        buttonSignup.setTitle("Sign up", for: .normal)
        buttonSignup.layer.borderWidth = 2.0
        buttonSignup.setTitleColor(UIColor.black, for: .normal)
        buttonSignup.layer.cornerRadius = 10.0
        buttonSignup.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        // Enable clipping to bounds to respect the corner radius
        buttonSignup.clipsToBounds = true
        buttonSignup.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSignup)
    }

    
    func initConstraints() {
        NSLayoutConstraint.activate([
             labelWelcome.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
             labelWelcome.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

             buttonLogin.topAnchor.constraint(equalTo: labelWelcome.bottomAnchor, constant: 52),
             buttonLogin.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 80),
             buttonLogin.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80),
             buttonLogin.heightAnchor.constraint(equalToConstant: 50),
            
             buttonSignup.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 32),
             buttonSignup.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 80),
             buttonSignup.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80),
             buttonSignup.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}
