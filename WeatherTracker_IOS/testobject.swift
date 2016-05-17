//
//  testobject.swift
//  WeatherTracker_IOS
//
//  Created by Andreas on 2016-04-28.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit
class weather {
    var day: String,stad: String, temp: Int,rank: Int
    
    init(day: String,stad: String, temp: Int, rank: Int) {
        self.day = day
        self.stad = stad
        self.temp = temp
        self.rank = rank
    }
}
