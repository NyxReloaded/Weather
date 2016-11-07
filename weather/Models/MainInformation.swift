//
//  MainInformation.swift
//  weather
//
//  Created by Mickael Laloum on 01/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation


struct MainInformation {
    let temperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    
    let humidity: Double?
    let pressure: Double?
    let seaLevel: Double?
    let groundLevel: Double?
    
}

extension MainInformation: Parsable {
    init?(withJson jsonObject: JSONObject) {
        // check required properties
        guard
            let temp = jsonObject["temp"] as? Double,
            let minTemp = jsonObject["temp_min"] as? Double,
            let maxTemp = jsonObject["temp_max"] as? Double else {
                return nil
        }
        self.temperature = temp
        self.minTemperature = minTemp
        self.maxTemperature = maxTemp
        self.humidity = jsonObject["humidity"] as? Double
        self.pressure = jsonObject["pressure"] as? Double
        self.seaLevel = jsonObject["sea_level"] as? Double
        self.groundLevel = jsonObject["grnd_level"] as? Double
    }
}
