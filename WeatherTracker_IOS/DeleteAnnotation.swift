//
//  DeleteAnnotation.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 19/04/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import MapKit

class DeleteAnnotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    
    let polygon: MKPolygon
    
    init (_coordinates: CLLocationCoordinate2D, with_polygon _polygon: MKPolygon){
        self.coordinate = _coordinates
        self.polygon = _polygon
    }
    
}