//
//  Number+Extension.swift
//  weather
//
//  Created by Mickael Laloum on 05/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation

extension NumberFormatter {
    
    static let `default`: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.minimumIntegerDigits = 1
        return formatter
    }()
}

extension Double {
    
    var formatted: String {
        return NumberFormatter.default.string(from: NSNumber(value: self))!
    }
}
