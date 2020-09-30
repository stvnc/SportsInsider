//
//  Events.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 03/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

struct EventResults: Decodable {
    let events: [Events]
}

struct Events: Codable, ResultProtocol{
    let eventID: String?
    let name: String
    let desc: String?
    let leagueID: String?
    let date: String?
    let image: String?
    let awayTeam: String?
    let homeTeam: String?
    
    private enum CodingKeys: String, CodingKey {
        case eventID = "idEvent"
        case name = "strEvent"
        case desc = "strSport"
        case leagueID = "idLeague"
        case date = "dateEvent"
        case image = "strThumb"
        case awayTeam = "idAwayTeam"
        case homeTeam = "idHomeTeam"
    }
}
