//
//  AddQuestViewController.swift
//  Scribe
//
//  Created by Anthony Zaprzalka on 9/13/16.
//  Copyright © 2016 Anthony Zaprzalka. All rights reserved.
//

import UIKit

class AddQuestViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        // Assign text delegates
        self.addQuestTitleField.delegate = self
        self.addGivenByField.delegate = self
        self.addNotesView.delegate = self
        completionDatePicker.addTarget(self, action: #selector(datePickerChange(_:)), for: UIControlEvents.valueChanged)
        
        // Create notifications for when the keyboard appears to change the scroll view
        NotificationCenter.default.addObserver(self, selector: #selector(AddQuestViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddQuestViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Set the date to the current date and update the Complete By label with the date and time
        formatDateView()
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
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var addQuestTitleField: UITextField!
    @IBOutlet weak var addGivenByField: UITextField!
    @IBOutlet weak var addNotesView: UITextView!
    @IBOutlet weak var completionDatePicker: UIDatePicker!
    @IBOutlet weak var completeByLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!

    // MARK: - Action functions
    // Gesture based by tapping on white space to dismiss keyboard
    @IBAction func hideKeyboard(_ sender: AnyObject) {
        addQuestTitleField.endEditing(true)
        addGivenByField.endEditing(true)
        addNotesView.endEditing(true)
    }
    
    // Saves the information inputted as a new quest or alerts the user that there isn't a title to the quest
    @IBAction func saveNewQuest(_ sender: AnyObject) {
        if addQuestTitleField.text == "" {
            // Alert user there isn't a title
            let noTitleAlert = UIAlertController(title: "No Quest Title", message: "Can't save a quest without a title!", preferredStyle: UIAlertControllerStyle.alert)
            noTitleAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) -> Void in ()} ))
            present(noTitleAlert, animated: true, completion: nil)
            
        } else {
            // Get properties
            let saveQuest = Quest()
            saveQuest.title = addQuestTitleField.text!
            saveQuest.givenBy = addGivenByField.text
            if addNotesView.text == "Add additional information?" {
                saveQuest.notes = ""
            } else {
                saveQuest.notes = addNotesView.text
            }
            saveQuest.date = completionDatePicker.date
            
            // Save the quest
            let appD = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appD.managedObjectContext
            if saveQuest.saveQuest(managedContext, saveQuest: saveQuest) {
                self.performSegue(withIdentifier: "saveQuestBtn", sender: self)
            } else {
                print("There was an error")
            }
        }
    }
    
    // MARK: - Special functions
    // Keyboard dismisses on return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case addQuestTitleField:
            addQuestTitleField.resignFirstResponder()
            addGivenByField.becomeFirstResponder()
        case addGivenByField:
            addGivenByField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    // Adds a done key to the keyboard when selecting the textView
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let doneKeyboardButton = UIToolbar()
        doneKeyboardButton.sizeToFit()
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        // Since the #selector target doesn't take any input it needs to be listed as 'foo as () -> ()'
        let doneItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(textViewDone as () -> ()))
        let toolbarButtons = [flexibleSpaceItem, doneItem]
        doneKeyboardButton.setItems(toolbarButtons, animated: false)
        textView.inputAccessoryView = doneKeyboardButton
        
        return true
    }
    
    // Dismisses the keyboard from the textView when 'Done' is pressed
    func textViewDone() {
        self.view.endEditing(true)
    }
    
    // Removes the placeholder text when editing
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == addNotesView {
            if addNotesView.text == "Add additional information?" {
                addNotesView.text = ""
                addNotesView.textColor = UIColor.black
            }
        }
    }
    
    // Adds the placeholder text after editing and nothing inputted
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == addNotesView {
            if addNotesView.text == "" {
                addNotesView.text = "Add additional information?"
                addNotesView.textColor = UIColor.lightGray
            }
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
    
    // Changes the scroll view so the selected text item is at the top
    func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
        // Determine which entry element is selected to adjust height properly
        if addQuestTitleField.isFirstResponder {
            scrollView.setContentOffset(addQuestTitleField.frame.origin, animated: true)
        } else if addGivenByField.isFirstResponder {
            scrollView.setContentOffset(addGivenByField.frame.origin, animated: true)
        } else if addNotesView.isFirstResponder {
           scrollView.setContentOffset(addNotesView.frame.origin, animated: true)
        }
    }
    
    func keyboardWillShow(_ notification: Notification) {
        adjustInsetForKeyboardShow(true, notification: notification)
    }
    
    func keyboardWillHide(_ notification: Notification) {
        adjustInsetForKeyboardShow(false, notification: notification)
    }
    
    // Initial settings to show for the date.
    // Uses NSDate() extensions for the date and time found in DateExtenstions.swift
    func formatDateView() {
        // Set the date picker to the current date
        let currentDate = Date()
        completionDatePicker.minimumDate = currentDate
        completionDatePicker.date = currentDate
        
        // Show current date in the label
        completeByLabel.text = "Complete By: \(currentDate.toMonthAndDay()), \(currentDate.toShortStyleTime())"
    }
    
    // Changes complete by label when date changed
    func datePickerChange(_ datePicker: UIDatePicker) {
        completeByLabel.text = "Complete By: \(datePicker.date.toMonthAndDay()), \(datePicker.date.toShortStyleTime())"
    }
}











































