//
//  EventViewController.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 20/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    var event: Events?{
        didSet{
            configureData()
        }
    }
    
    let homeTeamView = TeamDescView(frame: CGRect(x: 0, y: 0, width: 250, height: 400))
    let awayTeamView = TeamDescView(frame: CGRect(x: 0, y: 0, width: 250, height: 400))
    
    var homeTeam: Teams?{
        didSet{
            homeTeamView.team = homeTeam
        }
    }
    var awayTeam: Teams?{
        didSet{
            awayTeamView.team = awayTeam
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        view.backgroundColor = .systemGroupedBackground

        let hStack = UIStackView(arrangedSubviews: [homeTeamView, awayTeamView])
        hStack.axis = .horizontal
        hStack.spacing = 10
        hStack.distribution = .fillEqually

        view.addSubview(hStack)
        hStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 8, paddingRight: 8)
    }
    
    func configureData(){
        guard let homeTeamID = event?.homeTeam else { return }
        guard let awayTeamID = event?.awayTeam else { return }
        
        NetworkLayer.shared.fetchTeamBySpecificID(id: homeTeamID, completion: { result in
            self.homeTeam = result.teams[0]
        }) { error in
            print("Error: \(error.localizedDescription)")
        }
        
        NetworkLayer.shared.fetchTeamBySpecificID(id: awayTeamID, completion: { result in
            self.awayTeam = result.teams[0]
        }) { error in
            print("Error: \(error.localizedDescription)")
        }
    }
}
