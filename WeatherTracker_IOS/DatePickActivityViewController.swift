//
//  DatePickActivityViewController.swift
//  WeatherTracker_IOS
//
//  Created by Andreas on 19/05/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class DatePickActivityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
    @IBOutlet weak var DatePick: UIDatePicker!
    
    @IBOutlet weak var StartBtn: UIButton!

    @IBOutlet weak var endBtn: UIButton!
    @IBAction func VäljStart(sender: AnyObject) {
        let DateString = NSDateFormatter()
        DateString.dateFormat = "yyyy-MM-dd"
        let dateStr = DateString.stringFromDate(DatePick.date)
        start = DatePick.date
        sender.setTitle(dateStr, forState: .Normal)
        
    }
    
    @IBAction func VäljEnd(sender: AnyObject) {
        let DateString = NSDateFormatter()
        DateString.dateFormat = "yyyy-MM-dd"
        let dateStr = DateString.stringFromDate(DatePick.date)
        end = DatePick.date
        sender.setTitle(dateStr, forState: .Normal)
    }
    var start :NSDate = NSDate()
    var end : NSDate = NSDate()
    @IBAction func Search(sender: AnyObject) {
        var days: [String] = []
        let DateString = NSDateFormatter()
        DateString.dateFormat = "yyyy-MM-dd"
        var tempDate = start
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let endDatestr = DateString.stringFromDate(end)
        var startDatestr = DateString.stringFromDate(start)
        //om start är efter slut datum gå ej vidare
        
        //om man inte har valet ett värde på datum gå ej vidare och knapp blinkar
        if(StartBtn.titleLabel?.text == "Välj"){
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.StartBtn!.alpha = 0.0
                }, completion: nil)
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.StartBtn!.alpha = 1.0
                }, completion: nil)
        }
        else if(endBtn.titleLabel?.text == "Välj"){
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.endBtn!.alpha = 0.0
                }, completion: nil)
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.endBtn!.alpha = 1.0
                }, completion: nil)
        }
            
        else if(start.compare(end) == NSComparisonResult.OrderedAscending || endBtn.titleLabel?.text == StartBtn.titleLabel?.text){
            // gå igenom alla datum jämför strängarna
            while endDatestr != startDatestr {
                
                days.append(DateString.stringFromDate(tempDate))
                tempDate = (calender?.dateByAddingUnit(.Day, value: 1, toDate: tempDate, options: []))!
                startDatestr = DateString.stringFromDate(tempDate)
                
            }
            //behöver lägga till sista datumet eftersom vi avbryter när datum blir lika
            days.append(DateString.stringFromDate(tempDate))
           
            
        
        DataContainer.sharedDataContainer.Dates = days

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
        navController.resView?.ShowHide()
        
        self.navigationController?.pushViewController(navController.resView!, animated: true)
        }
        else{
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.endBtn!.alpha = 0.0
                }, completion: nil)
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.endBtn!.alpha = 1.0
                }, completion: nil)
        }
        
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
