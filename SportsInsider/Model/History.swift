//
//  History.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 16/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation
import RealmSwift

class History: Object {
    @objc dynamic var uid: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var searchID: String = ""
    @objc dynamic var objectID: String = ""
}
