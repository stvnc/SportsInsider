//
//  HistoryTableViewCell.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 27/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let searchID: UILabel = {
       let label = UILabel()
        label.text = "Search ID"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let eventName: UILabel = {
        let label = UILabel()
        label.text = "Event Name"
        return label
    }()
    
    let searchDate: UILabel = {
        let label = UILabel()
        label.text = "Search Date"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureCell(){
        let vStack = UIStackView(arrangedSubviews: [searchID, eventName])
        vStack.axis = .vertical
        vStack.spacing = 10
        
        let hStack = UIStackView(arrangedSubviews: [vStack, searchDate])
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing
        hStack.spacing = 10
        
        addSubview(hStack)
        hStack.centerY(inView: self)
        hStack.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 16)
    }
    
    
}
