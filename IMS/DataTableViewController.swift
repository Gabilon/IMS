//
//  DataTableViewController.swift
//  IMS
//
//  Created by Gabriel Bermudez on 9/19/15.
//  Copyright (c) 2015 Gabriel Bermudez. All rights reserved.
//

import UIKit
import Parse
import Bolts

class DataTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className: "Publication")
        query.fromLocalDatastore()
        query.whereKey("publication_Type", equalTo: "Tract")
        query.findObjectsInBackground().continueWithBlock {
            (task: BFTask!) -> AnyObject in
            if let error = task.error {
                print("Error: \(error)")
                return task
            }
            
            print("Retrieved \(task.result.count)")
            return task
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //Return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return the number of rows in the section
        return 5
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("LabelCell", forIndexPath: indexPath) 
        
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    

}
