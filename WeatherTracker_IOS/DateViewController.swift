//
//  DateViewController.swift
//  WeatherTracker_IOS
//
//  Created by Andreas on 2016-05-02.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet weak var abort: UIButton!
    @IBOutlet weak var ChooseDate: UIButton!
    @IBOutlet weak var DatePick: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        //säter min och max datum
        DatePick.timeZone = NSTimeZone.localTimeZone()

        DatePick.minimumDate = NSDate()
        DatePick.timeZone = NSTimeZone.localTimeZone()
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let comp = NSDateComponents()
        comp.day = +10
        DatePick.maximumDate = calender!.dateByAddingComponents(comp, toDate: NSDate(), options:[])!
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
        //skickar valt datum beronde på om vi kommer ifrån start eller slut
        if(segue.identifier == "setDate"){
            
            
            let datepick = segue.destinationViewController as! SimpleController
            if(startOrEnd == "start"){
               
                datepick.startOrEnd = "start"
                datepick.startDate = DatePick.date
              
            }
            else{
                
                
                datepick.startOrEnd = "end"
                datepick.endDate = DatePick.date
                
            }
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
