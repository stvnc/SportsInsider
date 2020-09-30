//
//  CustomContainerView.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 22/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class CustomContainerView: UIView {
    
    init(image: UIImage, textField: UITextField) {
        super.init(frame: .zero)
        setHeight(height: 50)
        
        let iv = UIImageView()
        iv.image = image
        iv.tintColor = .gray
        iv.alpha = 0.7
        
        addSubview(iv)
        iv.centerY(inView: self)
        iv.anchor(left: leftAnchor, paddingLeft: 8)
        iv.setDimensions(height: 24, width: 24)
        
        addSubview(textField)
        textField.centerY(inView: self)
        textField.anchor(left: iv.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 8, paddingBottom: 2)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .gray
        
        addSubview(dividerView)
        dividerView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 8, height: 0.75)
        
    }
    
    init(desc: String, value: String) {
        super.init(frame: .zero)
        
        let descText: ReusableLabel = {
            let rl = ReusableLabel(text: desc, size: 18)
            rl.textColor = .lightGray
            return rl
        }()
        
        let valueText: ReusableLabel = {
           let rl = ReusableLabel(text: value, size: 18)
            rl.setWidth(width: 150)
            rl.numberOfLines = 1
            return rl
        }()
        
        addSubview(descText)
        descText.anchor(left: leftAnchor, paddingLeft: 5)
        
        addSubview(valueText)
        valueText.anchor(left: descText.rightAnchor, right: rightAnchor, paddingLeft: 5, paddingRight: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

