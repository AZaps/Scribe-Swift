//
//  QuestLogViewController.swift
//  Scribe
//
//  Created by Anthony Zaprzalka on 9/13/16.
//  Copyright © 2016 Anthony Zaprzalka. All rights reserved.
//
//  Displays all quests in a table
//  Quests can be added, deleted, and completed

import UIKit

class QuestLogViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func viewQuestLogViewController(segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveQuestToQuestLogViewController(segue: UIStoryboardSegue) {
        // Save the user inputted quest then return back to the Quest Log
        
    }
}
