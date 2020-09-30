//
//  EventCollectionViewCell.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 20/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    var event: Events?{
        didSet {
            configureCell()
        }
    }
    
    let eventImage: UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Lock").withRenderingMode(.alwaysTemplate)
        iv.backgroundColor = .purple
        iv.layer.cornerRadius = 100 / 4
        iv.clipsToBounds = true
        iv.setDimensions(height: 100, width: 100)
        
        return iv
    }()
    
    lazy var eventLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Event Name"
        label.numberOfLines = 0
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(){
        
        eventImage.sd_setImage(with: URL(string: event?.image ?? ""), completed: nil)
        
        addSubview(eventImage)
        
        eventImage.centerY(inView: self)
        eventImage.anchor(left: leftAnchor, paddingLeft: 16)
        
        eventLabel.text = event?.name
        
        addSubview(eventLabel)
        eventLabel.anchor(top: eventImage.bottomAnchor, bottom: bottomAnchor, paddingTop: 2, paddingBottom: 5)
        eventLabel.centerX(inView: self)
    }
}
