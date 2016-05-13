//
//  Activity.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 21/04/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class Activity {
    
    let image: UIImage
    let name: String
    var param: [String: Double] = [String: Double]()
    
    
    init(_image: UIImage, _name: String, _param: [String : Double]){
        self.image = _image
        self.name = _name
        self.param = _param
    }
    
    
}
