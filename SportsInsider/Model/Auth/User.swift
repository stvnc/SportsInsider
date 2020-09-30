//
//  User.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 29/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var email: String = ""
    @objc dynamic var fullname: String = ""
    @objc dynamic var uid: String = ""
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var country: String = ""
    
    convenience init(email: String, fullname: String, uid: String, phoneNumber: String, country: String){
        self.init()
        self.email = email
        self.fullname = fullname
        self.uid = uid
        self.phoneNumber = phoneNumber
        self.country = country
    }
}


