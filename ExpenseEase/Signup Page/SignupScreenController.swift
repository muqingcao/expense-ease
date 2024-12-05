//
//  SignupScreenController.swift
//  ExpenseEase
//
//  Created by Chang Lin on 10/23/24.
//

import UIKit
import FirebaseFirestore

class SignupScreenController: UIViewController {
    
    let signupScreen = SignupScreen()
    let childProgressView = ProgressSpinnerViewController()
    //MARK: instantiating the Notification center...
    let notificationCenter = NotificationCenter.default
    let database = Firestore.firestore()
    var agreedTerms = false
    
    override func loadView() {
        view = signupScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        title = "Expense Ease"
        
        signupScreen.buttonSignup.addTarget(self, action: #selector(onSignupTapped), for: .touchUpInside)
        
        //MARK: checkboxAgreement target...
        signupScreen.buttonAgreed
            .addTarget(self, action: #selector(onCheckboxAgreementTapped), for: .touchUpInside)
        
        //MARK: buttonSignup target...
        signupScreen.buttonLogin
            .addTarget(self, action: #selector(onButtonLoginTapped), for: .touchUpInside)
          
    }
    
    @objc func onSignupTapped(){
        //MARK: creating a new user on Firebase...
        signupNewAccount()
    }
    
    @objc func onCheckboxAgreementTapped() {
        if (agreedTerms == false) {
            signupScreen.buttonAgreed.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            agreedTerms = true
        } else {
            signupScreen.buttonAgreed.setImage(UIImage(systemName: "square"), for: .normal)
            agreedTerms = false
        }
    }
    
    @objc func onButtonLoginTapped() {
        self.notificationCenter.post(
            name: Notification.Name("loginRequest"),
            object: nil)
        self.navigationController?.popViewController(animated: false)
    }


}

extension SignupScreenController:ProgressSpinnerDelegate{
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
