//
//  SideMenuCell.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 27/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    let menuLabel: UILabel = {
       let label = UILabel()
        label.text = "placeholder"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(){
        
        addSubview(menuLabel)
        menuLabel.centerY(inView: self)
        menuLabel.centerX(inView: self)
    }

}
