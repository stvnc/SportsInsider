//
//  TeamMembers.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 20/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class TeamPlayersTableViewCell: UITableViewCell {
    
    var player: Player?{
        didSet{
            configureCell()
        }
    }
    
    let playerName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Player Name Placeholder"
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
        playerName.text = player?.name
        
        addSubview(playerName)
        playerName.centerY(inView: self)
        playerName.anchor(left: leftAnchor, paddingLeft: 8)
    }
}
