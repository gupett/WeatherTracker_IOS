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
    
    var activities: [Activity] = [Activity(_image: UIImage(named: "Kite")!, _name: "Kitesurfing"), Activity(_image: UIImage(named: "Skiing")!, _name: "Skidåkning"), Activity(_image: UIImage(named: "Running")!, _name: "Löpning"), Activity(_image: UIImage(named: "Sailing")!, _name: "Segling"), Activity(_image: UIImage(named: "Biking")!, _name: "Cykling"), Activity(_image: UIImage(named: "Beach")!, _name: "Bada")]

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
        cell.frame = CGRectMake(cell.frame.origin.x + 10, cell.frame.origin.y + 10, cellWith, cellWith)*/
        
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
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let mapView: MapViewControlerViewController = storyBoard.instantiateViewControllerWithIdentifier("MapView") as! MapViewControlerViewController
        
        self.navigationController?.pushViewController(mapView, animated: false)
    }
    
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

}
