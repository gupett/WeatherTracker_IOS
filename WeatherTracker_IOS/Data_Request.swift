//
//  Data_Request.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 06/05/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import Foundation

protocol WeatherDataDelegate {
    func jsonWeatherObject(data: NSData)
}

class Data_Request {
    
    var delegate: WeatherDataDelegate? = nil
    
    func getWeather(long: Double, lat: Double ,delegate: WeatherDataDelegate){
        
        let stringURL = "http://opendata-download-metfcst.smhi.se/api/category/pmp2g/version/2/geotype/point/lon/\(long)/lat/\(lat)/data.json"
        
        guard let url = NSURL(string: stringURL) else{
            print("Not a valid url")
            return
        }
        
        self.delegate = delegate
        let request = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error)
            in
            
            if let httpResponse = response as? NSHTTPURLResponse{
                if httpResponse.statusCode != 200{
                    print("bad response \(response)")
                    return
                }
            }
            
            if let goodData = data{
                //print("skickar data till ParseJson")
                delegate.jsonWeatherObject(goodData)
            }
        })
        task.resume()
    }
}