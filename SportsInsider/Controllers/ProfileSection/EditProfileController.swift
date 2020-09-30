//
//  EditProfileController.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 26/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.

// Add Listener for password textfield, if the password is the same as before, the button will still be disabled
//

import UIKit
import Firebase

private let reuseIdentifier = "EditProfileCell"

class EditProfileController: UIViewController {
    
    // MARK: - Properties
    
    var editProfileFooter: EditProfileFooter!
    
    var user: User?
    
    let profileImage: UIImageView =  {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "AppLogo").withRenderingMode(.alwaysOriginal)
        iv.setDimensions(height: 250, width: 250)
        iv.layer.cornerRadius = 250 / 2
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.gray.cgColor
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var emailContainer = EditProfileView(title: EditProfileEnum(rawValue: 0)?.description, data: user?.email)
    
    lazy var fullnameContainer = EditProfileView(title: EditProfileEnum(rawValue: 1)?.description, data: user?.fullname)
    
    lazy var phoneNumberContainer = EditProfileView(title: EditProfileEnum(rawValue: 2)?.description, data: user?.phoneNumber)
    
    lazy var countryCountainer = EditProfileView(title: EditProfileEnum(rawValue: 3)?.description, data: user?.country)
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.setDimensions(height: 50, width: 175)
        button.layer.cornerRadius = 175/8
        button.clipsToBounds = true
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(handleSubmitTapped), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    weak var delegate: EditProfileFooterDelegate?
    
    var buttonIsEnabled: Bool?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentUID = Auth.auth().currentUser?.uid
        
        user = RealmData.shared.loadData().filter("uid == '\(currentUID ?? "")'").first
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Selectors
    
    @objc func handleSubmitTapped(){
        print("Tapped")
        guard let email = emailContainer.dataContainer.text else { return }
        guard let fullname = fullnameContainer.dataContainer.text else { return }
        guard let phoneNumber = phoneNumberContainer.dataContainer.text else { return }
        guard let country = countryCountainer.dataContainer.text else { return }
        let credentialsValue = UserCredentials(email: email, fullname: fullname, phoneNumber: phoneNumber, country: country)
        
        RealmData.shared.updateData(user: user!, credentials: credentialsValue)
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        
        self.title = "Edit Profile"
        
        view.addSubview(profileImage)
        profileImage.centerX(inView: view)
        profileImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainer, fullnameContainer, phoneNumberContainer, countryCountainer])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.isUserInteractionEnabled = true
        
        emailContainer.isUserInteractionEnabled = false
        emailContainer.dataContainer.textColor = .systemGray
        
        view.addSubview(stack)
        stack.anchor(top: profileImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(submitButton)
        submitButton.centerX(inView: view)
        submitButton.anchor(top: stack.bottomAnchor, paddingTop: 70)
        
        editProfileFooter = .init(frame: CGRect(x: 0, y: 0, width: 175, height: 50))
        editProfileFooter.delegate = self
        
        view.addSubview(editProfileFooter)
        editProfileFooter.anchor(top: submitButton.bottomAnchor, left: submitButton.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: submitButton.rightAnchor)
    }
}

extension EditProfileController: EditProfileFooterDelegate{
    func handleLogout() {
        print("Logout Tapped")
        
        let alert = UIAlertController(title: nil, message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            self.dismiss(animated: true){
                Authentication.shared.logUserOut()
                self.navigationController?.pushViewController(HomeViewController(), animated: true)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    
}

