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
import CoreData

class QuestLogViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    
    var quests = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Update the array to show on the UITableView
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let sortDescription = NSSortDescriptor(key: "date", ascending: true)
        let fetchRequest = NSFetchRequest(entityName: "Quest")
        fetchRequest.sortDescriptors = [sortDescription]
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            /*
             Using 
                quests = results as! [NSManagedObject]
             causes a memory leak on every appearance of this viewController
             I fixed the memory leak by updating the array in the following 3 line.
             This may not be a long term solution as it empties and assignes values after each time the view appears, that could cause major slowdown with larger arrays.
             Some array parsing might need to be added to insert a new element instead. Since reappending each time will make duplicates on the fetch
             */
            quests.removeAll()
            for item in results {
                quests.append(item as! NSManagedObject)
            }
        } catch let error as NSError {
            print("ERROR \(error)")
        }
        // Reload the table
        reloadTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Override Table Views
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QuestCell")
        
        let quest = quests[indexPath.row]
        
        cell!.textLabel!.text = quest.valueForKey("title") as? String
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Delete core data entry
            let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let fetchRequest = NSFetchRequest(entityName: "Quest")
            let referenceString: String = (selectedCell!.valueForKey("text"))! as! String
            let searchPredicate = NSPredicate(format: "title == %@", referenceString)
            fetchRequest.predicate = searchPredicate
            
            do {
                let fetchResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
                for item in fetchResults! {
                    managedContext.deleteObject(item)
                    if managedContext.hasChanges {
                        do {
                            try managedContext.save()
                        } catch let error as NSError {
                            print("ERROR: \(error)")
                        }
                    }
                }
            } catch let error as NSError {
                print("ERROR: \(error)")
            }
            // Delete array entry
            quests.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            reloadTable()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quests.count
    }
    
    // MARK: - Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CellDetailViewSegue" {
            // Delegate to ViewController
            let cellDetailViewController = segue.destinationViewController as! QuestDetailViewController
            // Get the index path from the selected cell
            let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
            // Get the cell from the selected index row
            let selectedCell = quests[selectedIndex!.row]
            
            // Get properties of the cell to send
            cellDetailViewController.selectedQuest.title = selectedCell.valueForKey("title") as! String
            cellDetailViewController.selectedQuest.givenBy = selectedCell.valueForKey("givenBy") as? String
            cellDetailViewController.selectedQuest.notes = selectedCell.valueForKey("notes") as? String
            cellDetailViewController.selectedQuest.date = selectedCell.valueForKey("date") as! NSDate
        }
    }

    @IBOutlet var questLogDataTable: UITableView!
    
    @IBAction func viewQuestLogViewController(segue: UIStoryboardSegue) {
    }
    @IBAction func saveQuestToQuestLogViewController(segue: UIStoryboardSegue) {
    }
    
    func reloadTable() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
}
