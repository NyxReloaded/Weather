//
//  Forecast.swift
//  weather
//
//  Created by Mickael Laloum on 04/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation

struct ForecastResponse: Parsable {
    
    let city: City?
    let forecasts: [Forecast]
    
    init?(withJson jsonObject: JSONObject) {
        guard
            let city = City(withJson: jsonObject["city"] as? JSONObject),
            let list = jsonObject["list"] as? [JSONObject] else {
                return nil
        }
        
        self.city = city
        self.forecasts = list.flatMap(Forecast.init)
    }
}
