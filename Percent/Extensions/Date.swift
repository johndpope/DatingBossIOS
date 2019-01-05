//
//  Date.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 03/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import Foundation

extension Date {
    func yearsFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.year, from: date, to: self, options: []).year ?? 0
    }
    
    func monthsFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.month, from: date, to: self, options: []).month ?? 0
    }
    
    func weeksFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: date, to: self, options: []).weekOfYear ?? 0
    }
    
    func daysFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.day, from: date, to: self, options: []).day ?? 0
    }
    
    func hoursFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.hour, from: date, to: self, options: []).hour ?? 0
    }
    
    func minutesFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.minute, from: date, to: self, options: []).minute ?? 0
    }
    
    func secondsFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.second, from: date, to: self, options: []).second ?? 0
    }
    
    
    var relativeTime: String {
        let now = Date()
        if now.daysFrom(self) > 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = "MMMM d, yyyy"
            return dateFormatter.string(from: self)
        }
        if now.hoursFrom(self) > 0 {
            return "\(now.hoursFrom(self)) hour"     + { return now.hoursFrom(self)   > 1 ? "s" : "" }() + " ago"
        }
        if now.minutesFrom(self) > 0 {
            return "\(now.minutesFrom(self)) minute" + { return now.minutesFrom(self) > 1 ? "s" : "" }() + " ago"
        }
        return "Just now"
    }
    
    var relativeShortTime: String {
        let now = Date()
        if now.daysFrom(self) > 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: self)
        }
        if now.hoursFrom(self) > 0 {
            return "\(now.hoursFrom(self)) hour"     + { return now.hoursFrom(self)   > 1 ? "s" : "" }() + " ago"
        }
        if now.minutesFrom(self) > 0 {
            return "\(now.minutesFrom(self)) minute" + { return now.minutesFrom(self) > 1 ? "s" : "" }() + " ago"
        }
        return "Just now"
    }
}
