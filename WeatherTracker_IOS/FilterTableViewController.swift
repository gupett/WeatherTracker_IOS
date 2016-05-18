//
//  FilterTableViewController.swift
//  WeatherTracker_IOS
//
//  Created by Andreas on 2016-05-18.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {
    var days = [String]()
    var btntxt = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.alwaysBounceVertical = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return days.count
    }
    
    var i = 0
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FilterTableCell", forIndexPath: indexPath) as! FilterTableViewCell
        cell.DatumBtn.setTitle(days[i], forState: .Normal)

        cell.DatumBtn.addTarget(self, action: "filter:", forControlEvents: .TouchUpInside)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        i++
        
        return cell
    }
    
    
    // en funktion och skicka med datum för att filtera
    
    func filter(sender:UIButton){
        btntxt = sender.titleLabel!.text!
        
        performSegueWithIdentifier("goBack", sender: self)
    }
    


    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let tableView = segue.destinationViewController as! WeatherTableViewController
        tableView.dayfilter = btntxt
        
    }
}
