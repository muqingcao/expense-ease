//
//  ViewController.swift
//  ExpenseEase
//
//  Created by Chang Lin on 10/20/24.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    let welcomeScreen = WelcomeScreen()
    //MARK: instantiating the Notification center...
    let notificationCenter = NotificationCenter.default
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    
    override func loadView() {
        view = welcomeScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                self.currentUser = nil
                
            }else{
                //MARK: the user is signed in...
                self.currentUser = user
                let mainTabBarController = MainTabBarController()
//                mainTabBarController.currentUser = self.currentUser
                self.navigationController?.pushViewController(mainTabBarController, animated: false)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: buttonLogin target...
        welcomeScreen.buttonLogin
            .addTarget(self, action: #selector(onButtonLoginTapped), for: .touchUpInside)
        
        //MARK: buttonSignup target...
        welcomeScreen.buttonSignup
            .addTarget(self, action: #selector(onButtonSignupTapped), for: .touchUpInside)

        //MARK: observing signup request in NotificationCenter...
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForSignupRequest(notification:)),
            name: .signupRequest,
            object: nil)
        
        //MARK: observing login request in NotificationCenter...
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForLoginRequest(notification:)),
            name: .loginRequest,
            object: nil)
    }
    
    @objc func notificationReceivedForSignupRequest(notification: Notification){
        //        DispatchQueue.main.async {
        //            self.navigationController?.popViewController(animated: false)
        //        }
        // MARK: first pop off login screen, then push register screen
        self.navigationController?.popViewController(animated: false)
        let signupScreenController = SignupScreenController()
        self.navigationController?.pushViewController(signupScreenController, animated: false)
    }
        
    @objc func notificationReceivedForLoginRequest(notification: Notification){
        // MARK: first pop off signup screen, then push login screen
        self.navigationController?.popViewController(animated: false)
        let logInScreenController = LoginScreenController()
        self.navigationController?.pushViewController(logInScreenController, animated: false)
    }
    
    
     @objc func onButtonLoginTapped(){
         let loginScreen = LoginScreenController()
         navigationController?.pushViewController(loginScreen, animated: true)
     }
    
    
     @objc func onButtonSignupTapped(){
         let signupScreen = SignupScreenController()
         navigationController?.pushViewController(signupScreen, animated: true)
     }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }

}

