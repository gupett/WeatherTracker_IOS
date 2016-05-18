//
//  Map Result Extension.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 08/05/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import Foundation
import MapKit

extension MapViewControlerViewController{
    
    // MARK: - The WeatherResultDelegate function
    func returnResults(resultDic: [String : [WeatherContainer]]) {
        print("return result from data handler")
        self.loadingMonitor.stopAnimating()
        self.map.superview?.bringSubviewToFront(map)
        self.resultDictionary = resultDic
        
        //Add annotations for day one in mapView
        guard let bestAnnotations = resultDic["best"] else{
            print("Inga best values i listan")
            return
        }
        
        createResultAnnotations(bestAnnotations)
        
        
    }
    
    func createResultAnnotations(listOfWCs: [WeatherContainer]){
      
        for wc in listOfWCs{
            guard let coordinate = wc.coordinate else{
                print("no coordiante for the weatherContainer object")
                return
            }
            
            
            let resultAnnotation = ResultAnnotation(_coordinate: coordinate, _weatherContainer: wc)
            
            //configurera callouten
            let showcity = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            CLGeocoder().reverseGeocodeLocation(showcity){
                (MyPlace, MyError) -> Void in
                if(MyError != nil)
                {
                    
                    //handle error
                }
                if let MyPlace = MyPlace?.first
                {
                    resultAnnotation.title = MyPlace.locality
                    
                }
            }
            
            let date: String = wc.date
          
            let subtitle = "Datum: " + date
            
            print(date)
         
            resultAnnotation.subtitle = subtitle
            map.addAnnotation(resultAnnotation)
            resultAnnotationsCurrentlyOnMap.append(resultAnnotation)
        }
        DataContainer.sharedDataContainer.ResultAnnotations = resultAnnotationsCurrentlyOnMap
    }
    
    func imageForCallout(weatherSymbol: Double) -> UIImage?{
        switch weatherSymbol {
        case 1...2:
            let image = UIImage(named: "ic_sunny")
            return image
        case 3...4:
            let image = UIImage(named: "ic_mostly_cloudy")
            return image
        case 5...6:
            let image = UIImage(named: "ic_cloudy")
            return image
        case 7:
            let image = UIImage(named: "ic_haze")
            return image
        case 8:
            let image = UIImage(named: "ic_slight_rain")
            return image
        case 9:
            let image = UIImage(named: "ic_thunderstorms")
            return image
        case 10...11:
            let image = UIImage(named: "ic_snow")
            return image
        case 12:
            let image = UIImage(named: "ic_rain")
            return image
        case 13:
            let image = UIImage(named: "ic_thunderstorms")
            return image
        case 14...15:
            let image = UIImage(named: "ic_snow")
            return image
        default:
            return nil
        }
    }
}
