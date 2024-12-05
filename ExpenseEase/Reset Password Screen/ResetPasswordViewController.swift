//
//  ResetPasswordViewController.swift
//  ExpenseEase
//
//  Created by Guangmei Xiang on 12/2/24.
//

import UIKit
import FirebaseAuth


class ResetPasswordViewController: UIViewController {
   let resetPasswordScreen = ResetPasswordView()
    var currentUser: User?
    var handleAuth: AuthStateDidChangeListenerHandle?
   
    
    override func loadView() {
        view = resetPasswordScreen
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(onResetPassword)
        )
        
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)],
            for: .normal
        )
    }

    @objc func onResetPassword() {
            guard let newPassword = resetPasswordScreen.newPasswordTextField.text, !newPassword.isEmpty else {
                showErrorAlert(title: "Error", message: "Password cannot be empty.")
                return
            }
            
            resetUserPassword(newPassword: newPassword)
        }
        
    func resetUserPassword(newPassword: String) {
        Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
            if let error = error {
                self.showErrorAlert(title: "Error", message: error.localizedDescription)
            } else {
                self.showErrorAlert(title: "Success", message: "Password updated successfully. Please log in again.") {
                    self.handleLogout()
                    //self.navigateToWelcomeScreen()
                }
            }
        }
    }
    
    
    func handleLogout() {
        do {
            
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
    
}
