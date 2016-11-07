//
//  Clouds.swift
//  weather
//
//  Created by Mickael Laloum on 01/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation

struct Clouds {
    let cloudiness: Double
}

extension Clouds: Parsable {
    init?(withJson jsonObject: JSONObject) {
        guard let all = jsonObject["all"] as? Double else {
            return nil
        }
        
        self.cloudiness = all
    }
}
