//
//  ResultAnnotation.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 07/05/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import Foundation
import MapKit

class ResultAnnotation: MKPointAnnotation {
    
    let weatherContainer: WeatherContainer
    
    init(_coordinate: CLLocationCoordinate2D, _weatherContainer: WeatherContainer) {
        self.weatherContainer = _weatherContainer
        super.init()
        super.coordinate = _coordinate
    }
    
    func calloutTitle(_title: String){
        super.title = _title
    }
    
    func calloutSubtitle(_subTitle: String){
        super.subtitle = _subTitle
    }
}