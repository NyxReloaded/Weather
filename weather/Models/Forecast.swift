//
//  Forecast.swift
//  weather
//
//  Created by Mickael Laloum on 01/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation

struct Forecast {
    let date: Date
    let mainInformation: MainInformation
    let wind: Wind
    let weatherCondition: WeatherCondition
    let clouds: Clouds
    let rain: Rain?
    let snow: Snow?
}

extension Forecast: Parsable {
    init?(withJson jsonObject: JSONObject) {
        guard
            let timeInterval = jsonObject["dt"] as? TimeInterval,
            let main = MainInformation(withJson: jsonObject["main"] as? JSONObject),
            let wind = Wind(withJson: jsonObject["wind"] as? JSONObject),
            let weather = jsonObject["weather"] as? [JSONObject],
            let weatherCondition = WeatherCondition(withJson: weather.first),
            let clouds = Clouds(withJson: jsonObject["clouds"] as? JSONObject) else {
            return nil
        }

        self.date = Date(timeIntervalSince1970: timeInterval)
        self.mainInformation = main
        self.wind = wind
        self.weatherCondition = weatherCondition
        self.clouds = clouds
        self.rain = Rain(withJson: jsonObject["rain"] as? JSONObject)
        self.snow = Snow(withJson: jsonObject["snow"] as? JSONObject)
    }
}
