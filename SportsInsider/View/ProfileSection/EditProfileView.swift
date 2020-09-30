//
//  EditProfileCell.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 14/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class EditProfileView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "Title"
        return label
    }()
    
    var dataContainer = CustomTextField(placeholder: "Data")
    
    init(title: String?, data: String?){
        super.init(frame: .zero)
        
        guard let title = title else { return }
        guard let data  = data else { return }
        configureCell(title: title, data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(title: String, data: String){
        
        setHeight(height: 60)
        titleLabel.text = title
        dataContainer.text = data
        
        addSubview(titleLabel)
        titleLabel.centerY(inView: self)
        titleLabel.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 16)
        
        addSubview(dataContainer)
        dataContainer.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
    }
}
