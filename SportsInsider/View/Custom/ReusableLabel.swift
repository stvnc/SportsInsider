//
//  ReusableLabel.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 13/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class ReusableLabel: UILabel {
    
    init(text: String, size: CGFloat){
        super.init(frame: .zero)
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: size)
        self.textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
