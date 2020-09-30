//
//  Authentication.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 29/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Firebase

// for the purpose of registration

struct RegistrationCredentials {
    let email: String
    let password: String
    let fullname: String
    let phoneNumber: String
    let country: String
//    let username: String
}

struct UserCredentials {
    let email: String
    let fullname: String
    let phoneNumber: String
    let country: String
}

struct Authentication {
    static let shared = Authentication()
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
        //        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.5) else { return }
        //
        //        let filename = NSUUID().uuidString
        ////        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        //
        //        ref.putData(imageData, metadata: nil) { (meta, error) in
        //            if let error = error {
        //                print("Failed to create user with error \(error.localizedDescription)")
        //            }
        
        //            ref.downloadURL { (url, error) in
        //                guard let profileImageURL = url?.absoluteString else { return }
        
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
            guard let uid = result?.user.uid else { return }
            
            let user = User(email: credentials.email, fullname: credentials.fullname, uid: uid, phoneNumber: credentials.phoneNumber, country: credentials.country)
            RealmData.shared.createData(object: user)
            //                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
        }
        
    }
    
    
    func logUserOut(){
        do{
            try Auth.auth().signOut()
        } catch let error{
            print("DEBUG: Failed to sign user out, \(error.localizedDescription)")
        }
    }
    
}

