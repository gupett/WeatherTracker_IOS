//
//  advancedTableViewController.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 2016-04-27.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class advancedTableViewController: UITableViewController {
    
    
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    @IBAction func segmentAction(sender: AnyObject) {
        switch segmentOutlet.selectedSegmentIndex {
        case 0:
            let nextView = self.storyboard!.instantiateViewControllerWithIdentifier("activitet")
            for view in (self.navigationController?.viewControllers)! {
                if(view.isKindOfClass(ActivityCollectionViewController)){
                    self.navigationController?.popToViewController(view, animated: false)
                }
            }
            
            self.navigationController?.pushViewController(nextView, animated: false)
            
            
        case 1:
            let nextView = self.storyboard!.instantiateViewControllerWithIdentifier("simpelTable")
            for view in (self.navigationController?.viewControllers)! {
                if(view.isKindOfClass(SimpelTableViewController)){
                    self.navigationController?.popToViewController(view, animated: false)
                }
            }
            
            self.navigationController?.pushViewController(nextView, animated: false)
        default:
            print("no")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let orange =  UIColor(red: 1.0, green: 158.0/255.0, blue: 0, alpha: 1.0)
        segmentOutlet.tintColor = orange
        segmentOutlet.selectedSegmentIndex = 2
        
        
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
        return 3
    }

}
