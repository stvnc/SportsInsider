//
//  GenericTableViewController.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 03/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class GenericTableViewController<T, Cell: GenericTableViewCell>: UITableViewController {
    
    var items: [T]{
        didSet{
            tableView.reloadData()
        }
    }
    
    var configure: (Cell, T) -> Void
    
    init(items: [T], configure: @escaping(Cell, T) -> Void) {
        self.items = items
        self.configure = configure
        super.init(style: .plain)
        self.tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenericTableViewCell", for: indexPath) as! Cell
        let item  = items[indexPath.row]
        configure(cell, item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
    }
    
}

extension GenericTableViewController{
    
}
