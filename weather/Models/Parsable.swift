//
//  Parsable.swift
//  weather
//
//  Created by Mickael Laloum on 01/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation

// Create alias as shortcut for Dictionary<String, Any>
typealias JSONObject = [String: Any]

// Protocol Parsable :
// Object is parsable if it can be created/initialized by json object
protocol Parsable {
    init?(withJson jsonObject: JSONObject?)
    init?(withJson jsonObject: JSONObject)
}

extension Parsable {
    init?(withJson jsonObject: JSONObject?) {
        guard let jsonObject = jsonObject else {
            return nil
        }
        
        self.init(withJson: jsonObject)
    }
}
