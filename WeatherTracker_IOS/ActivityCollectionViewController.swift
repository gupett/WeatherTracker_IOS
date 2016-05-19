//
//  ActivityCollectionViewController.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 21/04/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ActivityCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    var DatePickMenu = SlideMenu()

    //Definera datan som skall finnas i varje cell. Väder kopplas till parametrar i sista inputparameter
    var activities: [Activity] =
        [Activity(_image: UIImage(named: "ic_sunny")!, _name: "Sol, Klar Himmel",_param: ["t" : 20, "tcc_mean" : 0]),
         Activity(_image: UIImage(named: "ic_mostly_cloudy")!, _name: "Sol, Molnighet",_param: ["t" : 20, "tcc_mean" : 3]),
         Activity(_image: UIImage(named: "ic_haze")!, _name: "Sol, Disigt",_param: ["t" : 31, "tcc_mean" : 6]),
         Activity(_image: UIImage(named: "ic_cloudy")!, _name: "Molnigt",_param: ["tcc_mean" : 8]),
         Activity(_image: UIImage(named: "ic_slight_rain")!, _name: "Sol, Lätt Regn",_param: ["tcc_mean" : 4]),
         Activity(_image: UIImage(named: "ic_rain")!, _name: "Mycket Regn",_param: ["t" : 31, "tcc_mean" : 8]),
         Activity(_image: UIImage(named: "ic_thunderstorms")!, _name: "Åska",_param: ["t" : 31, "tcc_mean" : 4, "ws" : 3]),
         Activity(_image: UIImage(named: "ic_snow")!, _name: "Snö",_param: ["t" : -5, "tcc_mean" : 3])]
    
    var mapView: MapViewControlerViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        /*self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)*/
        
        // Do any additional setup after loading the view.
        
        //cellLayout()
        
        configureNavigationBar()
    }
    
    // Have to worke with "must register a nib or a class for the identifier or connect a prototype cell in a storyboard"
    /*func cellLayout(){
     let layout = UICollectionViewFlowLayout()
     layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
     layout.minimumInteritemSpacing = 0
     layout.minimumLineSpacing = 0
     collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
     }*/
    
    //Set the appearance of the navigationcontroler
    func configureNavigationBar(){
        //Set the attributes of navigaton controller, it's color to blue
        self.navigationController?.navigationBar.backgroundColor = UIColor(colorLiteralRed: 25/256, green: 118/256, blue: 210/256, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 25/256, green: 118/256, blue: 210/256, alpha: 1)
        
        //Set the title to activity and it's color to white
        self.navigationItem.title = "Activity"
        let dictColor = [NSForegroundColorAttributeName: UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 1)]
        self.navigationController?.navigationBar.titleTextAttributes = dictColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return activities.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        // Configure the cell
        
        let activity = activities[indexPath.row]
        let imageView = cell.viewWithTag(2) as! UIImageView
        imageView.image = activity.image
        let label = cell.viewWithTag(1) as! UILabel
        label.text = activity.name
        label.textColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 1)
        
        
        
        
        /*//cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, 108)
         //cell.frame = CGRectMake(<#T##x: CGFloat##CGFloat#>, <#T##y: CGFloat##CGFloat#>, <#T##width: CGFloat##CGFloat#>, <#T##height: CGFloat##CGFloat#>)
         
         //Get the properties of the screen
         let screenSize: CGRect = UIScreen.mainScreen().bounds
         let cellWith = (screenSize.width/2) - 20
         //Place the cell frame in the wished lokation
         cell.frame = CGRectMake(cell.frame.origin.x + 10, cell.frame.origin.y + 10, cellWith,
         cellWith)*/
        cell.contentView.layer.cornerRadius = 10.0;
        cell.contentView.layer.borderWidth = 2.0;
        cell.contentView.layer.borderColor = UIColor.clearColor().CGColor;
        cell.contentView.layer.masksToBounds = true;
        
        cell.layer.shadowColor = UIColor.grayColor().CGColor;
        cell.layer.shadowOffset = CGSizeMake(0, 2.0);
        cell.layer.shadowRadius = 2.0;
        cell.layer.shadowOpacity = 1.0;
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).CGPath;
        
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    // Set the size of the cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let cellWith = (screenSize.width/2) - 15
        return CGSize(width: cellWith, height: cellWith + 15)
    }
    
    // Set the outer boundaries for the cell to the top, bottom and sides
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        //bottom input ändrad så att man kan se även hela den undre cellen
        return UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 10)
    }
    
    
    // MARK: UICollectionViewDelegate
    // will be called if cell is selected
    /*
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //Get the reference to the NavigationController which holds a reference to the map
        guard let navController: NavigationController = self.view.window?.rootViewController as? NavigationController else{
            print ("jag fick ingen navigation controller")
            return
        }
        
        
        //if top navigationController does not have a reference to a map then a new map will be created
        // else the current reference to a map will be used
        if navController.resView == nil{
            print("reference = nil")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            
            navController.resView = storyBoard.instantiateViewControllerWithIdentifier("ResView") as? CustomTabControllerViewController
        }
        
        /*
        navController.mapView!.searchParams = self.activities[indexPath.row].param
        */
        DataContainer.sharedDataContainer.Parameters = self.activities[indexPath.row].param
        DataContainer.sharedDataContainer.Dates = ["2016-05-18"]
        DataContainer.sharedDataContainer.show = false
        navController.resView?.ShowHide()
        
        
        self.navigationController?.pushViewController(navController.resView!, animated: true)
    }
    */
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
     
     }
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "pickDate"){
            
            self.DatePickMenu.height = self.view.frame.height
            self.DatePickMenu.moved = -100
            let datepick = segue.destinationViewController as! ActivityDateViewController
            datepick.transitioningDelegate = self.DatePickMenu
            
            
        }
                
    }
    
}
