//
//  Leagues.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 21/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

struct LeagueResult: Codable {
    let leagues: [Leagues]
}

struct Leagues: Codable {
    let id: String
    let leagueName: String
    let sportName: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "idLeague"
        case leagueName = "strLeague"
        case sportName = "strSport"
    }
}
