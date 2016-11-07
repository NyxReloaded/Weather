//
//  Api.swift
//  weather
//
//  Created by Mickael Laloum on 01/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation
import Alamofire

class Api {
    
    enum ApiError: Error {
        case failedToParse
    }
    
    private enum Units: String {
        case standard
        case metric
        case imperial
    }
    
    private struct Constants {
        static let baseURL = URL(string: "http://api.openweathermap.org/data/2.5/")!
        static let parisID = "6455259"
        static let lang = "fr"
        static let openWeatherApiKey = "848bd971546c78d893f3b0f9763df2b9"
    }
    
    static let shared = Api()
    
    private init() { }
    
    
    // MARK: - Webservice
    
    func getForecasts(forCityID id: String = Constants.parisID, completion: @escaping (Result<ForecastResponse>) -> Void) {
        let url = Constants.baseURL.appendingPathComponent("forecast")
        let params = ["id": id]
        
        request(url, parameters: params) { result in
            guard
                let json = result.value as? JSONObject,
                let forecastResponse = ForecastResponse(withJson: json) else {
                    completion(.failure(ApiError.failedToParse))
                    return
            }
            
            completion(.success(forecastResponse))
        }
    }
    
    func getCurrentWeather(forCityID id: String = Constants.parisID, completion: @escaping (Result<WeatherResponse>) -> Void) {
        
        let url = Constants.baseURL.appendingPathComponent("weather")
        let params = ["id": id]
        
        request(url, parameters: params) { result in
            guard
                let json = result.value as? JSONObject,
                let weatherResponse = WeatherResponse(withJson: json) else {
                    completion(.failure(ApiError.failedToParse))
                    return
            }
            
            completion(.success(weatherResponse))
        }

    }
    
    func request(_ url: URL, parameters: Parameters, completion: @escaping (Result<Any>) -> Void) {
        // add generic parameters
        var params = parameters
        params["appid"] = Constants.openWeatherApiKey
        params["units"] = Units.metric.rawValue
        params["lang"] = Constants.lang
        
        Alamofire.request(url, parameters: params).responseJSON { response in
            let result: Result<Any>
            // Quick Offline Managment
            // if request failed because of we are offline and we have a cached response, used it
            if case .failure(let error) = response.result, (error as NSError).code == NSURLErrorNotConnectedToInternet, let cachedResponse = URLCache.shared.cachedResponse(for: response.request!) {
                result = Request.serializeResponseJSON(options: .allowFragments, response: (cachedResponse.response as! HTTPURLResponse), data: cachedResponse.data, error: nil)
            } else {
                result = response.result
            }
            
            completion(result)
        }
    }
}
