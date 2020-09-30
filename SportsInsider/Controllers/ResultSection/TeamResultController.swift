//
//  TeamResultController.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 13/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit
import SDWebImage

class TeamResultController: UIViewController {
    
    let reuseIdentifier = "SearchCell"
    
    let scrollView = UIScrollView()
    
    var team: Teams? {
        didSet{
            configureTeamData()
        }
    }
    
    let teamBadge: UIImageView = {
       let iv = UIImageView()
        iv.setDimensions(height: 250, width: 250)
        iv.image = #imageLiteral(resourceName: "Person").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    lazy var teamBoxView: TeamResultBoxView = {
       let tb = TeamResultBoxView()
        tb.setDimensions(height: 110, width: 260)
        return tb
    }()
    
    let teamDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let playersTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureTableView()
        configureUI()
        
    }
    
    func configureTeamData(){
        
        self.title = team?.name
        teamBadge.sd_setImage(with: URL(string: team?.image ?? ""), completed: nil)
        teamDescription.text = team?.desc
        teamBoxView.team = team
    }
    
    func configureTableView(){
        playersTableView.register(SearchCell.self, forCellReuseIdentifier: reuseIdentifier)
        playersTableView.delegate = self
        playersTableView.dataSource = self
    }
    
    func configureUI(){
        
        view.addSubview(scrollView)
        scrollView.setDimensions(height: view.frame.height, width: view.frame.width)
        scrollView.contentSize = view.bounds.size
        
        scrollView.setContentOffset(CGPoint(x: self.scrollView.contentOffset.x, y: 0), animated: true)
        scrollView.isDirectionalLockEnabled = true
        scrollView.backgroundColor = .systemGroupedBackground
        
        scrollView.addSubview(teamBadge)
        teamBadge.centerX(inView: scrollView)
        teamBadge.anchor(top: scrollView.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        
        scrollView.addSubview(teamBoxView)
        teamBoxView.anchor(top: teamBadge.bottomAnchor, paddingTop: 15 )
        teamBoxView.centerX(inView: scrollView)
        
        scrollView.addSubview(teamDescription)
        teamDescription.anchor(top: teamBoxView.bottomAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 15, paddingLeft: 16, paddingRight: 16)
        
//        scrollView.addSubview(playersTableView)
//        playersTableView.anchor(top: teamDescription.bottomAnchor, left: teamDescription.leftAnchor, bottom: scrollView.safeAreaLayoutGuide.bottomAnchor, right: teamDescription.rightAnchor, paddingTop: 10)
    }
    
}

extension TeamResultController: UITableViewDelegate {
    
}

extension TeamResultController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
    
    
}
