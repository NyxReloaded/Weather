//
//  WeatherResponse.swift
//  weather
//
//  Created by Mickael Laloum on 04/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation

struct WeatherResponse: Parsable {
    
    let city: City
    let forecast: Forecast
    
    init?(withJson jsonObject: JSONObject) {
        guard
            let city = City(withJson: jsonObject),
            let forecast = Forecast(withJson: jsonObject) else {
                return nil
        }
        
        self.city = city
        self.forecast = forecast
    }
}
