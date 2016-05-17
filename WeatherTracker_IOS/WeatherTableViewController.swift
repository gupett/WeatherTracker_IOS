//
//  WeatherTableViewController.swift
//  WeatherTracker_IOS
//
//  Created by Andreas on 2016-04-28.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit
var weathers = [weather]()

var filterweathers = [weather]()
var firstTime = true


class WeatherTableViewController: UITableViewController {
    var SliderMenu = SlideMenu()
    var dayfilter = ""
    @IBAction func filter(segue:UIStoryboardSegue) {
        weathers = filterweathers
        if(dayfilter == "totalt"){
        }
        else{
            weathers = weathers.filter { $0.day == dayfilter}

        }
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadResult()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func loadResult(){
        let w1 = weather(day: "02-02-2016",stad: "Stockholm", temp: 10, rank: 1)
        let w2 = weather(day: "02-03-2016",stad: "Kista", temp: 2, rank: 2)
        //let w3 = weather(day: "tisdag",stad: "Sundsvall", temp:-20, rank: 3)
        weathers += [w1,w2]
        filterweathers = weathers
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
        return weathers.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "WeatherTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WeatherTableCell
        let value = weathers[indexPath.row]
        cell.tempLabel.text = String(value.temp)+"°C"
        cell.stadLabel.text = value.stad
        cell.rankLabel.text = String(value.rank)
        cell.dagLabel.text = value.day
    
        return cell
    }
    


    
    // MARK: - Navigation
    
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

}
