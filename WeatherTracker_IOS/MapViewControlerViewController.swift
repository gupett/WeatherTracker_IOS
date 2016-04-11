//
//  MapViewControlerViewController.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 11/04/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewControlerViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //centerMapOnLocation(initialLocation)
        
        longPressGesture()
        
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        self.map.showsUserLocation = true
    }
    
    func longPressGesture() -> Void{
        
        let lpg = UILongPressGestureRecognizer(target: self, action: "longPressAction:")
        lpg.minimumPressDuration = 2
        
        map.addGestureRecognizer(lpg)
        
    }
    
    func longPressAction(longPress: UILongPressGestureRecognizer){
        
        //Get where the user has clicked and convert it to coordinates
        let myCGPoint = longPress.locationInView(map)
        let coordinates:CLLocationCoordinate2D = map.convertPoint(myCGPoint, toCoordinateFromView: map)
        
        //Create pin
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = "Location"
        annotation.subtitle = "Sol"
        
        //Add pin to the pressed point on the map
        map.addAnnotation(annotation)
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        zoom(location!.coordinate.latitude, long: location!.coordinate.longitude)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error with CoreLocation " + error.localizedDescription)
        zoom(56.170303, long: 14.863073)
    }
    
    func zoom(lat: CLLocationDegrees, long: CLLocationDegrees) -> Void{
        //Coordinates
        //let lat:CLLocationDegrees = 56.170303
        //let long:CLLocationDegrees = 14.863073
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        //Span
        let latSpan:CLLocationDegrees = 1
        let longSpan:CLLocationDegrees = 1
        let span = MKCoordinateSpan(latitudeDelta: latSpan, longitudeDelta: longSpan)
        
        //Set area and center of area
        let region = MKCoordinateRegion(center: coordinates, span: span)
        
        //Kartans startvy är nu
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "Karlshamn"
        annotation.subtitle = "SOL!!!!"
        annotation.coordinate = coordinates
        
        //Create a circle
        
        let circle = MKCircle(centerCoordinate: coordinates, radius: 2000)
        map.addOverlay(circle)
        
        map.addAnnotation(annotation)
        
    }
    


}
