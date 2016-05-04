//
//  SimpleController.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 29/04/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class SimpleController: UIViewController {
    var DatePickMenu = SlideMenu()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBOutlet weak var TempSlide: UISlider!
    
    
    @IBOutlet weak var Temptxt: UILabel!
    @IBAction func chooseTemp(sender: AnyObject) {
        TempSlide.setValue(Float(lroundf(sender.value)), animated: false)
        switch TempSlide.value {
        case 0:
            Temptxt.text = "Av"
        case 1:
            Temptxt.text = "Kallast"
        case 2:
            Temptxt.text = "Varmast"
        default:
            Temptxt.text = nil
        }
    }
    
    @IBOutlet weak var WindTxt: UILabel!
    
    @IBOutlet weak var WindSlide: UISlider!
    @IBAction func chooseWind(sender: AnyObject) {
        WindSlide.setValue(Float(lroundf(sender.value)), animated: false)
        switch WindSlide.value {
        case 0:
            WindTxt.text = "Av"
        case 1:
            WindTxt.text = "Lite"
        case 2:
            WindTxt.text = "Mellan"
        case 3:
            WindTxt.text = "Mycket"
        default:
            WindTxt.text = nil
        }
    }
    
    @IBOutlet weak var cloudTxt: UILabel!
  
    @IBOutlet weak var cloudSlide: UISlider!
   
    @IBAction func chooseCloud(sender: AnyObject) {
        cloudSlide.setValue(Float(lroundf(sender.value)), animated: false)
        switch cloudSlide.value {
        case 0:
            cloudTxt.text = "av"
        case 1:
            cloudTxt.text = "Lite"
        case 2:
            cloudTxt.text = "Mellan"
        case 3:
            cloudTxt.text = "Mycket"
        default:
            cloudTxt.text = nil
        }
    }
    
    @IBOutlet weak var chooseRain: UISwitch!
    var startDate:NSDate = NSDate()
    var endDate:NSDate = NSDate()
    var startOrEnd = ""
    @IBOutlet weak var startDateBtn: UIButton!
    
    @IBOutlet weak var endDateBtn: UIButton!
    @IBAction func start(segue:UIStoryboardSegue) {
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
    
    //avbryt knapp för välj datum
    @IBAction func abortDate(segue:UIStoryboardSegue) {
        
    }
    
    //sökknapp trycks
    
    @IBAction func search(sender: AnyObject) {
        //skapar lista för datum och formaterar datum till sträng
        var days: [String] = []
        let DateString = NSDateFormatter()
        DateString.dateFormat = "yyyyMMdd"
        var tempDate = startDate
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
       let endDatestr = DateString.stringFromDate(endDate)
        var startDatestr = DateString.stringFromDate(startDate)
        //om start är efter slut datum gå ej vidare
        if (startDate.compare(endDate) == NSComparisonResult.OrderedDescending){
            print("no")
        }
        //om man inte har valet ett värde på datum gå ej vidare och knapp blinkar
        else if(startDateBtn.titleLabel?.text == "Start Datum"){
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.startDateBtn!.alpha = 0.0
                }, completion: nil)
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.startDateBtn!.alpha = 1.0
                }, completion: nil)
        }
        else if(endDateBtn.titleLabel?.text == "Slut Datum"){
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.endDateBtn!.alpha = 0.0
                }, completion: nil)
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.endDateBtn!.alpha = 1.0
                }, completion: nil)
        }
            
        else{
            // gå igenom alla datum jämför strängarna
            while endDatestr != startDatestr {
                
                days.append(DateString.stringFromDate(tempDate))
                tempDate = (calender?.dateByAddingUnit(.Day, value: 1, toDate: tempDate, options: []))!
                startDatestr = DateString.stringFromDate(tempDate)

            }
            //behöver lägga till sista datumet eftersom vi avbryter när datum blir lika
            days.append(DateString.stringFromDate(tempDate))
            var paramters: [String: Double] = [String: Double]()
            //lägger in värden ifrån slides till paramters dictionary
            if(TempSlide.value == 1){
                paramters["t"] = -31
            }
            else if(TempSlide.value == 2){
                paramters["t"] = 31
            }

            
            if(WindSlide.value == 1){
                paramters["ws"] = 3
            }
            else if(WindSlide.value == 2){
                paramters["ws"] = 6
            }
            else if(WindSlide.value == 3){
                paramters["ws"] = 10
            }
            
            if(cloudSlide.value == 1){
                paramters["tcc_mean"] = 0
            }
            else if(cloudSlide.value == 2){
                paramters["tcc_mean"] = 4
            }
            else if(cloudSlide.value == 3){
                paramters["tcc_mean"] = 8
            }
            
            //anropa funktion med days lista av dagar och paramteras som är key value pairs
            print(days)
            print(paramters)

        }
        

    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //startar slide menyn och skickar över om vi vill ha start eller slut datum
        if(segue.identifier == "chooseStartDate"){
           
            self.DatePickMenu.height = self.view.frame.height
            
            let datepick = segue.destinationViewController as! DateViewController
            datepick.transitioningDelegate = self.DatePickMenu
            datepick.startOrEnd = "start"
            
        }
        if(segue.identifier == "chooseEndDate"){
            
            self.DatePickMenu.height = self.view.frame.height
            
            let datepick = segue.destinationViewController as! DateViewController
            datepick.transitioningDelegate = self.DatePickMenu
            datepick.startOrEnd = "end"
            //datepick.dateRst = endDate
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
