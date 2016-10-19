//
//  ViewController.swift
//  Scribe
//
//  Created by Anthony Zaprzalka on 9/12/16.
//  Copyright © 2016 Anthony Zaprzalka. All rights reserved.
//
//  Main landing page for the application

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newQuest = Quest()
        displayPinnedQuest(newQuest)
    }
    
    override func viewDidLayoutSubviews() {
        addBtnBorder(completeLabel)
        addBtnBorder(viewQuestListLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var givenByLabel: UILabel!
    
    @IBOutlet weak var completeLabel: UIButton!
    @IBOutlet weak var viewQuestListLabel: UIButton!
    
    @IBAction func viewPinnedQuestViewController(_ segue: UIStoryboardSegue) {
    }
    
    // Add one sided borders to bottom buttons to distinguish touch areas
    func addBtnBorder(_ btn: UIButton!) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        
        switch btn {
        case completeLabel:
            //Add to the right side
            border.frame = CGRect(x: btn.frame.size.width - 1, y: 0, width: 1, height: btn.frame.size.height)
        case viewQuestListLabel:
            //Add to the left side
            border.frame = CGRect(x: 0, y: 0, width: 1, height: btn.frame.size.height)
        default:
            break
        }
        
        border.borderWidth = width
        btn.layer.addSublayer(border)
        btn.layer.masksToBounds = true;
        
    }
    
    // Landing page to display upcoming reminder or user pinned reminder
    func displayPinnedQuest(_ qst: Quest) {
        
        qst.title = "Test title"
        qst.givenBy = "Test Given By"
        qst.notes = "Test Notes"
        let currentDate = Date()
        qst.date = currentDate
        
        titleLabel.text = qst.title
        timeRemainingLabel.text = qst.date.toMonthAndDay() + " " + qst.date.toShortStyleTime()
        givenByLabel.text = qst.givenBy
        
        //titleLabel.text = qst.debugTestQuest.title
        //timeRemainingLabel.text = "\(qst.debugTestQuest.date.toMonthAndDay()), \(qst.debugTestQuest.date.toShortStyleTime())"
        //givenByLabel.text = qst.debugTestQuest.givenBy
    }



}

