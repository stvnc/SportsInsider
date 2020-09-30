//
//  RegisterViewController.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 21/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit
import DropDown

class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    
    var passwordValid = false
    
    let appIcon: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(height: 300, width: 300)
        iv.image = #imageLiteral(resourceName: "AppLogo").withRenderingMode(.automatic)
        return iv
    }()
    
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Email")
        return tf
    }()
    
    lazy var emailContainerView: CustomContainerView = {
        let cv = CustomContainerView(image: #imageLiteral(resourceName: "Person"), textField: emailTextField)
        return cv
    }()
    
    let fullnameTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Fullname")
        return tf
    }()
    
    lazy var fullnameContainerView: CustomContainerView = {
        let cv = CustomContainerView(image: #imageLiteral(resourceName: "Person"), textField: fullnameTextField)
        return cv
    }()
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var passwordContainerView: CustomContainerView = {
        let cv = CustomContainerView(image: #imageLiteral(resourceName: "Lock"), textField: passwordTextField)
        
        return cv
    }()
    
    let retypePasswordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Re-Type Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var retypePasswordContainerView: CustomContainerView = {
        let cv = CustomContainerView(image: #imageLiteral(resourceName: "Lock"), textField: retypePasswordTextField)
        return cv
    }()
    
    let phoneNumberTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Phone Number")
        return tf
    }()
    
    lazy var phoneNumberContainerView: CustomContainerView = {
        let cv = CustomContainerView(image: #imageLiteral(resourceName: "Lock"), textField: phoneNumberTextField)
        
        return cv
    }()
    
    lazy var countryDropdown: DropDown = {
        let menu = DropDown()
        menu.direction = .bottom
        menu.anchorView = countryContainerView
        return menu
    }()
    
    lazy var countryContainerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gestureRecognizer)
        view.setDimensions(height: 40, width: view.frame.width * 0.75)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(countryText)
        countryText.centerY(inView: view)
        countryText.anchor(left: view.leftAnchor, paddingLeft: 38)
        return view
    }()
    
    var countryText: UILabel = {
        let label = UILabel()
        label.text = "Country"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(height: 50, width: 200)
        button.layer.cornerRadius = 200/8
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    let loginButton: UIButton = {
        let button = AttributedButton(attribute: "Already have an account? Sign In", titleColor: .lightGray , bColor: .systemGroupedBackground)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    lazy var gestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleCountryTapped))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        return gesture
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureUI()
    }
    
    @objc func handleRegister(){
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let phoneNumber = phoneNumberTextField.text else { return }
        guard let country = countryText.text else { return }
        
        let credentials = RegistrationCredentials(email: email, password: password, fullname: fullname, phoneNumber: phoneNumber, country: country)
        
        Authentication.shared.registerUser(credentials: credentials) { error in
            if let error = error {
                print("Error registering user with error: \(error.localizedDescription)")
            } else {
                print("Successfully registered user!")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleSignIn(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCountryTapped(){
        print("Country tapped")
        countryDropdown.show()
        countryDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.countryText.text = item
        }
    }
    
    func configureUI(){
        view.backgroundColor = .systemGroupedBackground
        
        view.addSubview(appIcon)
        appIcon.centerX(inView: view)
        appIcon.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        
        let stackView = UIStackView(arrangedSubviews: [emailContainerView, fullnameContainerView, passwordContainerView, retypePasswordContainerView, phoneNumberContainerView, countryContainerView])
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        
        view.addSubview(stackView)
        stackView.anchor(top: appIcon.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 3, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(registerButton)
        registerButton.anchor(top: stackView.bottomAnchor, paddingTop: 25)
        registerButton.centerX(inView: view)
        
        view.addSubview(loginButton)
        loginButton.centerX(inView: view)
        loginButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 2)
    }
    
    func configureData(){
        var tempArray = [String]()
        NetworkLayer.shared.fetchAllCountries(completion: { result in
            result.forEach({ country in
                tempArray.append(country.name)
            })
            self.countryDropdown.dataSource = tempArray
        }) { error in
            print(error.localizedDescription)
        }
    }
}
