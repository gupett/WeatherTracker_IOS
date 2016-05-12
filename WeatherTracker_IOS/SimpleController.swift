//
//  SimpleController.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 29/04/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class SimpleController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var DatePickMenu = SlideMenu()
    
    //Referens till vår PickerView (alternativ extra label)
    @IBOutlet weak var PickerView: UIPickerView!
    
    
    
    //Slider referens och textdata referens
    @IBOutlet weak var ParameterSlider: UISlider!
    @IBOutlet weak var ParameterTxtData: UILabel!
    var Func_Changer = 0
    
    
    
    //Strängdata som skall snurra på hjulet i picker.
    let pickerdata = ["Temperatur","Molnighet", "Vind", "Nederbörd"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerView.dataSource = self
        PickerView.delegate = self
        ParameterTxtData.text = "Kallast"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    // definerar källdatan som ska in i pickerview.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerdata.count
    }
    //MARK: Delegates
    //Delegerar datan till pickerview
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerdata[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.showsSelectionIndicator = true
        switch pickerdata[row]
        {
        case "Temperatur":
            Func_Changer = 0
            ParameterTxtData.text = "Kallast"
            ParameterSlider.minimumValue = 0
            ParameterSlider.maximumValue = 1
            ParameterSlider.setValue(0, animated: false)
            UIView.animateWithDuration(1.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.ParameterSlider!.alpha = 0.0
                self.ParameterTxtData!.alpha = 0.0
                }, completion: nil)
            UIView.animateWithDuration(1.5, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
               
                self.ParameterSlider!.alpha = 1.0
                self.ParameterTxtData!.alpha = 1.0
                }, completion: nil)

            break
        case "Molnighet":
            Func_Changer = 1
            ParameterTxtData.text = "Lite"
            ParameterSlider.maximumValue = 2
             ParameterSlider.setValue(0, animated: false)
            UIView.animateWithDuration(1.5, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.ParameterSlider!.alpha = 0.0
                self.ParameterTxtData!.alpha = 0.0
                }, completion: nil)
            UIView.animateWithDuration(1.5, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.ParameterSlider!.alpha = 1.0
                self.ParameterTxtData!.alpha = 1.0
                }, completion: nil)
            break
        case "Vind":
            Func_Changer = 1
            ParameterTxtData.text = "Lite"
            ParameterSlider.maximumValue = 2
             ParameterSlider.setValue(0, animated: false)
            UIView.animateWithDuration(1.5, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.ParameterSlider!.alpha = 0.0
                self.ParameterTxtData!.alpha = 0.0
                }, completion: nil)
            UIView.animateWithDuration(1.5, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.ParameterSlider!.alpha = 1.0
                self.ParameterTxtData!.alpha = 1.0
                }, completion: nil)
            break
        case "Nederbörd":
            Func_Changer = 2
            ParameterTxtData.text = "Av"
            ParameterSlider.maximumValue = 1
             ParameterSlider.setValue(0, animated: false)
            UIView.animateWithDuration(1.5, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.ParameterSlider!.alpha = 0.0
                self.ParameterTxtData!.alpha = 0.0
                }, completion: nil)
            UIView.animateWithDuration(1.5, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.ParameterSlider!.alpha = 1.0
                self.ParameterTxtData!.alpha = 1.0
                }, completion: nil)
            break
        default:
            break
        }
        
        
    }
    
    @IBAction func changeSlider(sender: AnyObject) {
        
        ParameterSlider.setValue(Float(lroundf(sender.value)), animated: false)
        switch Func_Changer
        {
        case 0:
            switch ParameterSlider.value
            {
            case 0:
                ParameterTxtData.text = "Kallast"
            case 1:
                ParameterTxtData.text = "Varmast"
            default:
                break
            }
            break
            
        case 1:
            switch ParameterSlider.value
            {
            case 0:
                ParameterTxtData.text = "Lite"
            case 1:
                ParameterTxtData.text = "Mellan"
            case 2:
                ParameterTxtData.text = "Mycket"
            default:
                break
            }
            break
        case 2:
            switch ParameterSlider.value
            {
            case 0:
                ParameterTxtData.text = "Av"
            case 1:
                ParameterTxtData.text = "På"
            default:
                break
            }
            break

      
        default:
            break
        
        }
        
        

    }
     
   
    
    
    

    
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
            
            /*
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
             */
            
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
