//
//  ScrollViewController.swift
//  WeatherTracker_IOS
//
//  Created by Andreas on 2016-04-21.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController ,UIScrollViewDelegate{
    
    
    @IBOutlet weak var Segment: UISegmentedControl!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBAction func segmentAction(sender: AnyObject) {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        switch Segment.selectedSegmentIndex {
        case 0:
            ScrollView.contentOffset.x = 0
        case 1:
            ScrollView.contentOffset.x = screenWidth
        case 2:
            ScrollView.contentOffset.x = screenWidth*2
        default:
            ScrollView.contentOffset.x = 0        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let currentLocation = ScrollView.contentOffset.x
        if(currentLocation<screenWidth){
            Segment.selectedSegmentIndex = 0
        }
        if(currentLocation<screenWidth*2&&currentLocation>=screenWidth){
            Segment.selectedSegmentIndex = 1
        }
        if(currentLocation<screenWidth*3&&currentLocation>=screenWidth*2){
            Segment.selectedSegmentIndex = 2
        }
        
    }
    
    override func viewDidLoad() {
        self.ScrollView.scrollEnabled = false//ingen skroll
        super.viewDidLoad()
        ScrollView.delegate = self
        let simpleTableController = SimpleTable(nibName: "SimpleTable", bundle: nil)
        self.addChildViewController(simpleTableController)
        
        self.ScrollView.addSubview(simpleTableController.view)
        simpleTableController.didMoveToParentViewController(self)
        let advancedTableController = AdvancedTable(nibName: "AdvancedTable", bundle: nil)
        
        var frame1 = advancedTableController.view.frame
        frame1.origin.x = self.view.frame.width
        advancedTableController.view.frame = frame1
        
        self.addChildViewController(advancedTableController)
        self.ScrollView.addSubview(advancedTableController.view)
        advancedTableController.didMoveToParentViewController(self)
        
        self.ScrollView.contentSize = CGSizeMake(self.view.frame.size.width*2, self.view.frame.size.height)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}