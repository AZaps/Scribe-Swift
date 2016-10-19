//
//  DateExtenstions.swift
//  Scribe
//
//  Created by Anthony Zaprzalka on 9/14/16.
//  Copyright © 2016 Anthony Zaprzalka. All rights reserved.
//

import Foundation

extension Date {

    // Returns the time as short style hh:mm am/pm
    func toShortStyleTime() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
    
    // Returns the date as Month + Day
    func toMonthAndDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        
        return formatter.string(from: self)
    }
    
    // Returns the date in long style Full month, day, year
    func toLongStyleDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        return formatter.string(from: self)
    }
}
