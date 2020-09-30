//
//  ProfileFooter.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 08/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

protocol EditProfileFooterDelegate: class {
    func handleLogout()
}

class EditProfileFooter: UIView {
    
    // MARK: - Properties
    
    weak var delegate: EditProfileFooterDelegate?
    
    var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        button.backgroundColor = .gray
        button.isUserInteractionEnabled = true
        return button
    } ()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Profile Footer Section")
        
        isUserInteractionEnabled = true
        
        addSubview(logoutButton)
        logoutButton.setDimensions(height: frame.height, width: frame.width)
        logoutButton.layer.cornerRadius = frame.width/8
        logoutButton.centerY(inView: self)
        logoutButton.centerX(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleLogout(){
        print("Logout Tapped!")
        delegate?.handleLogout()
    }
}

