//
//  ActivityDateViewController.swift
//  WeatherTracker_IOS
//
//  Created by Andreas on 2016-05-19.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class ActivityDateViewController: UIViewController {
    var DatePickMenu = SlideMenu()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var startDate:NSDate = NSDate()
    var endDate:NSDate = NSDate()
    var startOrEnd = ""
    
    @IBOutlet weak var endDateBtn: UIButton!
    @IBOutlet weak var startDateBtn: UIButton!
    @IBAction func setDate(segue:UIStoryboardSegue) {
        let DateString = NSDateFormatter()
        DateString.dateFormat = "yyyy-MM-dd"
        if(startOrEnd == "start"){
            let dateStr = DateString.stringFromDate(startDate)
            startDateBtn.setTitle(dateStr, forState: .Normal)
        }
        else{
            let dateStr = DateString.stringFromDate(endDate)
            endDateBtn.setTitle(dateStr, forState: .Normal)
        }
    }
    @IBAction func abort(segue:UIStoryboardSegue) {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "startDate"){
            
            self.DatePickMenu.height = self.view.frame.height
            self.DatePickMenu.moved = -250
            
            let datepick = segue.destinationViewController as! DatePickerActivityViewController
            datepick.transitioningDelegate = self.DatePickMenu
            datepick.startOrEnd = "start"
            
        }
        if(segue.identifier == "endDate"){
            
            self.DatePickMenu.height = self.view.frame.height
            self.DatePickMenu.moved = -250
            
            let datepick = segue.destinationViewController as! DatePickerActivityViewController
            datepick.transitioningDelegate = self.DatePickMenu
            datepick.startOrEnd = "end"
            //datepick.dateRst = endDate
            
        }
    }
    

}
