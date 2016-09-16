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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(editSelectedQuest as () -> ()))
        
        updateViewWithQuest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBOutlet weak var questTitleField: UITextField!
    @IBOutlet weak var questGiverField: UITextField!
    @IBOutlet weak var questCompleteByLabel: UILabel!
    @IBOutlet weak var questNotesView: UITextView!
    
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
        
    }
}
