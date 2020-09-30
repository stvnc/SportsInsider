//
//  TeamResultBoxView.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 22/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class TeamResultBoxView: UIView {
    
    // founded stadium location country
    
    var team: Teams?{
        didSet{
            configureView()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Box View Initialized!")
        configureView()
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func configureView(){
        layer.frame = frame
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
        clipsToBounds = true
        
        let foundedContainer = CustomContainerView(desc: founded, value: team?.founded ?? "")
        let stadiumContainer = CustomContainerView(desc: stadium, value: team?.stadium ?? "")
        let locationContainer = CustomContainerView(desc: location, value: team?.location ?? "")
        let countryContainer = CustomContainerView(desc: country, value: team?.country ?? "")
        
        let stack = UIStackView(arrangedSubviews: [foundedContainer, stadiumContainer, locationContainer, countryContainer])
        
        stack.axis = .vertical
        stack.spacing = 25
        stack.distribution = .fillProportionally
//        stack.alignment = .center
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 10)
    }
}
