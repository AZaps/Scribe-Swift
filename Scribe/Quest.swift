//
//  Quest.swift
//  Scribe
//
//  Created by Anthony Zaprzalka on 9/13/16.
//  Copyright © 2016 Anthony Zaprzalka. All rights reserved.
//
//  Basic structure for a Quest(reminder)

import Foundation
import CoreData

class Quest {
    
    // Constructor for a quest
    struct questStruct {
        var title: String
        var givenBy: String?
        var notes: String?
        var date: NSDate
        
    }
    
    var myQuestStruct = [questStruct(title: "", givenBy: nil, notes: nil, date: NSDate())]
    
    var debugTestQuest = questStruct(title: "Test Title", givenBy: "Test Me", notes: "Some test notes", date: NSDate())
    
    
    // Saves the newly created quest to CoreData
    func saveQuest() -> Bool {
        // Saves the quest to CoreData
        
        // Temp change later
        return false
        
    }
    
    // Edits an already created quest
    func editQuest() -> Bool {
        // Edits a specific part of the quest then saves to CoreData
        
        // Temp change later
        return false
    }
}