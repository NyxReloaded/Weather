//
//  Rain.swift
//  weather
//
//  Created by Mickael Laloum on 01/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation

struct Rain {
    let last3HoursVolume: Double
}

extension Rain: Parsable {
    init?(withJson jsonObject: JSONObject) {
        guard let last3Hours = jsonObject["3h"] as? Double else {
            return nil
        }
        
        self.last3HoursVolume = last3Hours
    }
}
