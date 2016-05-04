//
//  DeleteAnnotation.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 19/04/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import MapKit

//Nytt från algoritm att DeleteAnnotation tar in polygon koordinater för att kunna ha punkter att dra linjer mellan för att kunna
//se om koordinat befinnersig innanför polygon
class DeleteAnnotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    
    let polygon: MKPolygon
    
    let polygonCoordinates: [CLLocationCoordinate2D]
    
    init (_coordinates: CLLocationCoordinate2D, with_polygon _polygon: MKPolygon, and_PolygonCoordinates coordinates: [CLLocationCoordinate2D]){
        self.coordinate = _coordinates
        self.polygon = _polygon
        self.polygonCoordinates = coordinates
    }
    
}