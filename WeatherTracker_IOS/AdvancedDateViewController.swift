//
//  AdvancedDateViewController.swift
//  WeatherTracker_IOS
//
//  Created by Andreas on 2016-05-04.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class AdvancedDateViewController: UIViewController {

    @IBOutlet weak var datePick: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        datePick.minimumDate = NSDate()
        datePick.timeZone = NSTimeZone.localTimeZone()
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let comp = NSDateComponents()
        comp.day = +10
        datePick.maximumDate = calender!.dateByAddingComponents(comp, toDate: NSDate(), options:[])!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    var startOrEnd = ""
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "setDate"){
            
            
            let datepick = segue.destinationViewController as! AdvancedController
            if(startOrEnd == "start"){
                
                datepick.startOrEnd = "start"
                datepick.startDate = datePick.date
                
            }
            else{
                
                
                datepick.startOrEnd = "end"
                datepick.endDate = datePick.date
                
            }
        }
    }
}

    

