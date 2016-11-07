//
//  ForecastHelper.swift
//  weather
//
//  Created by Mickael Laloum on 01/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation

typealias DailyForecast = (date: Date, forecasts: [Forecast])

class ForecastHelper {
    
    // Group a list of forecasts by day
    static func dailyForecasts(forecasts: [Forecast]) -> [DailyForecast] {
        return forecasts
            .grouped { $0.date.formatted }
            .map { (date: $0.key.date!, forecast: $0.value) }
            .sorted { $0.0.date < $0.1.date }
    }
    
    static func minTemperature(in forecasts: [Forecast]) -> Double? {
        return forecasts.map { $0.mainInformation.minTemperature }.min()
    }
    
    static func maxTemperature(in forecasts: [Forecast]) -> Double? {
        return forecasts.map { $0.mainInformation.minTemperature }.max()
    }
    
    static func midForecast(in forecasts: [Forecast]) -> Forecast {
        let idx = Int(forecasts.count / 2)
        return forecasts[idx]
    }
    
    // All 5 days forecast that is after the given date
    static func nextDailyForecasts(after date: Date, from dailyForecasts: [DailyForecast]) -> [DailyForecast] {
        return dailyForecasts.filter { $0.date > date }
    }
    
    // Today forecast
    static func todayForecast(from dailyForecasts: [DailyForecast]) -> DailyForecast? {
        return dailyForecasts.first { $0.date.isToday }
    }
    
}

extension WeatherCondition {
    
    var imageURL: URL {
        return URL(string: "http://openweathermap.org/img/w/\(icon).png")!
    }
}
