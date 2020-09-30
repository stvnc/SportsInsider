//
//  Players.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 07/09/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

struct PlayerResults: Decodable {
    let player: [Player]
}

struct Player: Codable, ResultProtocol {
    let playerID: String
    let teamID: String
    var name: String
    let dateOfBirth: String?
    let birthLocation: String?
    let playerNumber: String?
    let wage: String?
    let weight: String?
    var desc: String?
    var image: String?
    let biography: String?
    
    private enum CodingKeys: String, CodingKey{
        case playerID = "idPlayer"
        case teamID = "idTeam"
        case name = "strPlayer"
        case dateOfBirth = "dateBorn"
        case birthLocation = "strBirthLocation"
        case playerNumber = "strNumber"
        case wage = "strWage"
        case weight = "strWeight"
        case desc = "strPosition"
        case image = "strThumb"
        case biography = "strDescriptionEN"
    }
}
