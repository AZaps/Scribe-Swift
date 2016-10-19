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
    
    /*
        Core Data Structure
     
        Quest
        forKey Values:
            title
            notes
            givenBy
            date
     */
    
    // Quest Properties
    var title: String = ""
    var givenBy: String?
    var notes: String?
    var date: Date = Date()
    
    
    // Saves the newly created quest to CoreData
    func saveQuest(_ managedContext: NSManagedObjectContext, saveQuest: Quest) -> Bool {
        // Saves the quest to CoreData
        let entity = NSEntityDescription.entity(forEntityName: "Quest", in: managedContext)
        let quest = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        quest.setValue(saveQuest.title, forKey: "title")
        quest.setValue(saveQuest.givenBy, forKey: "givenBy")
        quest.setValue(saveQuest.notes, forKey: "notes")
        quest.setValue(saveQuest.date, forKey: "date")
        
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                print("ERROR: \(nserror), \(nserror.userInfo)")
                return false
            }
            return true
        }
        return false
        
    }
    
    // Edits an already created quest
    func editQuest() -> Bool {
        // Edits a specific part of the quest then saves to CoreData
        
        // Temp change later
        return false
    }
    
    func debugPrint(_ tmpQuest: Quest) {
        print("Title: \(tmpQuest.title)")
        print("Given By: \(tmpQuest.givenBy)")
        print("Date: \(tmpQuest.date)")
        print("Notes: \(tmpQuest.notes)")
    }
    
    
}
