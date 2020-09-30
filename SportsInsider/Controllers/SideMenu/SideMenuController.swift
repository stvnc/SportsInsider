//
//  SideMenuController.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 27/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit
import SideMenu

protocol SideMenuControllerDelegate: class {
    func handleLogout()
}

class SideMenuController: UITableViewController {
    
    let itemLabel = ["Search", "Profile"]
    
    let controllers = [SearchViewController(), ProfileController()]
    
    
//    let navigations = [EventListController(), EventListController(), EventListController()]
    
    let reuseIdentifier = "SideMenuCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView(){
        
        tableView.backgroundColor = .black
        tableView.register(SideMenuCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
}

extension SideMenuController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SideMenuCell
        cell.menuLabel.text = itemLabel[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}

extension SideMenuController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = controllers[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}
