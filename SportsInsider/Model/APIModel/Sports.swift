//
//  Sports.swift
//  SportsInsider
//
//  Created by Vincent Angelo on 21/08/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation


struct SportsResult: Decodable {
    let sports: [Sports]
}

struct Sports: Codable{
    let id: String
    let sportsName: String
    let sportsThumbnail: String
    let sportDescription: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "idSport"
        case sportsName = "strSport"
        case sportsThumbnail = "strSportThumb"
        case sportDescription = "strSportDescription"
    }
}
