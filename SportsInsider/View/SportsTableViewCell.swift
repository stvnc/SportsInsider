//
//  SportsTableViewCell.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 30/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit
import SDWebImage

class SportsTableViewCell: UITableViewCell {
    
    var sport: Sports?{
        didSet {
            configureCell()
        }
    }
    
    var sportsImage: UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Lock").withRenderingMode(.alwaysTemplate)
        iv.tintColor = .black
        iv.layer.cornerRadius = 150 / 2
        iv.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        iv.setDimensions(height: 100, width: 150)
        return iv
    }()
    
    var sportsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sports Name"
        label.font = UIFont.boldSystemFont(ofSize: 20)
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
        backgroundColor = .clear
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.masksToBounds = true
        
        sportsImage.sd_setImage(with: URL(string: sport?.sportsThumbnail ?? ""), completed: nil)
        addSubview(sportsImage)
        sportsImage.centerY(inView: self)
        sportsImage.anchor(left: leftAnchor, paddingLeft: 22)
        
        sportsLabel.text = sport?.sportsName
        addSubview(sportsLabel)
        sportsLabel.centerY(inView: self)
        sportsLabel.anchor(left: sportsImage.rightAnchor, paddingLeft: 15)
    }
    
}
