//
//  Reminder.swift
//  Scribe
//
//  Created by Anthony Zaprzalka on 9/12/16.
//  Copyright © 2016 Anthony Zaprzalka. All rights reserved.
//

import Foundation
import CoreData

class Reminder {
    
    // Constructor for a reminder
    struct reminderStruct {
        var title: String
        var givenBy: String?
        var notes: String?
        var date: NSDate
        
    }
    
    var myReminderStruct = [reminderStruct(title: "", givenBy: nil, notes: nil, date: NSDate())]
    
    var debugTestReminder = reminderStruct(title: "Test Title", givenBy: "Test Me", notes: "Some test notes", date: NSDate())
    
    
    
    // Saves the newly created reminder to CoreData
    func saveReminder() -> Bool {
        // Saves the reminder to CoreData
        
        // Temp change later
        return false
        
    }
    
    // Edits an already created reminder
    func editReminder() -> Bool {
        // Edits a specific part of the reminder then saves to CoreData
        
        // Temp change later
        return false
    }
    
    // Takes NSDate type and converts to string so controller can display to view as text
    func dateToString(date: NSDate) -> String {
        let dateFormatter  = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        return dateFormatter.stringFromDate(date)
    }
}