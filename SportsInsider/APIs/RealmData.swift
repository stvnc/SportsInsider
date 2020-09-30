//
//  Realm.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 16/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmData {
    static let shared = RealmData()
    
    let realm = try! Realm()
    
    func createData(object: Object){
        do
        {
            try realm.write {
                realm.add(object)
            }
            
        } catch {
            print("Error saving object \(error.localizedDescription)")
        }
    }
    
    func loadData<T: Object>(searchParameter: String, searchValue: String) -> Results<T>{
        print("object type: \(T.Type.self)")
        let objects = realm.objects(T.self).filter("\(searchParameter) == \(searchValue)")
        return objects
    }
    
    func loadData() -> Results<User> {
        let objects = realm.objects(User.self)
        return objects
    }
    
    func updateData(user: User, credentials: UserCredentials) {
        // self write for updating the database
        do
        {
            try realm.write {
                user.phoneNumber = credentials.phoneNumber
                user.fullname = credentials.fullname
                user.country = credentials.country
            }
            
            print("Successfully updated user data!")
            
        } catch {
            print("Error saving object \(error.localizedDescription)")
        }
    }
}
