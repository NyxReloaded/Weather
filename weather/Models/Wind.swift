//
//  Wind.swift
//  weather
//
//  Created by Mickael Laloum on 01/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation


struct Wind {
    let speed: Double
    let degree: Double
}

extension Wind: Parsable {
    init?(withJson jsonObject: JSONObject) {
        // Check required properties
        guard
            let speed = jsonObject["speed"] as? Double,
            let deg = jsonObject["deg"] as? Double else {
                return nil
        }
        self.speed = speed
        self.degree = deg
    }
}
