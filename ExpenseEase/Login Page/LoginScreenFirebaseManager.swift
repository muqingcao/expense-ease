//
//  LoginScreenFirebaseManager.swift
//  ExpenseEase
//
//  Created by Chang Lin on 11/25/24.
//

import Foundation
import FirebaseAuth

extension LoginScreenController {
    func loginUser(){
        //do the validations...
        if let email = loginScreen.textFieldEmail.text,
           let password = loginScreen.textFieldPassword.text{
            if (email == "" || !Utilities.validateEmail(email)) {
                self.present(Utilities.showErrorAlert("Invalid Email", "Please provide a valid Email"), animated: true)
            }

            else {
                //MARK: display the progress indicator...
                showActivityIndicator()
                Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
                    if error == nil{
                        //MARK: user authenticated...
                        //MARK: hide the progress indicator...
                        self.hideActivityIndicator()
                        self.navigationController?.popViewController(animated: false)
                    }else{
                        //MARK: alert that no user found or password wrong...
                        self.hideActivityIndicator()
                        self.present(Utilities.showErrorAlert("Unable to login user", "Please check email and password"), animated: true)
                    }
                })
                
            }
        }
        else{
            //alert....
        }
        
        
    }
}

