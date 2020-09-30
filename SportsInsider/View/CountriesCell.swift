//
//  CountriesCell.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 17/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit
import SDWebImage
import DropDown

class CountriesCell: DropDownCell {

    var country: Countries?{
        didSet{
            configureCell()
        }
    }
    
    let countryCode: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "+"
        return label
    }()
    
    let flagImageView: UIImageView = {
       let iv = UIImageView()
        iv.setDimensions(height: 40, width: 40)
        iv.image = #imageLiteral(resourceName: "Person").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let countryName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Country Name"
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(){
        
        countryCode.text! += country?.callingCodes ?? ""
        flagImageView.sd_setImage(with: URL(string: country?.flag ?? ""), completed: nil)
        countryName.text = country?.name ?? ""
        
        let stack = UIStackView(arrangedSubviews: [countryCode, flagImageView, countryName])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.centerY(inView: self)
        stack.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 16)
    }
    
}
