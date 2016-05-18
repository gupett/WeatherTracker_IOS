//
//  WeatherTableViewController.swift
//  WeatherTracker_IOS
//
//  Created by Andreas on 2016-04-28.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit
var weathers = DataContainer.sharedDataContainer.resultDic!["best"]

var filterweathers = DataContainer.sharedDataContainer.resultDic
var dates :[String] = NSArray(array:DataContainer.sharedDataContainer.Dates!
, copyItems: true) as! [String]
var firstTime = true


class WeatherTableViewController: UITableViewController {
    
    var SliderMenu = SlideMenu()
    var dayfilter:String = ""
    @IBAction func goBack(segue:UIStoryboardSegue) {
        if(dayfilter != "totalt")
        {

            weathers = filterweathers![dayfilter]
            
        }
        else{
            weathers = filterweathers!["best"]
        }
        tableView.reloadData()
    }
    override func viewDidAppear(animated: Bool) {
        //HIDE BACK BUTTON
        self.tabBarController?.navigationItem.hidesBackButton = true
        weathers = DataContainer.sharedDataContainer.resultDic!["best"]
        filterweathers = DataContainer.sharedDataContainer.resultDic

        dates = NSArray(array:DataContainer.sharedDataContainer.Dates!
            , copyItems: true) as! [String]
        dates += ["totalt"]
        

        //filterweathers = DataContainer.sharedDataContainer.weathers
        print("tittade in")
        tableView.reloadData()
    }
    override func viewDidDisappear(animated: Bool) {
        
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
        //cell.LabelStad.text = weathers![indexPath.row].title
        cell.LabelDatum.text = weathers![indexPath.row].date
        
        
        
        
        //cell.WeatherImage = MapViewControlerViewController().imageForCallout(weathers![indexPath.row].weatherContainer.weatherSymbol)

        return cell
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "filter"){
            
                let a = Double(dates.count)
                self.SliderMenu.moved = CGFloat(44.0 * a)
                self.SliderMenu.height = 0.0
                firstTime = false
            
            
            
            
         
            let tableView = segue.destinationViewController as! FilterTableViewController
            tableView.transitioningDelegate = self.SliderMenu
            
            tableView.days = dates
            
        }
        if(segue.identifier == "DetaljeradVy"){
            let indexPath = self.tableView.indexPathForSelectedRow
            let currentCell = self.tableView.cellForRowAtIndexPath(indexPath!) as! WeatherTableCell!
            //let tableView = segue.destinationViewController as! DetaljeradTableViewController
            //tableView.temp = currentCell.tempLabel.text!
        }

    }
    
}
