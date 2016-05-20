//
//  AdvancedController.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 29/04/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class AdvancedController: UIViewController,UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.WindDirFrom.delegate = self;
        self.WindDirTo.delegate = self;
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Temperatur parametrar och kontroller
    @IBOutlet weak var TempSlide: UISlider!
    @IBOutlet weak var TempSwitch: UISwitch!
    @IBOutlet weak var Temptxt: UILabel!
    
    @IBAction func TempSwitchChange(sender: AnyObject) {
        if(TempSwitch.on){
            TempSlide.enabled = true
            
            switch TempSlide.value {
            case -31:
                Temptxt.text = "Kallast"
            case 31:
                Temptxt.text = "Varmast"
            default:
                Temptxt.text = String(TempSlide.value)+"°C"
            }
        }
        else{
            TempSlide.enabled = false
            Temptxt.text = "Av"
        }
        
    }
    @IBAction func TempSlideChange(sender: AnyObject) {
        TempSlide.setValue(Float(lroundf(sender.value)), animated: false)
        
        switch TempSlide.value {
        case -31:
            Temptxt.text = "Kallast"
        case 31:
            Temptxt.text = "Varmast"
        default:
            Temptxt.text = String(TempSlide.value)+"°C"
        }
    }
    
    
    //Kodstycke som limiterar textfältens storlek
   
    @IBOutlet weak var WindDirFrom: UITextField!
    @IBOutlet weak var WindDirTo: UITextField!
    
    let limitLength = 3
    
    
    @IBAction func WindFromLimit(sender: AnyObject) {
        
        if(Int((WindDirFrom.text?.characters.count)!) > limitLength)
        {
            
            WindDirFrom.deleteBackward()
        }
        else if(Int(WindDirFrom.text!) > 360 || Int(WindDirFrom.text!) < 0)
        {
            UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                
                self.WindDirFrom!.alpha = 0.0
                }, completion: nil)
            UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                
                self.WindDirFrom!.alpha = 1.0
                }, completion: nil)
            
            WindDirFrom.deleteBackward()
        }
        
        
    }
    
        
    @IBAction func WindToLimit(sender: AnyObject) {
    
        if(Int((WindDirTo.text?.characters.count)!) > limitLength)
        {
            
            WindDirTo.deleteBackward()
        }
        else if(Int(WindDirTo.text!) > 360 || Int(WindDirTo.text!) < 0)
        {
            UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.WindDirTo!.alpha = 0.0
                
                }, completion: nil)
            UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                
                self.WindDirTo!.alpha = 1.0
                }, completion: nil)
            
            
            WindDirTo.deleteBackward()
        }
        
        
        
    }
    
    
    
    //Vindparametrar och kontroller
    @IBOutlet weak var Windtxt: UILabel!
    @IBOutlet weak var WindSwitch: UISwitch!
    @IBOutlet weak var WindSlide: UISlider!
    
    @IBAction func WindSwitchChange(sender: AnyObject) {
        if(WindSwitch.on){
            WindSlide.enabled = true
            
            switch WindSlide.value {
            case 20:
                Windtxt.text = "Max"
            default:
                Windtxt.text = String(WindSlide.value)+"m/s"
            }
        }
        else{
            WindSlide.enabled = false
            Windtxt.text = "Av"
        }
    }
    
    @IBAction func WindSlideChange(sender: AnyObject) {
        WindSlide.setValue(Float(lroundf(sender.value)), animated: false)
        
        switch WindSlide.value {
        case 20:
            Windtxt.text = "Max"
        default:
            Windtxt.text = String(WindSlide.value)+"m/s"
        }
    }
    
    @IBOutlet weak var cloudTxt: UILabel!
    
    @IBOutlet weak var cloudSlide: UISlider!
    @IBOutlet weak var cloudSwitch: UISwitch!
    
    @IBAction func cloudSwitchChange(sender: AnyObject) {
        if(cloudSwitch.on){
            cloudSlide.enabled = true
            cloudTxt.text = String(cloudSlide.value/8*100)+"%"
            
        }
        else{
            cloudSlide.enabled = false
            cloudTxt.text = "Av"
        }
        
    }
    
    @IBAction func cloudSlideChange(sender: AnyObject) {
        cloudSlide.setValue(Float(lroundf(sender.value)), animated: false)
        cloudTxt.text = String(cloudSlide.value/8*100)+"%"
    }
    @IBOutlet weak var WindDirSwitch: UISwitch!
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        ScrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
        
    }
    func textFieldDidEndEditing(textField: UITextField) {
        ScrollView.setContentOffset(CGPoint(x: 0, y: -70), animated: true)
    }
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBAction func WindDireSwitchChange(sender: AnyObject) {
        if(WindDirSwitch.on){
            WindDirFrom.enabled = true
            WindDirFrom.enablesReturnKeyAutomatically = true
            WindDirTo.enabled = true
        }
        else{
            WindDirFrom.enabled = false
            WindDirTo.enabled = false
            
        }
    }

    
    
    @IBAction func search(sender: AnyObject) {
            var paramters: [String: Double] = [String: Double]()
            //lägger in värden ifrån slides till paramters dictionary
            if(TempSwitch.on ){
                paramters["t"] = Double(TempSlide.value)
            }
            if(WindSwitch.on){
                paramters["ws"] = Double(WindSlide.value)
            }
            if(cloudSwitch.on){
                paramters["tcc_mean"] = Double(cloudSlide.value)
            }
            DataContainer.sharedDataContainer.Parameters = paramters
            
            DataContainer.sharedDataContainer.show = false
            print(paramters)

            //anropa funktion med days lista av dagar och paramteras som är key value pairs
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation

    
    
    /*func showMapHiddenResults(parameters: [String: Double], days: [String])
    {
    //Get the reference to the NavigationController which holds a reference to the map
    guard let navController: NavigationController = self.view.window?.rootViewController as? NavigationController else{
    print ("jag fick ingen navigation controller")
    return
    }
    
    
    //if top navigationController does not have a reference to a map then a new map will be created
    // else the current reference to a map will be used
        if navController.resView == nil{
            print("reference = resnil")
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            navController.resView = storyBoard.instantiateViewControllerWithIdentifier("ResView") as? CustomTabControllerViewController
                
        }
    
    
     DataContainer.sharedDataContainer.Parameters = parameters
     DataContainer.sharedDataContainer.Dates = days
     DataContainer.sharedDataContainer.show = false
     navController.resView!.ShowHide()
    
    self.navigationController?.pushViewController(navController.resView!, animated: true)
    
    }
 */

    
    
    
}