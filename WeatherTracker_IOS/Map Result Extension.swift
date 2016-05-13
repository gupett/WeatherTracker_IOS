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
            
            
            
            var subtitle = ""
            for (key, value) in wc.paramDictionary{
                let val : String = String(value)
                subtitle.appendContentsOf(key)
                subtitle.appendContentsOf(":")
                subtitle.appendContentsOf(val)
                subtitle.appendContentsOf(" ")
                
                print(subtitle)
                
                
                
            }
            resultAnnotation.subtitle = subtitle
            map.addAnnotation(resultAnnotation)
            resultAnnotationsCurrentlyOnMap.append(resultAnnotation)
        }
    }
    
}
