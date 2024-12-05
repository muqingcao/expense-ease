//
//  SignupScreenFirebaseManager.swift
//  ExpenseEase
//
//  Created by Chang Lin on 11/25/24.
//

import Foundation
import FirebaseAuth


extension SignupScreenController{
    
    func signupNewAccount(){
        //MARK: create a Firebase user with email and password...
        if let firstName = signupScreen.textFieldFirstName.text,
            let lastName = signupScreen.textFieldLastName.text,
           let email = signupScreen.textFieldEmail.text,
           let password = signupScreen.textFieldPassword.text
        {
            if (email == "" || !Utilities.validateEmail(email)) {
                self.present(Utilities.showErrorAlert("Invalid Email", "Please provide a valid Email"), animated: true)
            }else if (password == "" || password.count < 6) {
                self.present(Utilities.showErrorAlert("Invalid Password", "Please provide a password that is least 6 characters long"), animated: true)
            } else if (firstName == "") {
                self.present(Utilities.showErrorAlert("Invalid First Name", "Please provide a valid first name"), animated: true)
            } else if (lastName == "") {
                self.present(Utilities.showErrorAlert("Invalid Last Name", "Please provide a valid last name"), animated: true)
            } else if !agreedTerms {
                self.present(Utilities.showErrorAlert("Error", "Please agree terms to proceed"), animated: true)
            }
            else {
                //MARK: display the progress indicator...
                showActivityIndicator()
                Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                    if error == nil{
                        //MARK: the user creation is successful...
                        self.setNameOfTheUserInFirebaseAuth(email: email, firstName: firstName, lastName: lastName)
                    }else{
                        self.hideActivityIndicator()
                        self.present(Utilities.showErrorAlert("Unable to register user", "This email is already registered"), animated: true)
                    }
                })
            }
        }
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(email: String, firstName: String, lastName: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = firstName + " " + lastName
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                self.saveUserInFirestore(email: email, firstName: firstName, lastName: lastName)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    //MARK: We save the newly registered user information into Firestrore
    func saveUserInFirestore(email: String, firstName: String, lastName: String) {
        let userDocument = database.collection("users")
                                     .document(email)
        userDocument.setData(["firstName": firstName, "lastName": lastName, "email": email, "photoUrl": ""])
        //MARK: hide the progress indicator...
        self.hideActivityIndicator()
        // let the welcome screen know the user is registered,
        // no need to log in again
//        self.notificationCenter.post(
//            name: Notification.Name("userRegistered"),
//            object: nil)
        self.navigationController?.popViewController(animated: false)
        
    }
}
