//
//  TeamDescView.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 20/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit
import SDWebImage

class TeamDescView: UIView {
    
    var team: Teams?{
        didSet{
            configureData()
        }
    }
    
    let teamBadge: UIImageView =  {
        let iv = UIImageView()
        iv.setDimensions(height: 150, width: 150)
        iv.layer.cornerRadius = 150 / 2
        iv.clipsToBounds = true
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.gray.cgColor
        
        iv.image = #imageLiteral(resourceName: "Person").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let teamName: UILabel = {
        let label = UILabel()
        label.text = "Team Placeholder"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(){
        teamBadge.sd_setImage(with: URL(string: team?.image ?? ""), completed: nil)
        teamName.text = team?.name
    }
    
    func configureView(){
        backgroundColor = UIColor.clear
        
        let stack = UIStackView(arrangedSubviews: [teamBadge, teamName])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .equalSpacing
        
        addSubview(stack)
        stack.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 2, paddingRight: 2)
    }
    
    
}
