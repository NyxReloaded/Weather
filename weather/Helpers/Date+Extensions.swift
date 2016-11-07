//
//  Date+Extensions.swift
//  weather
//
//  Created by Mickael Laloum on 01/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation

extension Calendar {
    static let gregorian: Calendar = {
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.locale = Locale.current
        calendar.timeZone = TimeZone.current
        return calendar
    }()
}

extension DateFormatter {
    
    
    static func weatherFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    static let `default`: DateFormatter = {
        let formatter = DateFormatter.weatherFormatter()
        formatter.setLocalizedDateFormatFromTemplate("ddMMyyyy")
        return formatter
    }()
    
    static let weekday: DateFormatter = {
        let formatter = DateFormatter.weatherFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEE")
        return formatter
    }()
    
    static let relative: DateFormatter = {
        let formatter = DateFormatter.weatherFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    static let hour: DateFormatter = {
        let formatter = DateFormatter.weatherFormatter()
        formatter.setLocalizedDateFormatFromTemplate("HHm")
        return formatter
    }()
    
    static let long: DateFormatter = {
        let formatter = DateFormatter.weatherFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEEddMMMMyyyy")
        return formatter
    }()
}

extension Date {
    
    func formattedDate(with components: Set<Calendar.Component>) -> Date? {
        let comps = Calendar.gregorian.dateComponents(components, from: self)
        return Calendar.gregorian.date(from: comps)
    }
    
    var formatted: String {
        return DateFormatter.default.string(from: self)
    }
    
    var year: Int {
        return Calendar.gregorian.component(Calendar.Component.year, from: self)
    }
    var month: Int {
        return Calendar.gregorian.component(Calendar.Component.month, from: self)
    }
    
    var day: Int {
        return Calendar.gregorian.component(Calendar.Component.day, from: self)
    }
    
    var hour: Int {
        return Calendar.gregorian.component(Calendar.Component.hour, from: self)
    }
    
    var minute: Int {
        return Calendar.gregorian.component(Calendar.Component.minute, from: self)
    }
    
    var second: Int {
        return Calendar.gregorian.component(Calendar.Component.second, from: self)
    }
    
    var weekday: String {
        return DateFormatter.weekday.string(from: self)
    }
    
    var isToday: Bool {
        let today = Date()
        return (day == today.day) && (month == today.month) && (year == today.year)
    }
    
    var relativeString: String {
        return DateFormatter.relative.string(from: self)
    }
    
    var formattedHour: String {
        return DateFormatter.hour.string(from: self)
    }
    
    var longFormatted: String {
        return DateFormatter.long.string(from: self)
    }
}

extension String {
    
    var date: Date? {
        return DateFormatter.default.date(from: self)
    }
}
