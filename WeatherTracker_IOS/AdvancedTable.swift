//
//  TableViewController.swift
//  swipeTest
//
//  Created by Gustav on 2016-04-18.
//  Copyright © 2016 Anders. All rights reserved.
import UIKit
class AdvancedTable: UITableViewController {
    
    let list = ["sol","snö","temp",""]
    
    
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
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tv.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = list[indexPath.row]
        if(list[indexPath.row] != "temp" && list[indexPath.row] != ""){
            let customSwitch=UISwitch(frame:CGRectMake(260, 10, 0, 0))
            customSwitch.setOn(false, animated: true)
            cell.addSubview(customSwitch)
        }
        if(list[indexPath.row] == "temp"){
            let sampleTextField = UITextField(frame: CGRectMake(235, 10, 75, 30))
            sampleTextField.placeholder = "temp"
            sampleTextField.keyboardType = UIKeyboardType.NumberPad
            sampleTextField.font = UIFont.systemFontOfSize(15)
            sampleTextField.borderStyle = UITextBorderStyle.RoundedRect
            sampleTextField.autocorrectionType = UITextAutocorrectionType.No
            sampleTextField.keyboardType = UIKeyboardType.Default
            sampleTextField.returnKeyType = UIReturnKeyType.Done
            sampleTextField.clearButtonMode = UITextFieldViewMode.WhileEditing;
            sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
            cell.addSubview(sampleTextField)
        }
        if(list[indexPath.row] == ""){
            let button = UIButton(frame: CGRectMake(260, 10, 0, 0))
            button.buttonType.rawValue
            button.setTitle("sök", forState: .Normal)
            button.setTitleColor(UIColor.blueColor(), forState: .Normal)
            button.frame = CGRectMake(260, 10, 75, 30)
            button.backgroundColor = UIColor.greenColor()
            button.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.addSubview(button)
        }
        
        
        
        
        // Configure the cell...
        return cell
    }
    func pressed(){
        print("test")
    }
    
}