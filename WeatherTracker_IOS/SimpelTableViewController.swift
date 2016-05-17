//
//  SimpelTableViewController.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 2016-04-26.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class SimpelTableViewController: UITableViewController {
    //temp start
    var datePickRef:UIDatePicker = UIDatePicker()
    var enddatePickRef:UIDatePicker = UIDatePicker()
    var overlayRef:UIView = UIView()
    var minDate:NSDate = NSDate()
    var maxDate:NSDate = NSDate()
    @IBOutlet weak var tempSlider: UISlider!
    @IBOutlet weak var tempLabel: UILabel!
    @IBAction func tempSliderAction(sender: AnyObject) {
        tempSlider.setValue(Float(lroundf(sender.value)), animated: false)
        switch tempSlider.value {
        case 0:
            tempLabel.text = "av"
        case 1:
            tempLabel.text = "kallast"
        case 2:
            tempLabel.text = "varmast"
        default:
            tempLabel.text = nil
        }
        
    }
    //moln start
    @IBOutlet weak var molnLabel: UILabel!
    @IBOutlet weak var molnSlider: UISlider!
    @IBAction func molnSlider(sender: AnyObject) {
        molnSlider.setValue(Float(lroundf(sender.value)), animated: false)
        switch molnSlider.value {
        case 0:
            molnLabel.text = "av"
        case 1:
            molnLabel.text = "lagom"
        case 2:
            molnLabel.text = "för mycket"
        default:
            molnLabel.text = nil
        }
        
    }
    
    //vind start
    @IBOutlet weak var vindSlider: UISlider!
    @IBOutlet weak var vindLabel: UILabel!
    @IBAction func vindSliderAction(sender: AnyObject) {
        vindSlider.setValue(Float(lroundf(sender.value)), animated: false)
        switch vindSlider.value {
        case 0:
            vindLabel.text = "av"
        case 1:
            vindLabel.text = "lagom"
        case 2:
            vindLabel.text = "för mycket"
        default:
            vindLabel.text = nil
        }
    }
    
    //date start
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextFild: UITextField!
    @IBAction func startDateAction(sender: UITextField!) {
        let btnView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let overlayBlur = UIVisualEffectView(effect: blurEffect)
        overlayBlur.frame = self.view.bounds
        overlayBlur.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        overlayBlur.userInteractionEnabled = false
        self.navigationController?.navigationBarHidden = true
        overlayRef = overlayBlur
        self.view.addSubview(overlayBlur)
        
        let datePicker : UIDatePicker = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.minimumDate = NSDate()
        datePicker.maximumDate = maxDate
        datePickRef = datePicker
        btnView.addSubview(datePicker)
        let avbrytBtn = UIButton(frame: CGRectMake(0, 0, 100, 50))
        avbrytBtn.setTitle("avbryt", forState: .Normal)
        btnView.addSubview(avbrytBtn)
        let valjBtn = UIButton(frame: CGRectMake((self.view.frame.size.width/1.5), 0, 100, 50))
        valjBtn.setTitle("välj", forState: .Normal)
        btnView.addSubview(valjBtn)
        sender.inputView = btnView
        
        valjBtn.addTarget(self, action:"startChoose", forControlEvents: UIControlEvents.TouchUpInside)
        avbrytBtn.addTarget(self, action:"abort", forControlEvents: UIControlEvents.TouchUpInside)
        
        
    }
    func startChoose(sender: UIButton){
        let DateString = NSDateFormatter()
        DateString.dateFormat = "dd-MM-yyyy"
        let DatePicked = DateString.stringFromDate(datePickRef.date)
        
        startDateTextField.text = DatePicked
        minDate = datePickRef.date
        self.navigationController?.navigationBarHidden = false
        overlayRef.removeFromSuperview()
        startDateTextField.resignFirstResponder()
    }
    @IBAction func endDateAction(sender: UITextField) {
        let btnView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let overlayBlur = UIVisualEffectView(effect: blurEffect)
        overlayBlur.frame = self.view.bounds
        overlayBlur.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        overlayBlur.userInteractionEnabled = false
        self.navigationController?.navigationBarHidden = true
        overlayRef = overlayBlur
        self.view.addSubview(overlayBlur)
        
        
        
        let datePicker : UIDatePicker = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.minimumDate = minDate
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let comp = NSDateComponents()
        comp.day = +10
        datePicker.maximumDate = calender!.dateByAddingComponents(comp, toDate: NSDate(), options: NSCalendarOptions(rawValue:0))!
        
        datePickRef = datePicker
        btnView.addSubview(datePicker)
        
        
        
        let avbrytBtn = UIButton(frame: CGRectMake(0, 0, 100, 50))
        avbrytBtn.setTitle("avbryt", forState: .Normal)
        btnView.addSubview(avbrytBtn)
        let valjBtn = UIButton(frame: CGRectMake((self.view.frame.size.width/1.5), 0, 100, 50))
        valjBtn.setTitle("välj", forState: .Normal)
        btnView.addSubview(valjBtn)
        
        sender.inputView = btnView
        
        valjBtn.addTarget(self, action:"endChoose", forControlEvents: UIControlEvents.TouchUpInside)
        avbrytBtn.addTarget(self, action:"abort", forControlEvents: UIControlEvents.TouchUpInside)
    }
    func endChoose(sender: UIButton){
        let DateString = NSDateFormatter()
        DateString.dateFormat = "yyyy-MM-dd"
        let DatePicked = DateString.stringFromDate(datePickRef.date)
        self.navigationController?.navigationBarHidden = false
        endDateTextFild.text = DatePicked
        maxDate = datePickRef.date
        overlayRef.removeFromSuperview()
        endDateTextFild.resignFirstResponder()
    }
    
    func abort(sender: UIButton){
        self.navigationController?.navigationBarHidden = false
        overlayRef.removeFromSuperview()
        endDateTextFild.resignFirstResponder()
        startDateTextField.resignFirstResponder()
    }
    //button start
    @IBOutlet weak var mapButton: UIButton!

    //segment controler start
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    @IBAction func segmentAction(sender: AnyObject) {
        switch segmentOutlet.selectedSegmentIndex {
        case 0:
            let nextView = self.storyboard!.instantiateViewControllerWithIdentifier("activitet")
            for view in (self.navigationController?.viewControllers)! {
                if(view.isKindOfClass(ActivityCollectionViewController)){
                    self.navigationController?.popToViewController(view, animated: false)
                }
            }
            
            self.navigationController?.pushViewController(nextView, animated: false)

             
        case 2:
            let nextView = self.storyboard!.instantiateViewControllerWithIdentifier("advancedTabel")
            for view in (self.navigationController?.viewControllers)! {
                if(view.isKindOfClass(advancedTableViewController)){
                    self.navigationController?.popToViewController(view, animated: false)
                }
            }
            
            self.navigationController?.pushViewController(nextView, animated: false)
        default:
            print("no")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let orange =  UIColor(red: 1.0, green: 158.0/255.0, blue: 0, alpha: 1.0)
        segmentOutlet.tintColor = orange
        segmentOutlet.selectedSegmentIndex = 1
        molnLabel.text = "av"
        vindLabel.text = "av"
        tempLabel.text = "av"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
