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

class MapViewControlerViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, GPMapDrawDelegate {

    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var drawView: DrawView!
    
    @IBOutlet weak var showDrawView: UIButton!
    
    //Variabel to the search baren
    var resultSearchController: UISearchController? = nil
    
    let locationManager = CLLocationManager()
    
    var searchCoordinate: CLLocationCoordinate2D? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this class is the delegate for the locationManager and map
        self.locationManager.delegate = self
        self.map.delegate = self
        //My custom delegateprotocol for drawView
        drawView.delegate = self
        
        showLocation()
        createSearchBar()
        
        //Set a image to the button
        if let penImage = UIImage(named: "Pen"){
            showDrawView.setImage(penImage, forState: .Normal)
            //set the color of the button to black
            showDrawView.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if let coordinate: CLLocationCoordinate2D = searchCoordinate {
            let lat = coordinate.latitude
            let long = coordinate.longitude
            searchCoordinate = nil
            zoom(lat, long: long)
        }
    }
    
    @IBAction func showDrawView(sender: AnyObject) {
        drawView.superview?.bringSubviewToFront(drawView)
    }
    
    func showLocation(){
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.map.showsUserLocation = true
    }
    
    func createSearchBar(){
        //Set up the search bar and corresponding tableview
        //To access the tableViewController
        let resultSearchTable = storyboard!.instantiateViewControllerWithIdentifier("LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: resultSearchTable)
        resultSearchController?.searchResultsUpdater = resultSearchTable
        
        //configures the search bar, and embeds it within the navigation bar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        //add the search bar on teh top of the screen
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        
        //Make sure that the overlay does not cover the searchbar
        definesPresentationContext = true
        
        //Give the LocationSearchTable access to add and modify the map
        resultSearchTable.map = self.map
    }
    
    
    // MARK: - Get current location
    
    // Location manager delegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        zoom(location!.coordinate.latitude, long: location!.coordinate.longitude)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error with CoreLocation " + error.localizedDescription)
        zoom(56.170303, long: 14.863073)
    }
    
    // MARK: - zoom to a desired location
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
    }
    
    // MARK: - Implementing GPMapDraw functions
    
    func dismissDrawView() {
        map.superview?.bringSubviewToFront(map)
    }
    
    func convertLinesToOverlay(lines: [Line]) {
        var coordinates: [CLLocationCoordinate2D] = []
        for line: Line in lines {
            let coordinate: CLLocationCoordinate2D = map.convertPoint(line.start, toCoordinateFromView: map)
            coordinates.append(coordinate)
        }
        
        let coordinate : CLLocationCoordinate2D = map.convertPoint(lines[0].start, toCoordinateFromView: map)
        coordinates.append(coordinate)
        
        for coordinate in coordinates {
            print(coordinate)
        }
        
        showOverlayOnMap(coordinates)
    }
    
    // MARK: - Show annotation and overlay on map
    
    //& declare in out variable
    func showOverlayOnMap(var coordinates: [CLLocationCoordinate2D]){
        let polygonOverlay = MKPolygon(coordinates: &coordinates, count: coordinates.count)
        map.addOverlay(polygonOverlay)
        createCorrespondingDeleteButton(polygonOverlay, startCoordinate: coordinates[0])
    }
    
    
    
    //To make a MKOverlay show on map, delegate method from MKMapViewDelegate protocol
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        
        if let overlayPolygon: MKPolygon = overlay as? MKPolygon{
            let polygonArea = MKPolygonRenderer(polygon: overlayPolygon)
            polygonArea.fillColor = UIColor(colorLiteralRed: 0, green: 0, blue: 1, alpha: 30/256)
            polygonArea.strokeColor = UIColor(colorLiteralRed: 0, green: 0, blue: 1, alpha: 1)
            polygonArea.lineWidth = 2
            return polygonArea
        }
        return MKOverlayRenderer()
    }
    
    
    // MARK: - Show and create delete button
    
    //Create the delete button for a specific marked area
    func createCorrespondingDeleteButton(polygon: MKPolygon, startCoordinate: CLLocationCoordinate2D){
        let pin = DeleteAnnotation(_coordinates: startCoordinate, with_polygon: polygon)
        map.addAnnotation(pin)
    }
    
    //To show the custom annotation (DeleteAnnotation), this delegate method will be called when the annotation comes in view
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        //Check if the annotation actually is a DeleteAnnotation
        if let button = annotation as? DeleteAnnotation{
            let deleteButton = DeleteAnnotationView(annotation: button, reuseIdentifier: "deleteButton", deleteAnnotation: button)
            
            deleteButton.image = UIImage(named: "RoundDeleteButton")
            
            return deleteButton
        }
        
        return MKAnnotationView()
    }
    
    // If a annotation is selected this delegate method will be called
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        //Check if the selected annotation actually is a DeleteAnnotationView
        if let deleteAnnotationView = view as? DeleteAnnotationView {
            let overlayPolygon = deleteAnnotationView.deleteAnnotation?.polygon
            map.removeOverlay(overlayPolygon!)
            map.removeAnnotation(deleteAnnotationView.deleteAnnotation!)
        }

    }
    
}
