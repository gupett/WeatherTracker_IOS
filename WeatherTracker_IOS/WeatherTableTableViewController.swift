//
//  WeatherTableViewController.swift
//  WeatherTracker_IOS
//
//  Created by Andreas on 2016-04-28.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit
var weathers = DataContainer.sharedDataContainer.ResultAnnotations

var filterweathers = DataContainer.sharedDataContainer.ResultAnnotations
var firstTime = true


class WeatherTableViewController: UITableViewController {
    var SliderMenu = SlideMenu()
    var dayfilter = ""
    @IBAction func filter(segue:UIStoryboardSegue) {
        weathers = filterweathers
        if(dayfilter != "totalt")
        {
        
       
            //weathers = weathers!.filter { $0.weatherContainer.paramDictionary["Datum"] == dayfilter}
            
        }
        tableView.reloadData()
    }
    override func viewDidAppear(animated: Bool) {
        weathers = DataContainer.sharedDataContainer.ResultAnnotations
        filterweathers = DataContainer.sharedDataContainer.ResultAnnotations
        print("tittade in")
        tableView.reloadData()
    }
    override func viewDidDisappear(animated: Bool) {
        weathers?.removeAll()
        print("försvann")
        
        tableView.reloadData()
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
        override func didReceiveMemoryWarning()
        {
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
        return weathers!.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "WeatherTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WeatherTableCell
        
        cell.LabelStad.text = weathers![indexPath.row].title
        cell.LabelDatum.text = weathers![indexPath.row].weatherContainer.paramDictionary["Datum"] as? String
        cell.WeatherImage.image = UIImage(named: "ic_sunny")!
        
        return cell
    }
    
    
    
    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "slideMenu"){
            if(firstTime){
                self.SliderMenu.hight = self.tableView.contentSize.height + 44.0
                firstTime = false
            }
            
            var veckodagar = [String]()
            for value in filterweathers {
                veckodagar += [value.day]
            }
            veckodagar = Array(Set(veckodagar))
            
            veckodagar += ["totalt"]
            
            let tableView = segue.destinationViewController as! FilterTableViewController
            tableView.transitioningDelegate = self.SliderMenu
            
            tableView.days = veckodagar
            
        }
        if(segue.identifier == "DetaljeradVy"){
            let indexPath = self.tableView.indexPathForSelectedRow
            let currentCell = self.tableView.cellForRowAtIndexPath(indexPath!) as! WeatherTableCell!
            let tableView = segue.destinationViewController as! DetaljeradTableViewController
            tableView.temp = currentCell.tempLabel.text!
        }
    }
 */
    
}
