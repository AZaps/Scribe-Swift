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
    
    
    // Keyboard dismisses on return key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
}
