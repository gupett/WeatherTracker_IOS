//
//  TableViewController.swift
//  swipeTest
//
//  Created by Gustav on 2016-04-18.
//  Copyright © 2016 Anders. All rights reserved.
import UIKit
class AdvancedTable: UITableViewController {
    
    let list = ["date","vind","vindriktning","temp","molnighet","nederbörd",""]
    
    var refsw1:UISwitch = UISwitch()
    var refsw2:UISwitch = UISwitch()
    var refTempText:UITextField = UITextField()
    var refButton:UIButton = UIButton()
    var refStartDateText:UITextField = UITextField()
    var refEndDateText:UITextField = UITextField()
    var datePickRef:UIDatePicker = UIDatePicker()
    var enddatePickRef:UIDatePicker = UIDatePicker()
    var overlayRef:UIView = UIView()
    var minDate:NSDate = NSDate()
    var maxDate:NSDate = NSDate()
    var vindLabelRef:UILabel = UILabel()
    var tempLabelRef:UILabel = UILabel()
    var molnLabelRef:UILabel = UILabel()
    var startGradRef:UITextField = UITextField()
    var endGradRef:UITextField = UITextField()
    
    @IBOutlet var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tv.allowsSelection = false
        
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let comp = NSDateComponents()
        comp.day = +10
        maxDate = calender!.dateByAddingComponents(comp, toDate: NSDate(), options: NSCalendarOptions(rawValue:0))!
        //self.tv.scrollEnabled = true
        self.tv.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tv.dataSource = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tv.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        if(list[indexPath.row] == "temp"){
            cell.textLabel?.text = list[indexPath.row]
            let tempSlider = UISlider(frame: CGRectMake(cell.frame.width/3, cell.frame.height/1.7, self.view.frame.width/3, 5))
            tempSlider.minimumValue = -7
            tempSlider.maximumValue = 7
            tempSlider.addTarget(self, action:#selector(self.tempSlider), forControlEvents:UIControlEvents.ValueChanged)
            
            let tempLable = UILabel(frame: CGRectMake(cell.frame.width/2, 0, 50, 12))
            tempLable.text = "0°C"
            tempLable.font = tempLable.font.fontWithSize(10)
            tempLabelRef = tempLable
            cell.addSubview(tempLable)
            cell.addSubview(tempSlider)
        }
        if(list[indexPath.row] == "molnighet"){
            cell.textLabel?.text = list[indexPath.row]
            let tempSlider = UISlider(frame: CGRectMake(cell.frame.width/3, cell.frame.height/1.7, self.view.frame.width/3, 5))
            tempSlider.minimumValue = 0
            tempSlider.maximumValue = 3
            tempSlider.addTarget(self, action:#selector(self.cloudSlider), forControlEvents:UIControlEvents.ValueChanged)
            let molnLable = UILabel(frame: CGRectMake(cell.frame.width/2, 0, 50, 12))
            molnLable.text = "ingen"
            molnLable.font = molnLable.font.fontWithSize(10)
            molnLabelRef = molnLable
            cell.addSubview(molnLable)
            cell.addSubview(tempSlider)
            
        }
        if(list[indexPath.row] == "vind"){
            cell.textLabel?.text = list[indexPath.row]
            let tempSlider = UISlider(frame: CGRectMake(cell.frame.width/3, cell.frame.height/1.7, self.view.frame.width/3, 5))
            tempSlider.minimumValue = 0
            tempSlider.maximumValue = 5
            tempSlider.addTarget(self, action:#selector(self.windSlider), forControlEvents:UIControlEvents.ValueChanged)
            let vindLable = UILabel(frame: CGRectMake(cell.frame.width/2, 0, 50, 12))
            vindLable.text = "0 m/s"
            vindLable.font = vindLable.font.fontWithSize(10)
            vindLabelRef = vindLable
            cell.addSubview(vindLable)
            //objectList.append()
            cell.addSubview(tempSlider)
            
        }
        if(list[indexPath.row] == "vindriktning"){
            let startGradTextField = UITextField(frame: CGRectMake((self.view.frame.width/20), 10, 100, 30))
            startGradTextField.placeholder = "start °"
            startGradTextField.font = UIFont.systemFontOfSize(15)
            startGradTextField.borderStyle = UITextBorderStyle.RoundedRect
            startGradTextField.autocorrectionType = UITextAutocorrectionType.No
            startGradTextField.returnKeyType = UIReturnKeyType.Done
            startGradTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
            let keyboardToolbar = UIToolbar()
            keyboardToolbar.sizeToFit()
            let flexBarButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace,
                                                target: nil, action: nil)
            let doneBarButton = UIBarButtonItem(barButtonSystemItem: .Done,
                                                target: view, action: #selector(UIView.endEditing(_:)))
            keyboardToolbar.items = [flexBarButton, doneBarButton]
            startGradTextField.inputAccessoryView = keyboardToolbar
            startGradTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
            cell.addSubview(startGradTextField)
            startGradRef = startGradTextField
            let endGradTextField = UITextField(frame: CGRectMake((self.view.frame.width/2)-100, 10, 100, 30))
            endGradTextField.placeholder = "slut °"
            endGradTextField.inputAccessoryView = keyboardToolbar
            endGradTextField.font = UIFont.systemFontOfSize(15)
            endGradTextField.borderStyle = UITextBorderStyle.RoundedRect
            endGradTextField.autocorrectionType = UITextAutocorrectionType.No
            endGradTextField.returnKeyType = UIReturnKeyType.Done
            endGradTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
            endGradTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
            
            cell.addSubview(endGradTextField)
            endGradRef = endGradTextField
            
        }
        if(list[indexPath.row] == "nederbörd"){
            cell.textLabel?.text = list[indexPath.row]
            let sw = UISwitch(frame: CGRectMake(260, 10, 0, 0))
            cell.addSubview(sw)
        }
        
        if(list[indexPath.row] == "date"){
            let startDateTextField = UITextField(frame: CGRectMake((self.view.frame.width/20), 10, 100, 30))
            startDateTextField.placeholder = "start date"
            startDateTextField.font = UIFont.systemFontOfSize(15)
            startDateTextField.borderStyle = UITextBorderStyle.RoundedRect
            startDateTextField.autocorrectionType = UITextAutocorrectionType.No
            startDateTextField.returnKeyType = UIReturnKeyType.Done
            startDateTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
            startDateTextField.addTarget(self, action:#selector(self.startDate), forControlEvents:UIControlEvents.EditingDidBegin)
            
            cell.addSubview(startDateTextField)
            refStartDateText = startDateTextField
            let endDateTextField = UITextField(frame: CGRectMake((self.view.frame.width/2)-100, 10, 100, 30))
            endDateTextField.placeholder = "end date"
            
            endDateTextField.font = UIFont.systemFontOfSize(15)
            endDateTextField.borderStyle = UITextBorderStyle.RoundedRect
            endDateTextField.autocorrectionType = UITextAutocorrectionType.No
            endDateTextField.returnKeyType = UIReturnKeyType.Done
            endDateTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
            endDateTextField.addTarget(self, action:#selector(self.endDate), forControlEvents:UIControlEvents.EditingDidBegin)
            
            cell.addSubview(endDateTextField)
            refEndDateText = endDateTextField
            
        }
        if(list[indexPath.row] == ""){
            
            let button = UIButton()
            button.frame = CGRectMake(self.view.frame.width/4-30, 0, 75, 30)
            button.buttonType.rawValue
            button.setTitle("sök", forState: .Normal)
            button.setTitleColor(UIColor.blueColor(), forState: .Normal)
            
            button.addTarget(self, action:#selector(self.showMap), forControlEvents:UIControlEvents.TouchUpInside)
            button.layer.cornerRadius = 5.0
            button.layer.borderColor = UIColor.blackColor().CGColor
            button.layer.borderWidth = 1

            button.backgroundColor = UIColor.whiteColor()
            button.tintColor = UIColor.redColor()
            cell.addSubview(button)
        }
        
        // Configure the cell...
        return cell
    }
    func startDate(sender: UITextField){
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
        
        /*let toolbar = UIToolbar()
         toolbar.barStyle = UIBarStyle.Default
         let done = UIBarButtonItem(title: "Välj", style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.date))
         toolbar.setItems([done], animated: false)
         sender.inputAccessoryView = toolbar
         */
        
        let avbrytBtn = UIButton(frame: CGRectMake(0, 0, 100, 50))
        avbrytBtn.setTitle("avbryt", forState: .Normal)
        btnView.addSubview(avbrytBtn)
        let valjBtn = UIButton(frame: CGRectMake((self.view.frame.size.width/2)-(50), 0, 100, 50))
        valjBtn.setTitle("välj", forState: .Normal)
        btnView.addSubview(valjBtn)
        sender.inputView = btnView
        
        valjBtn.addTarget(self, action:#selector(self.startChoose), forControlEvents: UIControlEvents.TouchUpInside)
        avbrytBtn.addTarget(self, action:#selector(self.abort), forControlEvents: UIControlEvents.TouchUpInside)
        
        
    }
    func endDate(sender: UITextField){
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
        let valjBtn = UIButton(frame: CGRectMake((self.view.frame.size.width/2)-(50), 0, 100, 50))
        valjBtn.setTitle("välj", forState: .Normal)
        btnView.addSubview(valjBtn)
        
        sender.inputView = btnView
        
        valjBtn.addTarget(self, action:#selector(self.endChoose), forControlEvents: UIControlEvents.TouchUpInside)
        avbrytBtn.addTarget(self, action:#selector(self.abort), forControlEvents: UIControlEvents.TouchUpInside)
        
        
    }
    func tempSlider(sender:UISlider){
        sender.setValue(Float(lroundf(sender.value)), animated: true)
        let value = sender.value
        switch value {
        case -7:
            tempLabelRef.text = "min"
        case 7:
            tempLabelRef.text = "max"

        default:
            tempLabelRef.text = String(value*5)+"°C"
        }
    }
    func cloudSlider(sender:UISlider){
        sender.setValue(Float(lroundf(sender.value)), animated: true)
        switch sender.value {
        case 0:
            molnLabelRef.text = "ingen"
        case 1:
            molnLabelRef.text = "lite"
        case 2:
            molnLabelRef.text = "mellan"
        case 3:
            molnLabelRef.text = "mycket"
        default:
            molnLabelRef.text = nil
        }
    }
    func windSlider(sender:UISlider){
        sender.setValue(Float(lroundf(sender.value)), animated: true)
        vindLabelRef.text = String(sender.value*5)+"m/s"
        
    }
    func startChoose(sender: UIButton){
        let DateString = NSDateFormatter()
        DateString.dateFormat = "dd-MM-yyyy"
        let DatePicked = DateString.stringFromDate(datePickRef.date)
        let ref = refStartDateText
        ref.text = DatePicked
        minDate = datePickRef.date
        self.navigationController?.navigationBarHidden = false
        
        overlayRef.removeFromSuperview()
        ref.resignFirstResponder()
    }
    func endChoose(sender: UIButton){
        let DateString = NSDateFormatter()
        DateString.dateFormat = "dd-MM-yyyy"
        let DatePicked = DateString.stringFromDate(datePickRef.date)
        let ref = refEndDateText
        self.navigationController?.navigationBarHidden = false
        
        ref.text = DatePicked
        maxDate = datePickRef.date
        overlayRef.removeFromSuperview()
        ref.resignFirstResponder()
    }
    
    func abort(sender: UIButton){
        self.navigationController?.navigationBarHidden = false
        
        let refEnd = refEndDateText
        let refStart = refStartDateText
        overlayRef.removeFromSuperview()
        refEnd.resignFirstResponder()
        refStart.resignFirstResponder()
    }
    func showMap(sender: UIButton){
        print("knap")
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc : UIViewController! = storyboard.instantiateViewControllerWithIdentifier("map")
        presentViewController(vc, animated: true, completion: nil)
    }
    
    
}