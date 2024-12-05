//
//  ProfilePageView.swift
//  ExpenseEase
//
//  Created by Guangmei Xiang on 10/23/24.
//

import UIKit

class ProfilePageView: UIView {
    
    var profileImage: UIImageView!
    var editProfileButton: UIButton!
    var emailLabel: UILabel!
    var resetPasswordButton: UIButton!
    var helpFeedbackButton: UIButton!
    var privatePolicyButton: UIButton!
    var closeAccountButton: UIButton!
    var logoutButton: UIButton!
    //var homeButton: UIButton!
    //var trendingButton: UIButton!
    //var settingButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        
        setupProfileImage()
        setupEditProfileButton()
        setupEmailLabel()
        setupResetPasswordButton()
        setupHelpFeedbackButton()
        setupPrivatePolicyButton()
        setupCloseAccountButton()
        setupLogoutButton()
        //setupHomeButton()
        //setupTrendingButton()
        //setupSettingButton()
        
        initConstraints()
    }

    
    func setupProfileImage(){
        profileImage = UIImageView()
        profileImage.image = UIImage(systemName: "person.circle")
        profileImage.tintColor = .black
        profileImage.contentMode = .scaleAspectFit
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileImage)
    }
    
    func setupEditProfileButton(){
        editProfileButton = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "pencil.line")
        config.title = "Edit your profile"
        config.imagePlacement = .trailing
        editProfileButton.configuration = config
        editProfileButton.tintColor = .black
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(editProfileButton)
    }
    
    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.text = "Enter your Email Address"
        emailLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        emailLabel.textColor = UIColor.darkGray
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailLabel)
    }
    
    func setupResetPasswordButton(){
        resetPasswordButton = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.title = "Reset your Password"
        config.image = UIImage(systemName: "lock")
        config.imagePadding = 6
        config.imagePlacement = .leading
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        resetPasswordButton.configuration = config
        resetPasswordButton.tintColor = .black
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(resetPasswordButton)
    }
    
    func setupHelpFeedbackButton(){
        helpFeedbackButton = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.title = "Help and Feedback"
        config.image = UIImage(systemName: "questionmark.circle")
        config.imagePadding = 6
        config.imagePlacement = .leading
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        helpFeedbackButton.configuration = config
        helpFeedbackButton.tintColor = .black
        helpFeedbackButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(helpFeedbackButton)
    }
    
    func setupPrivatePolicyButton(){
        privatePolicyButton = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.title = "Private Policy"
        config.image = UIImage(systemName: "doc.text")
        config.imagePadding = 6
        config.imagePlacement = .leading
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        privatePolicyButton.configuration = config
        privatePolicyButton.tintColor = .black
        privatePolicyButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(privatePolicyButton)
    }
    
    func setupCloseAccountButton(){
        closeAccountButton = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.title = "Close your account"
        config.image = UIImage(systemName: "xmark")
        config.imagePadding = 6
        config.imagePlacement = .leading
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        closeAccountButton.configuration = config
        closeAccountButton.tintColor = .black
        closeAccountButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(closeAccountButton)
    }
    
    func setupLogoutButton(){
        logoutButton = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.title = "Log out"
        config.image = UIImage(systemName: "arrow.forward.square")
        config.imagePadding = 6
        config.imagePlacement = .leading
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        logoutButton.configuration = config
        logoutButton.setTitleColor(.red, for: .normal)
        logoutButton.tintColor = .red
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoutButton)
    }
    
//    func setupHomeButton(){
//        homeButton = UIButton(type: .system)
//        var config = UIButton.Configuration.plain()
//        config.image = UIImage(systemName: "house.fill")
//        config.title = "Home"
//        let font = UIFont.systemFont(ofSize: 12)
//        config.attributedTitle = AttributedString("Home", attributes: AttributeContainer([.font: font]))
//        config.imagePadding = 2
//        config.imagePlacement = .top
//        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//        homeButton.configuration = config
//        homeButton.tintColor = .black
//        homeButton.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(homeButton)
//        
//    }
//    
//    func setupTrendingButton(){
//        trendingButton = UIButton(type: .system)
//        var config = UIButton.Configuration.plain()
//        config.image = UIImage(systemName: "chart.bar")
//        config.title = "Trending"
//        let font = UIFont.systemFont(ofSize: 12)
//        config.attributedTitle = AttributedString("Trending", attributes: AttributeContainer([.font: font]))
//        config.imagePadding = 2
//        config.imagePlacement = .top
//        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//        trendingButton.configuration = config
//        trendingButton.tintColor = .black
//        trendingButton.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(trendingButton)
//        
//    }
//    
//    func setupSettingButton(){
//        settingButton = UIButton(type: .system)
//        var config = UIButton.Configuration.plain()
//        config.image = UIImage(systemName: "gearshape.fill")
//        config.title = "Setting"
//        let font = UIFont.systemFont(ofSize: 12)
//        config.attributedTitle = AttributedString("Setting", attributes: AttributeContainer([.font: font]))
//        config.imagePadding = 2
//        config.imagePlacement = .top
//        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//        settingButton.configuration = config
//        settingButton.tintColor = .black
//        settingButton.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(settingButton)
//    }
    
    func updateProfileButtonTitle(with name: String) {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "pencil.line")
        config.title = name
        config.imagePlacement = .trailing
        editProfileButton.configuration = config
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            
            editProfileButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            editProfileButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 10),
            emailLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            resetPasswordButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 40),
            resetPasswordButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            helpFeedbackButton.topAnchor.constraint(equalTo: resetPasswordButton.bottomAnchor, constant: 25),
            helpFeedbackButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            privatePolicyButton.topAnchor.constraint(equalTo: helpFeedbackButton.bottomAnchor, constant: 25),
            privatePolicyButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            closeAccountButton.topAnchor.constraint(equalTo: privatePolicyButton.bottomAnchor, constant: 25),
            closeAccountButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            logoutButton.topAnchor.constraint(equalTo: closeAccountButton.bottomAnchor, constant: 25),
            logoutButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
//            homeButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
//            homeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
//            
//            trendingButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
//            trendingButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            
//            settingButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
//            settingButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
