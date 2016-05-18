//
//  ScoringSystem.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 06/05/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import Foundation

class ScoringSystem {
    
    //Send the "timeSeries" object the score should be calculated for,
    //"timeSeries" is a key word inside the SMHI JSON object which holds the weather data for different days/ times of day
    func calculatetotalScoreForJSONData(jsonDayObject: [[String: AnyObject]], params: [String: Double]) -> (Double, [String: Double], Double){
        
        var totalScore: Double = 0
        
        var paramDictionaryForDay = [String: Double]()
        
        for (key, valueForKey) in params {
            let delta = getDelta(key)
            if let value = getValueForKeyOfJSON(jsonDayObject, key: key){
                totalScore += (1 - (abs(valueForKey - value) / delta)) * 1000
                paramDictionaryForDay[key] = value
            }
        }
        
        if let weatherSymbol: Double = getValueForKeyOfJSON(jsonDayObject, key: "Wsymb")!{
            print("Weather symbol \(weatherSymbol)")
            return (totalScore, paramDictionaryForDay, weatherSymbol)
        }
        
        return (totalScore, paramDictionaryForDay, -1)
    }
    
    //Få ut värdet för keyen som önskas ur SMHIJson för dagen
    private func getValueForKeyOfJSON(jsonDayObject: [[String: AnyObject]], key: String) -> Double?{
        for param in jsonDayObject{
            guard let keyParam = param["name"] as? String else{
                break
            }
            
            if (keyParam == key){
                guard let keyValue = param["values"] as? [Double] else{
                    return nil
                }
                return keyValue[0]
            }
        }
        return nil
    }
    
    private func getDelta(param: String) -> (Double){
        
        switch param {
        // temperature
        case "t":
            return 40
        //wind speed
        case "ws":
            return 40
        // wind direction
        case "wd":
            return 360
        //cloud cover?
        case "tcc_mean":
            return 1
        default:
            print("Nu är vi ute på djupt vatten")
        }
        return 360
    }
}