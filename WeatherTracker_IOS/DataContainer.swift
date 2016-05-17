//
//  DataContainer.swift
//  WeatherTracker_IOS
//
//  Created by Thim on 17/05/16.
//  With inspiration from Duncan Champney on 4/19/15.
//  Copyright (c) 2015 Duncan Champney. All rights reserved.
//  Copyright © 2016 Gustav. All rights reserved.
//

import Foundation
import UIKit

struct DefaultKeys
{
    static let Parameters : [String : Double] = [:]
    static let Dates : [String] = []
    static let ResultAnnotations : [ResultAnnotation] = []
    static let show : Bool = false
}

class DataContainer
{
    static let sharedDataContainer = DataContainer()
    
    //Definera vad som du vill dela inom applikationen
    var Parameters: [String : Double]?
    var Dates: [String]?
    var ResultAnnotations: [ResultAnnotation]?
    var show: Bool?
    
}

