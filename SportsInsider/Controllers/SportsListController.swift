//
//  EventListController.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 21/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

// Gonna add some API calls in here, this table view controller will display all fetched data

import UIKit

class SportsListController: UITableViewController {
    
    var context: String?{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView(){
        view.configureGradientLayer()
    }
}
