//
//  EditProfilePageView.swift
//  ExpenseEase
//
//  Created by Guangmei Xiang on 10/23/24.
//
import UIKit

class EditProfilePageView: UIView {

    var profileImageButton: UIButton!
    var firstNameLabel: UILabel!
    var lastNameLabel: UILabel!
    var textFieldfirstName: UITextField!
    var textFieldlastName: UITextField!


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        setupProfileImageButton()
        setupFirstNameLabel()
        setupLastNameLabel()
        setuptextfieldFristName()
        setuptextfieldLastName()

        initConstraints()
    }

    func setupProfileImageButton() {
        profileImageButton = UIButton(type: .system)
        profileImageButton.setImage(UIImage(systemName: "person.circle"), for: .normal)
        profileImageButton.imageView?.contentMode = .scaleAspectFill
        profileImageButton.contentHorizontalAlignment = .fill
        profileImageButton.contentVerticalAlignment = .fill
        profileImageButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageButton.showsMenuAsPrimaryAction = true
        profileImageButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileImageButton)
    }

    func setupFirstNameLabel() {
        firstNameLabel = UILabel()
        firstNameLabel.text = "First Name"
        firstNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(firstNameLabel)
    }

    func setupLastNameLabel() {
        lastNameLabel = UILabel()
        lastNameLabel.text = "Last Name"
        lastNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lastNameLabel)
    }

    func setuptextfieldFristName(){
        textFieldfirstName = UITextField()
        textFieldfirstName.placeholder = ""
        textFieldfirstName.borderStyle = .none
        textFieldfirstName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldfirstName)

        let nameUnderline = UIView()
        nameUnderline.backgroundColor = .lightGray
        nameUnderline.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameUnderline)


        NSLayoutConstraint.activate([
            nameUnderline.topAnchor.constraint(equalTo: textFieldfirstName.bottomAnchor, constant: 2),
            nameUnderline.leadingAnchor.constraint(equalTo: textFieldfirstName.leadingAnchor),
            nameUnderline.trailingAnchor.constraint(equalTo: textFieldfirstName.trailingAnchor),
            nameUnderline.heightAnchor.constraint(equalToConstant: 1)
        ])
    }


    func setuptextfieldLastName(){
        textFieldlastName = UITextField()
        textFieldlastName.placeholder = ""
        textFieldlastName.borderStyle = .none
        textFieldlastName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldlastName)
        
        let lastNameUnderline = UIView()
        lastNameUnderline.backgroundColor = .lightGray
        lastNameUnderline.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lastNameUnderline)

        NSLayoutConstraint.activate([
            lastNameUnderline.topAnchor.constraint(equalTo: textFieldlastName.bottomAnchor, constant: 2),
            lastNameUnderline.leadingAnchor.constraint(equalTo: textFieldlastName.leadingAnchor),
            lastNameUnderline.trailingAnchor.constraint(equalTo: textFieldlastName.trailingAnchor),
            lastNameUnderline.heightAnchor.constraint(equalToConstant: 1)
        ])
    }


    func initConstraints() {
        NSLayoutConstraint.activate([

            profileImageButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileImageButton.heightAnchor.constraint(equalToConstant: 100),
            profileImageButton.widthAnchor.constraint(equalToConstant: 100),

            firstNameLabel.topAnchor.constraint(equalTo: profileImageButton.bottomAnchor, constant: 30),
            firstNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            firstNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            textFieldfirstName.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 8),
            textFieldfirstName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldfirstName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textFieldfirstName.heightAnchor.constraint(equalToConstant: 30),

            lastNameLabel.topAnchor.constraint(equalTo: textFieldfirstName.bottomAnchor, constant: 20),
            lastNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            lastNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            textFieldlastName.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 8),
            textFieldlastName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldlastName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textFieldlastName.heightAnchor.constraint(equalToConstant: 30),
        ])
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
