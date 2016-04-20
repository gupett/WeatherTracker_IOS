//
//  DeleteAnnotationView.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 19/04/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import MapKit

class DeleteAnnotationView: MKAnnotationView{
    
    var deleteAnnotation: DeleteAnnotation?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(annotation: MKAnnotation?, reuseIdentifier: String?, deleteAnnotation: DeleteAnnotation) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.deleteAnnotation = deleteAnnotation
    }
    
}
