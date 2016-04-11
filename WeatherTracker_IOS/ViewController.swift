//
//  ViewController.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 11/04/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func getWeather(sender: AnyObject) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*func getWeather() -> Void {
        let stringURL = "http://opendata-download-metfcst.smhi.se/api/category/pmp1.5g/version/1/geopoint/lat/58.59/lon/16.18/data.json"
        
        guard let url = NSURL(string: stringURL) else{
            print("Error creating URL")
            return
        }
        
        let urlRequest = NSMutableURLRequest(URL: url)
        urlRequest.HTTPMethod = "GET"
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        //let task = session.dataTaskWithRequest(urlRequest, completionHandler: <#T##(NSData?, NSURLResponse?, NSError?) -> Void#>)
        
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, erreor) in
            
            guard let responseData = data else {
                print ("No data")
                return
            }
            
            let jasonResponse: NSDictionary
            
            do{
                jasonResponse = try NSJSONSerialization.JSONObjectWithData(responseData, options: []) as! NSDictionary
            }catch{
                print ("error converting to json")
                return
            }
            
            
            
            
            print (responseData)
            
        })

    }*/

}

