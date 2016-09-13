//
//  ViewController.swift
//  Scribe
//
//  Created by Anthony Zaprzalka on 9/12/16.
//  Copyright © 2016 Anthony Zaprzalka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Landing page to display upcoming reminder or user pinned reminder
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var givenByLabel: UILabel!
    
    @IBOutlet weak var notesLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func myBtn(sender: UIButton) {
        let newReminder = Reminder()
        titleLabel.text = newReminder.debugTestReminder.title
        givenByLabel.text = newReminder.debugTestReminder.givenBy
        notesLabel.text = newReminder.debugTestReminder.notes
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        let tempDate = dateFormatter.stringFromDate(newReminder.debugTestReminder.date)
        dateLabel.text = tempDate
    }


}

