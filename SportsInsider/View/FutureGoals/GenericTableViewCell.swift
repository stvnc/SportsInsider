//
//  GenericTableViewCell.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 03/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

// make T Conform to Result Protocol, and all other model to result protocol
// so we can use this one cell with different models

class GenericTableViewCell: UITableViewCell {
    
    var model: ResultProtocol? {
        didSet{
            configureCell()
        }
    }
    
    var labelText: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
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
        backgroundColor = .white
        labelText.text = model?.name
        
        addSubview(labelText)
        labelText.centerX(inView: self)
        labelText.centerY(inView: self)
        
    }
}
