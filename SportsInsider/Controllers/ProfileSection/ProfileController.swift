//
//  EditProfileController.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 26/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.

// Add Listener for password textfield, if the password is the same as before, the button will still be disabled
//

import UIKit
import Firebase

private let reuseIdentifier = "ProfileCell"

protocol ProfileControllerDelegate: class {
    func handleLogout()
}

class ProfileController: UITableViewController {
    // MARK: - Properties
    
    private var user: User?
//    {
//        didSet {
////            headerView.user = user
//        }
//    }
    
    weak var delegate: ProfileControllerDelegate?
    
    private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
//    private lazy var footerView = ProfileFooterView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 100))
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    
    // MARK: - Selectors
    
    
    // MARK: - API
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
//        self.showLoader(true)
//        Service.fetchUser(withUID: uid) { user in
//            self.showLoader(false)
//            self.user = user
//        }
    }
    
    
    // MARK: - Helpers
    
    func configureUI(){
        tableView.backgroundColor = .white
        
        self.tableView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
//        tableView.tableHeaderView = headerView
//        headerView.delegate = self
        
        tableView.register(ProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 64
        
//        tableView.tableFooterView = footerView
//        footerView.delegate = self
        
        
        
    }
}

extension ProfileController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileEnum.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
        
        let enums = ProfileEnum(rawValue: indexPath.row)
        cell.enums = enums
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension ProfileController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let enums = ProfileEnum(rawValue: indexPath.row) else { return }
        
        switch enums{
        case .accountInfo:
            let controller = EditProfileController()
            navigationController?.pushViewController(controller, animated: true)
        case .settings:
            print("Settings!")
    }
}
}

//extension ProfileController: ProfileHeaderDelegate {
//    func dismissController() {
//        dismiss(animated: true, completion: nil)
//    }
//
//
//}

//extension ProfileController: ProfileFooterDelegate {
//    func handleLogout() {
//        let alert =  UIAlertController(title: nil, message: "Do you want to logout?", preferredStyle: .actionSheet)
//        
//        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
//            self.dismiss(animated: true) {
//                self.delegate?.handleLogout()
//            }
//        }))
//        
//        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
//            self.dismiss(animated: true)
//        }))
//        
//        present(alert, animated: true, completion: nil)
//    }
//}
