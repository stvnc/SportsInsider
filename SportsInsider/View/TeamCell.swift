//
//  TeamCell.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 07/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {
    
    // MARK: - Properties
    
    let teamName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Team Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let teamDescription: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    
    let teamBadge: UIImageView = {
       let iv = UIImageView()
        iv.setDimensions(height: 50, width: 50)
        iv.image = #imageLiteral(resourceName: "AppLogo").withRenderingMode(.alwaysOriginal)
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(){
        
        let vStack = UIStackView(arrangedSubviews: [teamName, teamDescription])
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.distribution = .fillEqually
        
        let hStack = UIStackView(arrangedSubviews: [vStack, teamBadge])
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing
        hStack.spacing = 10
        
        addSubview(hStack)
        hStack.centerY(inView: self)
        hStack.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 16)
    }
    
    
}
