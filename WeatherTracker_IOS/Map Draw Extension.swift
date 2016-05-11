//
//  Map Draw Extension.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 08/05/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import Foundation
import MapKit

extension MapViewControlerViewController{
    
    // MARK: - Implementing GPMapDraw functions
    
    func dismissDrawView() {
        map.superview?.bringSubviewToFront(map)
        showDrawView.superview?.bringSubviewToFront(showDrawView)
        searchButton.superview?.bringSubviewToFront(searchButton)
    }
    
    func convertLinesToOverlay(lines: [Line]) {
        print(lines.count, " coordinater i listan")
        var coordinates: [CLLocationCoordinate2D] = []
        for line: Line in lines {
            let coordinate: CLLocationCoordinate2D = map.convertPoint(line.start, toCoordinateFromView: map)
            coordinates.append(coordinate)
        }
        
        let coordinate : CLLocationCoordinate2D = map.convertPoint(lines[0].start, toCoordinateFromView: map)
        coordinates.append(coordinate)
        
        showOverlayOnMap(coordinates)
        print(lines.count, " coordinater i listan")
    }
    
    func presentAlertController(alretController: UIAlertController) {
        presentViewController(alretController, animated: true, completion: nil)
    }

    // MARK: - Show and create delete button
    //Nytt från algoritm att funktionen tar in lista med polygon koordinater
    //Create the delete button for a specific marked area
    func createCorrespondingDeleteButton(polygon: MKPolygon, startCoordinate: CLLocationCoordinate2D, polygonCoordinates: [CLLocationCoordinate2D]){
        //Nytt från algoritm att DeleteAnnotation tar in polygon koordinater för att kunna ha punkter att dra linjer mellan för att kunna
        //se om koordinat befinnersig innanför polygon
        let pin = DeleteAnnotation(_coordinates: startCoordinate, with_polygon: polygon, and_PolygonCoordinates: polygonCoordinates)
        map.addAnnotation(pin)
        //lägg till pins i overlayen
        //showAnnotationsInsidePolygon(polygonCoordinates)
        
        //List to holding reference to all deleteButtons
        buttonList.append(pin)
    }
    
}