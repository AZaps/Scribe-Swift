//
//  QuestDetailViewController.swift
//  Scribe
//
//  Created by Anthony Zaprzalka on 9/16/16.
//  Copyright © 2016 Anthony Zaprzalka. All rights reserved.
//

import UIKit

class QuestDetailViewController: UIViewController {
    
    var selectedQuest = Quest()
    
    /*
        On exit check to see if the Done is still enabled and if show prompt to ask if changes are to be saved.
     */

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add edit button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editSelectedQuest as () -> ()))
        
        // Update view with the selected quest data
        updateViewWithQuest()
        
        // Add borders to the bottom of the upper two inputs boxes
        addBottomBorders(questTitleField)
        addBottomBorders(questGiverField)
        
        // Initially set the text input boxes to be non editable
        isTextBoxesEditable(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var questTitleField: UITextField!
    @IBOutlet weak var questGiverField: UITextField!
    @IBOutlet weak var questCompleteByLabel: UILabel!
    @IBOutlet weak var questNotesView: UITextView!
    
    // Updates the view with the selected quest from the table view
    func updateViewWithQuest() {
        questTitleField.text = selectedQuest.title
        if selectedQuest.givenBy == nil {
            questGiverField.text = ""
        } else {
            questGiverField.text = selectedQuest.givenBy
        }
        questNotesView.text = selectedQuest.notes
        questCompleteByLabel.text = "Complete By:\n\(selectedQuest.date.toShortStyleTime()) on \(selectedQuest.date.toLongStyleDate())"
    }
    
    func editSelectedQuest() {
        // Change right bar button item to 'Done' as a visual prompt
        isTextBoxesEditable(true)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveChanges as () -> ()))
    }
    
    func saveChanges() {
        isTextBoxesEditable(false)
        
        // Save changes locally
        selectedQuest.title = questTitleField.text!
        selectedQuest.givenBy = questGiverField.text
        selectedQuest.notes = questNotesView.text
        
        // Save changes to coreData
        let appD = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appD.managedObjectContext
        if selectedQuest.saveQuest(managedContext, saveQuest: selectedQuest) {
            // Show small prompt that changes were saved
            print("Saved")
        } else {
            print("Error saving")
        }
        
        // Change right bar button item back to edit
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editSelectedQuest as () -> ()))
    }
    
    func isTextBoxesEditable(_ isEditable: Bool) {
        if (isEditable) {
            // Allow editing
            questTitleField.isEnabled = true
            questGiverField.isEnabled = true
            questNotesView.isEditable = true
        } else {
            // Disallow editing
            questTitleField.isEnabled = false
            questGiverField.isEnabled = false
            questNotesView.isEditable = false
        }
    }
    
    // Will add a single line to the bottom of the textField inputs
    func addBottomBorders(_ textField: UITextField) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
}
