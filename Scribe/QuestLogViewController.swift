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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Update the array to show on the UITableView
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let sortDescription = NSSortDescriptor(key: "date", ascending: true)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Quest")
        fetchRequest.sortDescriptors = [sortDescription]
        do {
            let results = try managedContext.fetch(fetchRequest)
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
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestCell")
        
        let quest = quests[(indexPath as NSIndexPath).row]
        
        cell!.textLabel!.text = quest.value(forKey: "title") as? String
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            // Delete core data entry
            let selectedCell = tableView.cellForRow(at: indexPath)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Quest")
            let referenceString: String = (selectedCell!.value(forKey: "text"))! as! String
            let searchPredicate = NSPredicate(format: "title == %@", referenceString)
            fetchRequest.predicate = searchPredicate
            
            do {
                let fetchResults = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
                for item in fetchResults! {
                    managedContext.delete(item)
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
            quests.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            reloadTable()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quests.count
    }
    
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CellDetailViewSegue" {
            // Delegate to ViewController
            let cellDetailViewController = segue.destination as! QuestDetailViewController
            // Get the index path from the selected cell
            let selectedIndex = self.tableView.indexPath(for: sender as! UITableViewCell)
            // Get the cell from the selected index row
            let selectedCell = quests[(selectedIndex! as NSIndexPath).row]
            
            // Get properties of the cell to send
            cellDetailViewController.selectedQuest.title = selectedCell.value(forKey: "title") as! String
            cellDetailViewController.selectedQuest.givenBy = selectedCell.value(forKey: "givenBy") as? String
            cellDetailViewController.selectedQuest.notes = selectedCell.value(forKey: "notes") as? String
            cellDetailViewController.selectedQuest.date = selectedCell.value(forKey: "date") as! Date
        }
    }

    @IBOutlet var questLogDataTable: UITableView!
    
    @IBAction func viewQuestLogViewController(_ segue: UIStoryboardSegue) {
    }
    @IBAction func saveQuestToQuestLogViewController(_ segue: UIStoryboardSegue) {
    }
    
    func reloadTable() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.tableView.reloadData()
        })
    }
}
