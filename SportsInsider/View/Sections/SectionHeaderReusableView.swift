//
//  SectionHeader.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 21/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class SectionHeaderReusableView: UICollectionReusableView {
    var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.anchor(top: topAnchor, left: leftAnchor, paddingTop: 5, paddingLeft: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
