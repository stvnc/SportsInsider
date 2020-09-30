//
//  CustomHeaderView.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 18/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class CustomHeaderView: UIView {
    
    let headerView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return view
    }()
    
    let headerText: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    init(headerLabel: String){
        super.init(frame: .zero)
        headerText.text = headerLabel
        
        addSubview(headerText)
        headerText.centerY(inView: self)
        headerText.anchor(left: leftAnchor, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
