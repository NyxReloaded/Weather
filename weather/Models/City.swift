//
//  City.swift
//  weather
//
//  Created by Mickael Laloum on 01/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation

struct City {
    let id: UInt
    let name: String
    let countryCode: String?
}

// Make City parsable
extension City: Parsable {
    init?(withJson jsonObject: JSONObject) {
        
        // Check required properties
        guard
            let id = jsonObject["id"] as? UInt,
            let name = jsonObject["name"] as? String else {
                return nil
        }
        self.id = id
        self.name = name
        self.countryCode = jsonObject["country"] as? String
    }
}
