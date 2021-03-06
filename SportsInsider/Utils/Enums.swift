//
//  Enums.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 14/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

enum EditProfileEnum: Int, CaseIterable {
    case email
    case fullName
    case phoneNumber
    case country
    
    var description: String {
        switch self {
        case .email:
            return "Email"
        case .fullName:
            return "Full Name"
        case .phoneNumber:
            return "Phone Number"
        case .country:
            return "Country"    }
    }
    
}

enum ProfileEnum: Int, CaseIterable {
    
    case accountInfo
    case settings
    
    var description: String {
        switch self {
        case .accountInfo:
            return "Account Info"
        case .settings:
            return "Account Settings"      }
    }
    
    var iconImageName: String{
        switch self{
        case.accountInfo: return "person.circle"
        case.settings: return "gear"
        }
    }
    
}

