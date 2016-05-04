//
//  CornerAnnotation.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 27/04/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class CornerAnnotation: NSObject, MKAnnotation{
    
    let coordinate: CLLocationCoordinate2D
    
    init(_coordinate: CLLocationCoordinate2D) {
        self.coordinate = _coordinate
    }
}