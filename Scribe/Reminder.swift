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
    
    func saveReminder() -> Bool {
        // Saves the reminder to CoreData
        
        // Temp change later
        return false
        
    }
    
    func editReminder() -> Bool {
        // Edits a specific part of the reminder then saves to CoreData
        
        // Temp change later
        return false
    }
}