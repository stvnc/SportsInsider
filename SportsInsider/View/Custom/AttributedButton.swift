//
//  AttributedButton.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 22/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class AttributedButton: UIButton {
    
    init(attribute: String, titleColor: UIColor, bColor: UIColor) {
        super.init(frame: .zero)
        backgroundColor = bColor
        setTitle(attribute, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        setTitleColor(titleColor, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
