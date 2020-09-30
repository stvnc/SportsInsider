//
//  Teams.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 06/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

struct TeamResults: Decodable {
    let teams: [Teams]
}

struct Teams: Codable, ResultProtocol{
    let teamID: String
    var name: String
    var desc: String?
    var image: String?
    let founded: String?
    let stadium: String?
    let location: String?
    let country: String?
    
    private enum CodingKeys: String, CodingKey {
        case teamID = "idTeam"
        case name = "strTeam"
        case desc = "strDescriptionEN"
        case image = "strTeamBadge"
        case founded = "intFormedYear"
        case stadium = "strStadium"
        case location = "strStadiumLocation"
        case country = "strCountry"
        
    }
    
}
