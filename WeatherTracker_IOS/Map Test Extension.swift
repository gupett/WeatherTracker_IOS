//
//  Map Test Extension.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 08/05/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import Foundation
import MapKit

extension MapViewControlerViewController{
    
    // MARK: - test to show annotations on map
    /*func showAnnotationsInsidePolygon(polygonCoordinates: [CLLocationCoordinate2D]){
        
        //Kod som tidigare fungerade för att hitta koordinater
        /*print("show annotations inside")
         //Hämta mittpunkterna på de små kvadraterna
         let coordinates = ContainsCoordinate().coordinatesForSubSquaresOfPolygon(polygonCoordinates, map: self.map, view: self.view)
         //se om mittpunkterna ligger innanför polygonen*/
        
        let coordinates = ContainsCoordinate().getCoordinatesIsidePolygon(polygonCoordinates)
        
        for coordinate in coordinates {
            print(String(coordinate), " kdhfhjdskölgfdg")
            if(ContainsCoordinate().insidePolygonCalculatedWithCoordinates(polygonCoordinates, coordinate: coordinate)){
                print("kör i if")
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = String(coordinate)
                self.map.addAnnotation(annotation)
            }
        }
        
        let cornerCoordinates = ContainsCoordinate().maxCoordiantesOfPolygon(polygonCoordinates)
        
        let c1 = CornerAnnotation(_coordinate: cornerCoordinates.0)
        let c2 = CornerAnnotation(_coordinate: cornerCoordinates.1)
        let c3 = CornerAnnotation(_coordinate: cornerCoordinates.2)
        let c4 = CornerAnnotation(_coordinate: cornerCoordinates.3)
        
        map.addAnnotation(c1)
        map.addAnnotation(c2)
        map.addAnnotation(c3)
        map.addAnnotation(c4)
        
    }*/
    
}
