//
//  CustomTabControllerViewController.swift
//  WeatherTracker_IOS
//
//  Created by Thim on 17/05/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class CustomTabControllerViewController: UITabBarController {

    @IBOutlet weak var TabBar: UITabBar!
    
    //reference to the searchbar
    var resultSearchController: UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool)
    {
        
        resultSearchController?.navigationItem.backBarButtonItem?.title = "Bakåt"
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func ShowHide()
    {
        if(DataContainer.sharedDataContainer.show == true)
        {
            
            resultSearchController?.navigationItem.title = "Resultat"
            resultSearchController?.searchBar.hidden = true
            TabBar.hidden = false
        }
        else
        {
            resultSearchController?.navigationItem.title = nil
            resultSearchController?.searchBar.hidden = false
            TabBar.hidden = true
        }

        
    }
    func createSearchBar(){
        //Set up the search bar and corresponding tableview
        //To access the tableViewController
        
        let map = storyboard!.instantiateViewControllerWithIdentifier("MapView") as! MapViewControlerViewController
        let mapView = map.map
        let resultSearchTable = storyboard!.instantiateViewControllerWithIdentifier("LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: resultSearchTable)
        resultSearchController?.searchResultsUpdater = resultSearchTable
        
        
        //configures the search bar, and embeds it within the navigation bar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        //add the search bar on teh top of the screen
        navigationItem.titleView = resultSearchController?.searchBar
        navigationItem.titleView?.hidden = false
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        
        //Make sure that the overlay does not cover the searchbar
        definesPresentationContext = true
        
        //Give the LocationSearchTable access to add and modify the map
        resultSearchTable.map = mapView
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
