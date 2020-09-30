//
//  SearchViewController.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 26/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var players = [Player](){
        didSet{
            tableView.reloadData()
        }
    }
    
    var teams = [Teams](){
        didSet{
            tableView.reloadData()
        }
    }
    
    var events = [Events](){
        didSet{
            tableView.reloadData()
        }
    }
    
    let reuseIdentifier = "SearchCell"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    let items = ["Teams", "Players", "Events"]
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        return control
    }()
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureSearchController()
    }
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "This is a search bar"
        searchController.becomeFirstResponder()
        
        //        search.delegate = self
        
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    
    func configureView(){
        view.backgroundColor = .white
        view.addSubview(segmentedControl)
        
        segmentedControl.centerX(inView: view)
        segmentedControl.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(tableView)
        tableView.anchor(top: segmentedControl.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,  paddingTop: 15, paddingLeft: 16, paddingRight: 16)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.insetsLayoutMarginsFromSafeArea = false
        tableView.register(SearchCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedIndex = segmentedControl.selectedSegmentIndex
        
        if selectedIndex == 0 {
            let controller = TeamResultController()
            controller.team = teams[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        } else if selectedIndex == 1 {
            let controller = PlayerResultController()
            controller.player = players[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if teams.count != 0 {
            return teams.count
        } else if players.count != 0 {
            return players.count
        } else if events.count != 0 {
            return events.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        
        let selectedIndex = segmentedControl.selectedSegmentIndex
        
        if selectedIndex == 0 {
            cell.model = teams[indexPath.row]
        } else if selectedIndex == 1{
            cell.model = players[indexPath.row]
        } else {
            cell.model = events[indexPath.row]
        }
        
        return cell
        
        
    }
    
    
}

extension SearchViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text!
        let selectedIndex = segmentedControl.selectedSegmentIndex
        let searchParameter = items[selectedIndex].lowercased()
        
        if selectedIndex == 0 {
            NetworkLayer.shared.fetchBySearch(searchParameter: searchParameter, searchName: searchText) { result in
                self.teams = result.teams
            }
        }
        else if selectedIndex == 1 {
            NetworkLayer.shared.fetchBySearch(searchParameter: searchParameter, searchName: searchText) { result in
                self.players = result.player
            }
        } else {
            NetworkLayer.shared.fetchBySearch(searchParameter: searchParameter, searchName: searchText) { result in
                self.events = result.events
            }
        }
        
    }
}
