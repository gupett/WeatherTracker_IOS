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
    
    //Nytt för algoritmen
    //List of delete buttons wich contains references to coresponding polygon
    var buttonList: [DeleteAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //remove back button from navigationcontroller, should be done befoure the view is shown in prepare for segue
        
        //tog bort kod för att gömma default back-btn
        //self.navigationItem.setHidesBackButton(true, animated: false)

        //this class is the delegate for the locationManager and map
        self.locationManager.delegate = self
        self.map.delegate = self
        //My custom delegateprotocol for drawView
        drawView.delegate = self
        //let label = cell.viewWithTag(1) as! UILabel
        
        
        
        //BORTTAGEN KOD FÖR EGEN BAKÅT KNAPP
        /*
        let button = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: "goBack")
        self.navigationItem.rightBarButtonItem = button
         */
        
        showLocation()
        createSearchBar()
        
        //Set a image to the button
        if let penImage = UIImage(named: "Pen"){
            showDrawView.setImage(penImage, forState: .Normal)
            //set the color of the button to black
            showDrawView.tintColor = UIColor(colorLiteralRed: 1, green: 152/256, blue: 0, alpha: 1)
        }
        
        
        //Configuer navigationbar
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 25/256, green: 118/256, blue: 210/256, alpha: 1)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(colorLiteralRed: 25/256, green: 118/256, blue: 210/256, alpha: 1)
    }
    
    func goBack(){
        print("was called4")
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
        showDrawView.superview?.sendSubviewToBack(showDrawView)
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
        showDrawView.superview?.bringSubviewToFront(showDrawView)
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
    
    // MARK: - test to show annotations on map
    func showAnnotationsInsidePolygon(polygonCoordinates: [CLLocationCoordinate2D]){
        print("show annotations inside")
        //Hämta mittpunkterna på de små kvadraterna
        let coordinates = ContainsCoordinate().coordinatesForSubSquaresOfPolygon(polygonCoordinates, map: self.map, view: self.view)
        //se om mittpunkterna ligger innanför polygonen
        
        for coordinate in coordinates {
            print(String(coordinate), " kdhfhjdskölgfdg")
            if (ContainsCoordinate().insidePolygonCalculatedWithCoordinates(polygonCoordinates, coordinate: coordinate, map: self.map, view: self.view)){
                print("kör i if")
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = String(coordinate)
                self.map.addAnnotation(annotation)
            }
        }
        
        let cornerCoordinates = ContainsCoordinate().maxCoordiantesOfPolygon(polygonCoordinates)
        
        let c1 = CornerAnnotation(_coordinate: cornerCoordinates.0)
        let c2 = CornerAnnotation(_coordinate: cornerCoordinates.1)
        let c3 = CornerAnnotation(_coordinate: cornerCoordinates.2)
        let c4 = CornerAnnotation(_coordinate: cornerCoordinates.3)
        
        map.addAnnotation(c1)
        map.addAnnotation(c2)
        map.addAnnotation(c3)
        map.addAnnotation(c4)
        
    }
    
    // MARK: - Show annotation and overlay on map
    //Nytt sen algoritm
    //& declare in out variable
    func showOverlayOnMap(var coordinates: [CLLocationCoordinate2D]){
        let polygonOverlay = MKPolygon(coordinates: &coordinates, count: coordinates.count)
        map.addOverlay(polygonOverlay)
        //Nytt sen algoritm med argumentet för polylinje coordinaterna
        createCorrespondingDeleteButton(polygonOverlay, startCoordinate: coordinates[0], polygonCoordinates: coordinates)
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
    //Nytt från algoritm att funktionen tar in lista med polygon koordinater
    //Create the delete button for a specific marked area
    func createCorrespondingDeleteButton(polygon: MKPolygon, startCoordinate: CLLocationCoordinate2D, polygonCoordinates: [CLLocationCoordinate2D]){
        //Nytt från algoritm att DeleteAnnotation tar in polygon koordinater för att kunna ha punkter att dra linjer mellan för att kunna
        //se om koordinat befinnersig innanför polygon
        let pin = DeleteAnnotation(_coordinates: startCoordinate, with_polygon: polygon, and_PolygonCoordinates: polygonCoordinates)
        map.addAnnotation(pin)
        //lägg till pins i overlayen
        showAnnotationsInsidePolygon(polygonCoordinates)
        
        //List to holding reference to all deleteButtons
        buttonList.append(pin)
    }
    
    //To show the custom annotation (DeleteAnnotation), this delegate method will be called when the annotation comes in view
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        //Om vanlig standard annotation
        if annotation is MKPointAnnotation{
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            print("Should show annotation")
            return pinView
        }
        
        if annotation is CornerAnnotation{
            let corner = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "corner")
            corner.pinColor = MKPinAnnotationColor.Green
            return corner
        }
        
        
        //måste implementera reuseidentifier
        //Check if the annotation actually is a DeleteAnnotation
        if let button = annotation as? DeleteAnnotation{
            let deleteButton = DeleteAnnotationView(annotation: button, reuseIdentifier: "deleteButton", deleteAnnotation: button)
            
            deleteButton.image = UIImage(named: "RoundDeleteButton")
            
            return deleteButton
        }
        
        return MKAnnotationView()
    }
    
    
    // MARK: - Ändrat i och med algoritm
    // If a annotation is selected this delegate method will be called
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        //Check if the selected annotation actually is a DeleteAnnotationView
        if let deleteAnnotationView = view as? DeleteAnnotationView {
            let overlayPolygon = deleteAnnotationView.deleteAnnotation?.polygon
            map.removeOverlay(overlayPolygon!)
            map.removeAnnotation(deleteAnnotationView.deleteAnnotation!)
            
            //Nytt för algoritmen
            //se if deleteAnnotation exists for deleteAnnotationView and if it does see if it is inside the list and if so filter it from list
            if let deleteAnnotation = deleteAnnotationView.deleteAnnotation{
                if buttonList.contains(deleteAnnotation){
                    buttonList = buttonList.filter({$0 != deleteAnnotationView.deleteAnnotation})
                }
            }
            
        }
        
        //test för att se om deleteAnnotations försvinner från listan
        var i = 1
        for _ in buttonList{
            print(i++)
        }

    }
    
    
}
