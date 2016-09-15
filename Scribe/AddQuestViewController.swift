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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddQuestViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddQuestViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addBottomBorders(addQuestTitleField)
        addBottomBorders(addGivenByField)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // Outlets
    @IBOutlet weak var addQuestTitleField: UITextField!
    @IBOutlet weak var addGivenByField: UITextField!
    @IBOutlet weak var addNotesView: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!

    // Gesture based by tapping on white space to dismiss keyboard
    @IBAction func hideKeyboard(sender: AnyObject) {
        addQuestTitleField.endEditing(true)
        addGivenByField.endEditing(true)
        addNotesView.endEditing(true)
    }
    
    @IBAction func saveNewQuest(sender: AnyObject) {
        if addQuestTitleField.text == "" {
            // Alert user there isn't a title
            let noTitleAlert = UIAlertController(title: "No Quest Title", message: "Can't save a quest without a title!", preferredStyle: UIAlertControllerStyle.Alert)
            noTitleAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in Void.self } ))
            presentViewController(noTitleAlert, animated: true, completion: nil)
            
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
    
    func addBottomBorders(textField: UITextField) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.blackColor().CGColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
    func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
        // Determine which entry element is selected to adjust height properly
        if addQuestTitleField.isFirstResponder() {
            scrollView.setContentOffset(addQuestTitleField.frame.origin, animated: true)
        } else if addGivenByField.isFirstResponder() {
            scrollView.setContentOffset(addGivenByField.frame.origin, animated: true)
        } else if addNotesView.isFirstResponder() {
            print("addNotesView first responder")
           scrollView.setContentOffset(addNotesView.frame.origin, animated: true)
        } else {
            print("unknown first responder")
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        adjustInsetForKeyboardShow(true, notification: notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        adjustInsetForKeyboardShow(false, notification: notification)
    }
}











































