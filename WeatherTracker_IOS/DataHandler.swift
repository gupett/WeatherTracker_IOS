//
//  DataHandler.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 06/05/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol WeatherResultDelegate {
    func returnResults(resultDic: [String: [WeatherContainer]])
}

class ParseJson: WeatherDataDelegate{
    
    var jsonObjectLista: [[String: AnyObject]] = []
    
    var i = 0;
    
    let dateList: [String]
    
    let params: [String: Double]
    
    //ska håll resultatet av det som skickas dtillbaka
    var resultDic = [String: [WeatherContainer]]()
    //List which contains the three best of all days
    var resultThreeBest: [WeatherContainer] = []
    
    //set the delegate for the weather result
    let delegate: WeatherResultDelegate
    
    //ska försvinna i när algoritm implementeras
    /*init(numOfLocations: Int){
     self.i = numOfLocations
     }*/
    
    // params är en dictionary med de önskade parametern som key och önskat värde för parametern som value
    init(_numOfLocations: Int, _dateList: [String], _params: [String: Double], _delegate: WeatherResultDelegate){
        self.i = _numOfLocations
        self.dateList = _dateList
        self.params = _params
        self.delegate = _delegate
    }
    
    let compareQueue = dispatch_queue_create("compareWeather", DISPATCH_QUEUE_SERIAL)
    
    func getWeather(long: Double, lat: Double){
        // en asynkron uppgift skickas till GCD som sen bestämmer hur den bäst kan köras
        // den ska köras i den globala kön on prioriteten är normal,
        // I closuren sägs vad som ska göras
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),{
            sleep(3)
            Data_Request().getWeather(long, lat: lat, delegate: self)
            
        })
    }
    
    func getWeatherForList(listOfCoordinates: [[CLLocationCoordinate2D]]){
        // en asynkron uppgift skickas till GCD som sen bestämmer hur den bäst kan köras
        // den ska köras i den globala kön on prioriteten är normal,
        // I closuren sägs vad som ska göras
        
        //Get the number of requests that will be performed
        let dataRequest = Data_Request()
        
        for coordinates in listOfCoordinates{
            for coordinate in coordinates{
                let long: Double = round(coordinate.longitude * 1000000)/1000000
                let lat: Double = round(coordinate.latitude * 1000000)/1000000
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),{
                    dataRequest.getWeather(long, lat: lat, delegate: self)
                })
                //Give the system some room to breathe between all the requests
            }
            sleep(1)
        }
    }
    
    func jsonWeatherObject(data: NSData) {
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            
            if let jsonObject: [String: AnyObject] = object as? [String: AnyObject]{
                addJsonObjectToList(jsonObject)
            }
        } catch  {
            // TODO: handle
        }
    }
    
    //lägger till JSON Object som är klara för att jämföras i kön
    func addJsonObjectToList(jsonObject: [String: AnyObject]){
        dispatch_async(compareQueue, {
            if (self.i == 1){
                
                // delegate.return resultDic
                print("Nu ska jag skicka tillbaka listan till kartan som kan visa upp den")
            }
            // kalla compare funktionen
            //print("kör synkront")
            self.findBestLocations(jsonObject)
        })
    }
    
    // Här ska listor skapas och jämföras med varandra
    func findBestLocations(jsonObject: [String: AnyObject]){
        /*if let temp = jsonObject["approvedTime"] as? String{
         print(temp)
         }*/

        
        // För alla intressanta dagar så skapas nu en lista som håller de tre mest intresanta punkterna. Listan identifieras med hjälp av datumet som nyckel
        for date in dateList{
            //den delen av json objektet som håller väderparametrarna för önskad dag vi klockan 12:00
            
            //hämta parametrarna för dagen från SMHI json objektet
            guard let parameters = getParametersForDay(jsonObject, day: date) else{
                print("inga parametrar finns för dagen")
                return
            }
            
            //poäng för plats koordinat för dag date
            let score = ScoringSystem().calculatetotalScoreForJSONData(parameters, params: self.params)
            
            //se om det finns någon lista för dagen, annars skapa en och lägg till WeatherContainer objekt
            guard let bestListOfDate = self.resultDic[date] else{
                print("resultat lista tom för vald dag")
                let weatherContainer = [WeatherContainer(date: date, _score: score, _jsonObject: jsonObject)]
                self.resultDic[date] = weatherContainer
                self.i = i-1
                return
            }
            
            //Om resultatlistan för deagen är minder an tre lägg till Weather container element tills den blir tre element lång
            
            let j = self.resultDic[date]!.count - 1
            
            if (self.resultDic[date]!.count < 3 || score > self.resultDic[date]![j].score){
                
                let weatherContainer = WeatherContainer(date: date, _score: score, _jsonObject: jsonObject)
                
                addToThreeBest(weatherContainer)
                
                self.resultDic[date]!.append(weatherContainer)
                
                resultDic[date]! = sortList(resultDic[date]!)
                
                print("\(bestListOfDate.count) resultatlistan för dagen är nu 111")
            }else{
                print("ingenting läggs ändras för denna plats oidsajgkjgåopjglöägadjgkljfdljfähjalä")
            }
        }
        self.i = i-1
        
        //måste läggas sist i functionen
        if (self.i == 1){
            
            resultDic["best"] = resultThreeBest
            
            //call on main thread
            dispatch_async(dispatch_get_main_queue(),{
                self.delegate.returnResults(self.resultDic)
            })
            
            for (key, list) in resultDic{
                for weather in list{
                    print("\(weather.score) är scoren för det bäta vädret för \(key)")
                }
            }
            
        }

    }
    
    func sortList(tempResultList: [WeatherContainer]) -> [WeatherContainer]{
        
        var sortedList = tempResultList
        var j = sortedList.count - 2
        
        while(j >= 0 && sortedList[j+1].score > sortedList[j].score){
            print("lägger in mer lämpliga förslag")
            let temp = sortedList[j+1]
            sortedList[j+1] = sortedList[j]
            sortedList[j] = temp
            j = j - 1
        }
        
        if (sortedList.count > 3){
            sortedList.removeLast()
        }
        return sortedList
    }
    
    func addToThreeBest(location: WeatherContainer){
        var j = resultThreeBest.count - 1
        resultThreeBest.append(location)
        
        while (j >= 0 && location.score > self.resultThreeBest[j].score){
            let temp = resultThreeBest[j+1]
            resultThreeBest[j+1] = resultThreeBest[j]
            resultThreeBest[j] = temp
            j = j-1
        }
        
        if (resultThreeBest.count > 3){
            resultThreeBest.removeLast()
        }
    }
    
    
    //plocka ut parametrarna från json objektet för day vid 12:00
    func getParametersForDay(jsonObject: [String: AnyObject], day: String) -> ([[String: AnyObject]]?){
        
        // 2015-10-12T05:00:00Z the same formate as in the SMHI timeobject
        let dayTime = "\(day)T12:00:00Z"
        
        guard let timeSeries = jsonObject["timeSeries"] as? [[String: AnyObject]] else{
            print ("No timeSeries")
            return nil
        }
        
        var i = 0;
        for _ in timeSeries{
            
            guard let dayList = timeSeries[i] as? [String: AnyObject] else{
                print("no day for index: \(i)")
                return nil
            }
            
            guard let validTime = dayList["validTime"] as? String else{
                print("problem converting to NSDate")
                return nil
            }
            
            if validTime == dayTime {
                //if valid time = day, return valu for key parameters
                guard let parameters = dayList["parameters"] as? [[String: AnyObject]] else{
                    print("no parameters for index")
                    return nil
                }
                
                return parameters
            }
            i += 1
        }
        return nil
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //Ej fungerande funktion. Den ska hitta prognoserna innom ett tidsspann.
    func getForcastsClosestToTime(day: String, startTime: String, endTime: String, forcasts: [[String: AnyObject]]){
        
        var indexForStartDate = 0
        var timeBetweenForStart = 1000000 //garanterat fler sekunder än 10 dagar
        var indexForEndDate = 0
        var timeBetweenForEnd = 1000000 //garanterat fler sekunder än 10 dagar
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        for index in forcasts{
            
            if let validTime = index["validTime"] as? String{
                
                
                
                
            }
            
        }
        
    }
}