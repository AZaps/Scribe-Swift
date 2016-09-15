//
//  DateExtenstions.swift
//  Scribe
//
//  Created by Anthony Zaprzalka on 9/14/16.
//  Copyright © 2016 Anthony Zaprzalka. All rights reserved.
//

import Foundation

extension NSDate {

    // Returns the time as short style hh:mm am/pm
    func toShortStyleTime() -> String {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        
        return formatter.stringFromDate(self)
    }
    
    // Returns the date as Month + Day
    func toMonthAndDay() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM d"
        
        return formatter.stringFromDate(self)
    }
    
    // Returns the date in long style Full month, day, year
    func toLongStyleDate() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        
        return formatter.stringFromDate(self)
    }
}