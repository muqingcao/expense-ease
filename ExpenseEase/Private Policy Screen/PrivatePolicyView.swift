//
//  PrivatePolicyView.swift
//  ExpenseEase
//
//  Created by Guangmei Xiang on 10/29/24.
//

import UIKit

class PrivatePolicyView: UIView {
    
    var textView: UITextView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        
        setupTextView()
        initConstraints()
    }
    
    func setupTextView() {
        textView = UITextView()
        textView.text = """
            EXPENSEEASE GLOBAL PRIVACY POLICY
            
            At ExpenseEase, Inc., our most important asset is our relationship with our user community. We are committed to maintaining the confidentiality, integrity and security of information about our users and their organizations. This privacy policy (“Privacy Policy” or “Policy”) describes how we collect, use, disclose, share and secure the personal and company information you provide when you use our expense management, invoicing or bill processing software, through our mobile application.

            """
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .darkGray
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textView)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
    
            textView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            textView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
