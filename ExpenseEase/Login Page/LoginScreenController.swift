//
//  LoginScreenController.swift
//  ExpenseEase
//
//  Created by Chang Lin on 10/23/24.
//

import UIKit

class LoginScreenController: UIViewController {
    
    let loginScreen = LoginScreen()
    //MARK: instantiating the Notification center...
    let notificationCenter = NotificationCenter.default
    var showPassword = false
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = loginScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        title = "Expense Ease"
        
        //MARK: buttonPasswordVisible target...
        loginScreen.buttonPasswordVisible
            .addTarget(self, action: #selector(onButtonPasswordVisibleTapped), for: .touchUpInside)
        
        //MARK: buttonSignup target...
        loginScreen.buttonSignup
            .addTarget(self, action: #selector(onButtonSignupTapped), for: .touchUpInside)
        
        //MARK: buttonLogin target...
        loginScreen.buttonLogin
            .addTarget(self, action: #selector(onButtonLoginTapped), for: .touchUpInside)
    }
    
    @objc func onButtonPasswordVisibleTapped(){
        if (showPassword == false) {
            loginScreen.buttonPasswordVisible.setTitle("🙈 Hide Password", for: .normal)
            loginScreen.textFieldPassword.isSecureTextEntry = false
            showPassword = true
        } else {
            loginScreen.buttonPasswordVisible.setTitle("🐵 Show Password", for: .normal)
            loginScreen.textFieldPassword.isSecureTextEntry = true
            showPassword = false
        }
    }
    
    @objc func onButtonLoginTapped() {
        loginUser()
    }
    
    @objc func onButtonSignupTapped() {
        self.notificationCenter.post(
            name: Notification.Name("signupRequest"),
            object: nil)
    }

}



extension LoginScreenController:ProgressSpinnerDelegate{
    func showActivityIndicator(){
        // add the indicator as a child view
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        // call "didMove()" method to attach and display the
        // indicator on top of the current view
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        // detach the indicator
        childProgressView.view.removeFromSuperview()
        // remove indicator view from parent
        childProgressView.removeFromParent()
    }
}
