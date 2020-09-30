//
//  HomeViewController.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 20/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.


// TO DO: ADD Search bar on top of collectionviewcontroller, make a vc for sports, leagues, countries, etc 
//

import UIKit
import SideMenu
import Firebase
import SDWebImage

class HomeViewController: UIViewController {
    
    let eventIdentifier = "EventCollectionViewCell"
    let sectionIdentifier = "SectionHeaderReusableView"
    let sportsIdentifier = "SportsTableViewCell"
    
    var sports = [Sports]() {
        didSet{
            tableView.reloadData()
        }
    }
    var events = [Events]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var authenticated: Bool?
    
    
    
    private let sideMenu = SideMenuNavigationController(rootViewController: SideMenuController())
    
    
    let collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.sectionHeadersPinToVisibleBounds = true
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 80, height: 80), collectionViewLayout: layout)
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUserAndConfigureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
        authenticateUserAndConfigureUI()
        
//        UINavigationBar.appearance().backgroundColor = .clear
//        UINavigationBar.appearance().isTranslucent = true
    }
    
    @objc func didTapNavigationItem(){
        present(sideMenu, animated: true, completion: nil)
    }
    
    @objc func handleFuture(){
        print("Future project!")
    }
    
    func configureView(){
        self.title = appTitle
        
        view.backgroundColor = .systemGroupedBackground
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapNavigationItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleFuture))
        
        sideMenu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        view.addSubview(collectionView)
        collectionView.setDimensions(height:200, width: view.frame.width)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(tableView)
        tableView.anchor(top: collectionView.bottomAnchor, left: collectionView.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: collectionView.rightAnchor, paddingTop: 15, paddingBottom: 15)
    }
    
    func fetchAllDatas() {
        
        NetworkLayer.shared.fetchAllSports(completion: { results in
            self.sports = results.sports
            print("sportsList: \(self.sports)")
        }) { error in
                print("Error fetching sports data with \(error.localizedDescription)")
        }
        
        NetworkLayer.shared.fetchAllEvents(completion: { results in
            self.events = results.events
        }) { error in
            print("Error fetching events data with \(error.localizedDescription)")
        }
        
    }
    
    func configureCollectionView(){
        collectionView.register(SectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionIdentifier)
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: eventIdentifier)
        
//        collectionView.layer.cornerRadius = collectionView.frame.width/4
//        collectionView.layer.borderWidth = 2
//        collectionView.layer.borderColor = UIColor.white.cgColor
//        collectionView.layer.masksToBounds = true
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureTableView(){
        tableView.register(SportsTableViewCell.self, forCellReuseIdentifier: sportsIdentifier)
        
        tableView.backgroundColor = .clear
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func authenticateUserAndConfigureUI(){
        if Auth.auth().currentUser == nil{
            print("DEBUG: User is not logged in")
            DispatchQueue.main.async{
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
                
            }
        }else{
            configureView()
            configureCollectionView()
            configureTableView()
            fetchAllDatas()
        }
  
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(view.frame.width * 0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(view.frame.width * 0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: -50, bottom: 0, right: (view.frame.width * 0.1) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 50, height: CGFloat(50))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = EventViewController()
        controller.event = events[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventIdentifier, for: indexPath) as! EventCollectionViewCell
        cell.event = events[indexPath.row]
        print("Event: \(events[indexPath.row].name)")
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionIdentifier, for: indexPath) as! SectionHeaderReusableView
            sectionHeader.label.text = "Upcoming Events"
            sectionHeader.label.font = UIFont.boldSystemFont(ofSize: 20)
            sectionHeader.translatesAutoresizingMaskIntoConstraints = false
            sectionHeader.setDimensions(height: 35, width: view.frame.width)
            sectionHeader.backgroundColor = UIColor.clear
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("sportsCount: \(sports.count)")
        return sports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sportsIdentifier, for: indexPath) as! SportsTableViewCell
        cell.sport = sports[indexPath.row]
        print("Current Data: \(sports[indexPath.row].sportsName)")
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Sports"
//    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = SportsListController()
        
    
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return CustomHeaderView(headerLabel: "Sports")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    
}
//
//extension HomeViewController: EditProfileFooterDelegate {
//    func handleLogout() {
//        Authentication.shared.logUserOut()
//        let nav = UINavigationController(rootViewController: LoginController())
//        nav.modalPresentationStyle = .fullScreen
//        self.present(nav, animated: true, completion: nil)
//    }
//    
//    
//}
