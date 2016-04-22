//
//  TableViewController.swift
//  swipeTest
//
//  Created by Gustav on 2016-04-18.
//  Copyright © 2016 Anders. All rights reserved.
import UIKit
class SimpleTable: UITableViewController {
    
    let list = ["sol","snö","temp","","startdate","enddate"]
    var refsw1:UISwitch = UISwitch()
    var refsw2:UISwitch = UISwitch()
    var refTempText:UITextField = UITextField()
    var refButton:UIButton = UIButton()
    var refDateText:UITextField = UITextField()
    var datePickRef:UIDatePicker = UIDatePicker()
    var enddatePickRef:UIDatePicker = UIDatePicker()
    var overlayRef:UIView = UIView()
    var minDate:NSDate = NSDate()
    var maxDate:NSDate = NSDate()
    @IBOutlet var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let comp = NSDateComponents()
        comp.day = +10
        maxDate = calender!.dateByAddingComponents(comp, toDate: NSDate(), options: NSCalendarOptions(rawValue:0))!
        self.tv.scrollEnabled = false
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
    var objectList = [Any]()
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tv.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = list[indexPath.row]
        if(list[indexPath.row] == "sol" || list[indexPath.row] == "snö"){
            let Switch=UISwitch(frame:CGRectMake(260, 10, 0, 0))
            Switch.setOn(false, animated: true)
            objectList.append(Switch)
            cell.addSubview(Switch)
        }
        if(list[indexPath.row] == "temp"){
            let tempTextField = UITextField(frame: CGRectMake(235, 10, 75, 30))
            tempTextField.placeholder = "temp"
            tempTextField.keyboardType = UIKeyboardType.NumberPad
            tempTextField.font = UIFont.systemFontOfSize(15)
            tempTextField.borderStyle = UITextBorderStyle.RoundedRect
            tempTextField.autocorrectionType = UITextAutocorrectionType.No
            tempTextField.keyboardType = UIKeyboardType.Default
            tempTextField.returnKeyType = UIReturnKeyType.Done
            tempTextField.clearButtonMode = UITextFieldViewMode.WhileEditing;
            tempTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
            objectList.append(tempTextField)
            cell.addSubview(tempTextField)
        }
        if(list[indexPath.row] == ""){
            let button = UIButton(frame: CGRectMake(260, 10, 0, 0))
            button.buttonType.rawValue
            button.setTitle("sök", forState: .Normal)
            button.setTitleColor(UIColor.blueColor(), forState: .Normal)
            button.frame = CGRectMake(260, 10, 75, 30)
            button.backgroundColor = UIColor.greenColor()
            button.addTarget(self, action:#selector(self.pressed), forControlEvents: .TouchUpInside)
            objectList.append(button)
            cell.addSubview(button)
        }
        if(list[indexPath.row] == "startdate"){
            let dateTextField = UITextField(frame: CGRectMake((self.view.frame.width/2)-100, 10, 100, 30))
            dateTextField.placeholder = "start date"
            
            dateTextField.font = UIFont.systemFontOfSize(15)
            dateTextField.borderStyle = UITextBorderStyle.RoundedRect
            dateTextField.autocorrectionType = UITextAutocorrectionType.No
            dateTextField.returnKeyType = UIReturnKeyType.Done
            dateTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
            dateTextField.addTarget(self, action:#selector(self.startDate), forControlEvents:UIControlEvents.EditingDidBegin)
            
            objectList.append(dateTextField)
            cell.addSubview(dateTextField)
            

            
        }
        
        if(list[indexPath.row] == "enddate"){
            let dateTextField = UITextField(frame: CGRectMake((self.view.frame.width/2)-100, 10, 100, 30))
            dateTextField.placeholder = "end date"
            
            dateTextField.font = UIFont.systemFontOfSize(15)
            dateTextField.borderStyle = UITextBorderStyle.RoundedRect
            dateTextField.autocorrectionType = UITextAutocorrectionType.No
            dateTextField.returnKeyType = UIReturnKeyType.Done
            dateTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
            dateTextField.addTarget(self, action:#selector(self.endDate), forControlEvents:UIControlEvents.EditingDidBegin)
            
            objectList.append(dateTextField)
            cell.addSubview(dateTextField)
            
            
            
        }
        
        
        
        
        // Configure the cell...
        return cell
    }
    func startDate(sender: UITextField){
        let btnView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        let overlayVeiw = UIView(frame: CGRectMake(0, self.view.frame.height, self.view.frame.width, self.view.frame.height))
        overlayVeiw.userInteractionEnabled = false
        overlayVeiw.backgroundColor = UIColor.greenColor()
        self.view.backgroundColor = UIColor.clearColor()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let overlayBlur = UIVisualEffectView(effect: blurEffect)
        overlayBlur.frame = self.view.bounds
        overlayBlur.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        overlayBlur.userInteractionEnabled = false
        self.navigationController?.navigationBarHidden = true
        overlayRef = overlayBlur
        self.view.addSubview(overlayBlur)
        
        
        tv.addSubview(overlayVeiw)
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
        
        let overlayVeiw = UIView(frame: CGRectMake(0, self.view.frame.height, self.view.frame.width, self.view.frame.height))
        overlayVeiw.userInteractionEnabled = false
        overlayVeiw.backgroundColor = UIColor.greenColor()
        self.view.backgroundColor = UIColor.clearColor()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let overlayBlur = UIVisualEffectView(effect: blurEffect)
        overlayBlur.frame = self.view.bounds
        overlayBlur.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        overlayBlur.userInteractionEnabled = false
        self.navigationController?.navigationBarHidden = true
        overlayRef = overlayBlur
        self.view.addSubview(overlayBlur)
        
        
        tv.addSubview(overlayVeiw)
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
    func startChoose(sender: UIButton){
        let DateString = NSDateFormatter()
        DateString.dateFormat = "dd-MM-yyyy"
        let DatePicked = DateString.stringFromDate(datePickRef.date)
        let ref = objectList[4] as! UITextField
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
        let ref = objectList[5] as! UITextField
        self.navigationController?.navigationBarHidden = false

        ref.text = DatePicked
        maxDate = datePickRef.date
        overlayRef.removeFromSuperview()
        ref.resignFirstResponder()
    }
    
    func abort(sender: UIButton){
        self.navigationController?.navigationBarHidden = false

        let refEnd = objectList[5] as! UITextField
        let refStart = objectList[4] as! UITextField
        overlayRef.removeFromSuperview()
        refEnd.resignFirstResponder()
        refStart.resignFirstResponder()
    }
    func pressed(){
        let ref0 = objectList[0] as! UISwitch
        let ref1 = objectList[1] as! UISwitch
        print(ref0.on)
        print(ref1.on)
    }
    
}