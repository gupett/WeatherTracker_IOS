//
//  LocationSearchTable.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 12/04/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable: UITableViewController, UISearchResultsUpdating {
    
    var matchingItems: [MKMapItem] = []
    var map: MKMapView? = nil
    
    //This method is automatically called whenever the search bar becomes the first responder or changes are made to the text in the search bar (UISearchResultsUpdating protocol)
    func updateSearchResultsForSearchController(searchController: UISearchController){
        
        //Make sure map and search bar are not nil
        guard let mapView = map,
            let searchBar = searchController.searchBar.text else{
                print("erreor no searchbar or map")
                return
        }
        //Setting up the request which will be sent
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBar
        request.region = mapView.region
        
        //Make the call to API
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler({ (response, _)
            in
            guard let responseData = response else {
                print("Error no response data received")
                return
            }
            self.matchingItems = responseData.mapItems
            self.tableView.reloadData()
        })
        
    }
    
    //Copied code to parse an adress from MKPlacemark
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return matchingItems.count
    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        //Fetching the data received in the API call earlier and creating a placemark object
        //Placemark data includes information such as the country, state, city, and street address associated with the specified coordinate
        let cellItem = matchingItems[indexPath.row].placemark
        //Configuring the cell
        cell.textLabel?.text = cellItem.name
        cell.detailTextLabel?.text = parseAddress(cellItem)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showMap") {
            if let indexpath = self.tableView.indexPathForSelectedRow {
                let mapItem: MKMapItem = matchingItems[indexpath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! MapViewControlerViewController
                controller.searchCoordinate = mapItem.placemark.coordinate
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
    if let indexPath = self.tableView.indexPathForSelectedRow {
    let object = objects[indexPath.row] as! NSDate
    let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
    controller.detailItem = object
    controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
    controller.navigationItem.leftItemsSupplementBackButton = true
    }
    }
    }

    */

}
