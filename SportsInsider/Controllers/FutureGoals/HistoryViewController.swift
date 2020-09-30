//
//  HistoryViewController.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 26/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {
    
    let reuseIdentifier = "HistoryTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    func configureTableView(){
        view.backgroundColor = .white
        
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

}


extension HistoryViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! HistoryTableViewCell
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}

extension HistoryViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
