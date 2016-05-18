//
//  WeatherContainer.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 06/05/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import Foundation
import MapKit

class WeatherContainer{
    
    let weatherSymbol: Double
    
    var paramDictionary = [String: Double]()
    
    let score: Double
    
    let jsonObject: [String: AnyObject]
    
    let coordinate: CLLocationCoordinate2D?
    
    let date: String
    
    init(_date: String, _score: Double, _jsonObject: [String: AnyObject],
         _paramDicForDay: [String: Double], _weatherSymbol: Double){
        self.date = _date
        paramDictionary = _paramDicForDay
        self.score = _score
        self.jsonObject = _jsonObject
        self.weatherSymbol = _weatherSymbol
        
        //Potentially wrong in the parsing
        //asigning the coordinate of the data to the object
        guard let geometry = jsonObject["geometry"] as? [String: AnyObject] else{
            print("ingen key geometry")
            coordinate = nil
            return
        }
        
        guard let coordinatesArray = geometry["coordinates"] as? [[Double]] else{
            print("inga coordinates")
            coordinate = nil
            return
        }
        
        guard let coordinates = coordinatesArray[0] as? [Double] else{
            print("Ingen double array")
            coordinate = nil
            return
        }
        
        if let long = coordinates[0] as? Double, lat = coordinates[1] as? Double{
            let clLong = CLLocationDegrees(long)
            let clLat = CLLocationDegrees(lat)
            coordinate = CLLocationCoordinate2D(latitude: clLat, longitude: clLong)
            
            
            
            
            return
        }
        coordinate = nil
    }
}