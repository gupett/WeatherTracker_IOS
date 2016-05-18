//
//  CustomTabControllerViewController.swift
//  WeatherTracker_IOS
//
//  Created by Thim on 17/05/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class CustomTabControllerViewController: UITabBarController{

    @IBOutlet weak var TabBar: UITabBar!
    
    var mapRef : MapViewControlerViewController? = nil
    var navController: NavigationController!
    
    //reference to the searchbar
    var resultSearchController: UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
        
        
        
        resultSearchController?.navigationItem.backBarButtonItem?.title = "Bakåt"
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        print("dissapearing")
        DataContainer.sharedDataContainer.show = false
    }
    override func viewDidAppear(animated: Bool)
    {
        guard let navController = self.view.window?.rootViewController as? NavigationController else
        {
            print ("jag fick ingen navigation controller")
            print("inne i tabbar")
            return
        }
        
        
        if navController.mapView == nil{
            print("reference = nil")
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            
            navController.mapView = storyBoard.instantiateViewControllerWithIdentifier("MapView") as? MapViewControlerViewController
            
            
        }
        createSearchBar(navController.mapView!)
        


    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func ShowHide()
    {
        if(DataContainer.sharedDataContainer.show == true)
        {
            
            navigationItem.title = "Resultat"
            resultSearchController?.searchBar.hidden = true
            TabBar.hidden = false
        }
        else
        {
            navigationItem.title = nil
            resultSearchController?.searchBar.hidden = false
            TabBar.hidden = true
        }

        
    }
    func createSearchBar(mapView : MapViewControlerViewController){
        //Set up the search bar and corresponding tableview
        //To access the tableViewController
        
        let mapView = mapView.map
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
