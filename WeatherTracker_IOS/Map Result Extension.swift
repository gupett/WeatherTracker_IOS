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
            resultAnnotation.title = "Stad"
            var subtitle = ""
            for (key, value) in wc.paramDictionary{
                subtitle = "\(subtitle)\(key): \(value), "
               
            }
            resultAnnotation.subtitle = subtitle
            map.addAnnotation(resultAnnotation)
            resultAnnotationsCurrentlyOnMap.append(resultAnnotation)
        }
    }
    
}
