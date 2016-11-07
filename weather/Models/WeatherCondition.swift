//
//  WeatherCondition.swift
//  weather
//
//  Created by Mickael Laloum on 01/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation


struct WeatherCondition {
    
    enum Group: String {
        case Thunderstorm
        case Drizzle
        case Rain
        case Snow
        case Atmosphere
        case Clear
        case Clouds
        case Extreme
        case Additional
    }

    let id: UInt
    let group: Group
    let description: String
    let icon: String

}

extension WeatherCondition: Parsable {
    init?(withJson jsonObject: JSONObject) {
        guard
            let id = jsonObject["id"] as? UInt,
            let main = jsonObject["main"] as? String,
            let group = WeatherCondition.Group(rawValue: main),
            let description = jsonObject["description"] as? String,
            let icon = jsonObject["icon"] as? String else {
            return nil
        }
        
        self.id = id
        self.group = group
        self.description = description
        self.icon = icon
    }
}
