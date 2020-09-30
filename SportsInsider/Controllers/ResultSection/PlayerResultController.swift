//
//  PlayerResultController.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 13/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit
import SDWebImage

class PlayerResultController: UIViewController {
    
    var player: Player?{
        didSet{
            configurePlayerData()
        }
    }
    
    let playerPhoto: UIImageView = {
       let iv = UIImageView()
        iv.setDimensions(height: 200, width: 200)
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.gray.cgColor
        iv.layer.borderWidth = 1
        iv.layer.cornerRadius = 200/2
        iv.image = #imageLiteral(resourceName: "Person").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let playerName = ReusableLabel(text: resultTitle[0], size: resultTextSize)
    let playerAge = ReusableLabel(text: resultTitle[1], size: resultTextSize)
    let playerWage = ReusableLabel(text: resultTitle[2], size: resultTextSize)
    let playerPosition = ReusableLabel(text: resultTitle[3], size: resultTextSize)
    
    let playerBiography: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configurePlayerData(){
        
        self.title = player?.name
        
        playerPhoto.sd_setImage(with: URL(string: player?.image ?? ""), completed: nil)
        playerName.text = player?.name
        playerAge.text = player?.dateOfBirth
        playerWage.text = player?.wage
        playerPosition.text = player?.desc
        playerBiography.text = player?.biography
    }
    
    
    func configureUI(){
        
        view.backgroundColor = .white
        
        view.addSubview(playerPhoto)
        playerPhoto.centerX(inView: view)
        playerPhoto.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        
        let dataStack = UIStackView(arrangedSubviews: [playerName, playerAge, playerWage, playerPosition])
        dataStack.axis = .vertical
        dataStack.spacing = 8
        dataStack.alignment = .center
        dataStack.distribution = .fillProportionally
        
        view.addSubview(dataStack)
        dataStack.anchor(top: playerPhoto.bottomAnchor, paddingTop: 20)
        dataStack.centerX(inView: view)
        
        view.addSubview(playerBiography)
        playerBiography.anchor(top: dataStack.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 8, paddingRight: 16)
    }
}
