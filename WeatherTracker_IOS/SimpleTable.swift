//
//  TableViewController.swift
//  swipeTest
//
//  Created by Gustav on 2016-04-18.
//  Copyright © 2016 Anders. All rights reserved.
import UIKit
class SimpleTable: UITableViewController {
    
    let list = ["sol","snö","temp","","startdate"]
    var refsw1:UISwitch = UISwitch()
    var refsw2:UISwitch = UISwitch()
    var refTempText:UITextField = UITextField()
    var refButton:UIButton = UIButton()
    var refDateText:UITextField = UITextField()
    var datePickRef:UIDatePicker = UIDatePicker()
   
    @IBOutlet var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if(list[indexPath.row] != "temp" && list[indexPath.row] != "" && list[indexPath.row] != "startdate"){
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
            let dateTextField = UITextField(frame: CGRectMake(235, 10, 75, 30))
            dateTextField.placeholder = "start date"
            
            dateTextField.font = UIFont.systemFontOfSize(15)
            dateTextField.borderStyle = UITextBorderStyle.RoundedRect
            dateTextField.autocorrectionType = UITextAutocorrectionType.No
            
            dateTextField.returnKeyType = UIReturnKeyType.Done
            dateTextField.clearButtonMode = UITextFieldViewMode.WhileEditing;
            dateTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
            dateTextField.addTarget(self, action:#selector(self.startDate), forControlEvents:UIControlEvents.EditingDidBegin)
            
            objectList.append(dateTextField)
            cell.addSubview(dateTextField)
            

            
        }
        
        
        
        
        // Configure the cell...
        return cell
    }
    func startDate(sender: UITextField){
        let btnView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
       
        
        
        let datePicker : UIDatePicker = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.minimumDate = NSDate()
        datePickRef = datePicker
        btnView.addSubview(datePicker)
        let avbrytBtn = UIButton(frame: CGRectMake(0, 0, 100, 50))
        avbrytBtn.setTitle("avbryt", forState: .Normal)
        btnView.addSubview(avbrytBtn)
        let valjBtn = UIButton(frame: CGRectMake((self.view.frame.size.width/2)-(50), 0, 100, 50))
        valjBtn.setTitle("välj", forState: .Normal)
        btnView.addSubview(valjBtn)
        sender.inputView = btnView
        datePicker.addTarget(self, action:#selector(self.date), forControlEvents: UIControlEvents.ValueChanged)
        
        
        
    }
    func date(sender: UIDatePicker){
        let DateString = NSDateFormatter()
        DateString.dateFormat = "dd-MM-yyyy"
    }
    
    
    func pressed(){
        let ref0 = objectList[0] as! UISwitch
        let ref1 = objectList[1] as! UISwitch
        print(ref0.on)
        print(ref1.on)
    }
    
}