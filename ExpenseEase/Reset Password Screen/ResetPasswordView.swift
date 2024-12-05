//
//  ResetPasswordView.swift
//  ExpenseEase
//
//  Created by Guangmei Xiang on 12/2/24.
//

import UIKit

import UIKit

class ResetPasswordView: UIView {
    
    var newEmailLabel: UILabel!
    var newPasswordTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupNewEmailLabel()
        setupNewEmailTextField()
        
        initConstraints()
    }
    
    func setupNewEmailLabel() {
        newEmailLabel = UILabel()
        newEmailLabel.text = "New Password"
        newEmailLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        newEmailLabel.textColor = .black
        newEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(newEmailLabel)
    }
    
    func setupNewEmailTextField() {
        newPasswordTextField = UITextField()
        newPasswordTextField.placeholder = "Enter your new password"
        newPasswordTextField.backgroundColor = .systemGray5
        newPasswordTextField.textColor = .black
        newPasswordTextField.font = UIFont.systemFont(ofSize: 14)
        newPasswordTextField.borderStyle = .none
        newPasswordTextField.layer.cornerRadius = 4
        newPasswordTextField.clipsToBounds = true
        newPasswordTextField.setLeftPaddingPoints(10)
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(newPasswordTextField)
    }
    
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            newEmailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            newEmailLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            newPasswordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            newPasswordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            newPasswordTextField.topAnchor.constraint(equalTo: newEmailLabel.bottomAnchor, constant: 10),
            newPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
