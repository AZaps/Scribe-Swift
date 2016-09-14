//
//  AddQuestViewController.swift
//  Scribe
//
//  Created by Anthony Zaprzalka on 9/13/16.
//  Copyright © 2016 Anthony Zaprzalka. All rights reserved.
//

import UIKit

class AddQuestViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change to final texst field when implemented
        // Title -> Given By -> Notes -> Dismiss keyboard
        // OR
        // Title -> Given By -> Dismiss keyboard -> Tap Notes
        self.addQuestTitleField.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Outlets
    @IBOutlet weak var addQuestTitleField: UITextField!
    
    
    
    @IBAction func saveNewQuest(sender: AnyObject) {
        if addQuestTitleField.text == "" {
            print("Empty title")
        } else {
            print("Saving")
            // Save the quest
            
            // Return back to the quest log
            self.performSegueWithIdentifier("saveQuestBtn", sender: self)
        }
    }
    
    // Keyboard dismisses on return key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
}
