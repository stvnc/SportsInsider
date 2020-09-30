//
//  LoginController.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 21/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
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
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var passwordContainerView: CustomContainerView = {
        let cv = CustomContainerView(image: #imageLiteral(resourceName: "Lock"), textField: passwordTextField)
       
        return cv
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(height: 50, width: 175)
        button.layer.cornerRadius = 175/8
        button.clipsToBounds = true
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    
        return button
    }()
    
    let registerButton: UIButton = {
        let button = AttributedButton(attribute: "Dont have an account? Sign Up", titleColor: .lightGray, bColor: .systemGroupedBackground)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleLogin(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Authentication.shared.logUserIn(withEmail: email, password: password) { (_, error) in
            if let error = error {
                print("Error logging user in with \(error.localizedDescription)")
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleSignUp(){
        let controller = RegisterViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        
        view.backgroundColor = .systemGroupedBackground
        
        view.addSubview(appIcon)
        appIcon.centerX(inView: view)
        appIcon.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        
        let stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: appIcon.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(loginButton)
        loginButton.centerX(inView: view)
        loginButton.anchor(top: stackView.bottomAnchor, paddingTop: 30)
        
        view.addSubview(registerButton)
        registerButton.centerX(inView: view)
        registerButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 5)
    }
    
}
