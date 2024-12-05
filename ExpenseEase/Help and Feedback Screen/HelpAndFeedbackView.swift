//
//  HelpAndFeedbackView.swift
//  ExpenseEase
//
//  Created by Guangmei Xiang on 10/29/24.
//

import UIKit

class HelpAndFeedbackView: UIView {
    var containerView: UIView!
    var subtitleLabel: UILabel!
    var messageButton: UIButton!
    var communityButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupsubtitle()
        setupmessagebutton()
        setupCommunityButton()
        initConstraints()
        
    }
    
    func setupsubtitle() {
        subtitleLabel = UILabel()
        subtitleLabel.text = "We are here to support you!"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = .darkGray
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subtitleLabel)
    }
    func setupCommunityButton() {
            communityButton = UIButton(type: .system)
            var config = UIButton.Configuration.plain()
            config.title = "Customer Community"
            config.image = UIImage(systemName: "bubble.left.and.bubble.right.fill")
            config.imagePadding = 6
            config.imagePlacement = .leading
            config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            communityButton.configuration = config
            communityButton.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
            communityButton.layer.cornerRadius = 8
            communityButton.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(communityButton)
        }
    
    func setupmessagebutton(){
        messageButton = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.title = "Send Us a Message"
        config.image = UIImage(systemName: "envelope.open.fill")
        config.imagePadding = 6
        config.imagePlacement = .leading
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        messageButton.configuration = config
        messageButton.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        messageButton.layer.cornerRadius = 8
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(messageButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            subtitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            communityButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            communityButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            communityButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            communityButton.heightAnchor.constraint(equalToConstant: 70),
            
            
            messageButton.topAnchor.constraint(equalTo: communityButton.bottomAnchor, constant: 20),
            messageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            messageButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            messageButton.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



