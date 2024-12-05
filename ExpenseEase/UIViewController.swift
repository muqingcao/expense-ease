//
//  UIViewController.swift
//  ExpenseEase
//
//  Created by Guangmei Xiang on 12/2/24.
//

import UIKit

extension UIViewController {
//    func navigateToLoginScreen() {
//        let loginViewController = LoginScreenController()
//        let navController = UINavigationController(rootViewController: loginViewController)
//        navController.modalPresentationStyle = .fullScreen
//        DispatchQueue.main.async {
//            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//               let window = windowScene.windows.first {
//                window.rootViewController = navController
//                window.makeKeyAndVisible()
//            } else {
//                print("No valid UIWindowScene found.")
//            }
//        }
//    }
    
    func navigateToWelcomeScreen() {
        let welcomePageController = ViewController()
        let navController = UINavigationController(rootViewController: welcomePageController)
        navController.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = navController
                window.makeKeyAndVisible()
            } else {
                print("No valid UIWindowScene found.")
            }
        }
    }
    
    
    
    func showErrorAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true, completion: nil)
    }
}

