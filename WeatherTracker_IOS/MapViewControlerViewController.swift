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

class MapViewControlerViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, GPMapDrawDelegate, WeatherResultDelegate{

    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var drawView: DrawView!
    
    @IBOutlet weak var showDrawView: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var loadingMonitor: UIActivityIndicatorView!
    
    @IBOutlet weak var loadingBackground: UIView!
    
    var removeAnnotations = false
    
    
    
    /*
    //reference to the searchbar
    var resultSearchController: UISearchController? = nil
   */
    
    let locationManager = CLLocationManager()
    
    var searchCoordinate: CLLocationCoordinate2D? = nil
    
    
    var searchParams = [String: Double]()
    
    var searchDates: [String] = []
    
    var navController: NavigationController!
    
    var firstTime = true
    
    
    //Nytt för algoritmen
    //List of delete buttons wich contains references to coresponding polygon
    var buttonList: [DeleteAnnotation] = []
    
    //reference that will hold the search results the parameters will be passed in by the ParseJson object
    //Will hold different lists for different keys. The key for the overall top three is "best" and the other keys are the stringform of the day "yyyy-mm-dd"
    var resultDictionary = [String: [WeatherContainer]]()
    
    // Reference to all ResultAnnotations showing on map
    var resultAnnotationsCurrentlyOnMap: [ResultAnnotation] = []
    
    
    
    // Referens till ResultatTabBar så vi kan komma åt funktioner för att visa och dölja den.
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchParams = DataContainer.sharedDataContainer.Parameters!
        searchDates = DataContainer.sharedDataContainer.Dates!
        
        print("\(searchParams) sök parametrer")
        print("\(searchDates) sök dagar")

        //this class is the delegate for the locationManager and map
        self.locationManager.delegate = self
        self.map.delegate = self
        //My custom delegateprotocol for drawView
        drawView.delegate = self
        
        
        showLocation()
        
        //createSearchBar()
        
        showDrawView.superview?.bringSubviewToFront(showDrawView)
        
        //Set an image to the button
        if let penImage = UIImage(named: "Pen"){
            showDrawView.setImage(penImage, forState: .Normal)
            //set the color of the button to black
            showDrawView.tintColor = UIColor(colorLiteralRed: 1, green: 152/256, blue: 0, alpha: 1)
        }
        
        
        //Configuer navigationbar
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 25/256, green: 118/256, blue: 210/256, alpha: 1)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(colorLiteralRed: 25/256, green: 118/256, blue: 210/256, alpha: 1)
    }
    
    func back(sender: UIBarButtonItem) {
        deleteAnnotations()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    //När kartvyn försvinner och om vi inte är inne i resultatvyn så rensar vi kartan
    override func viewDidDisappear(animated: Bool) {
        if (DataContainer.sharedDataContainer.show == false)
        {
            print("removing everything")
            
            deleteAnnotations()
        }
    }
    
    func deleteAnnotations(){
       
        for annotation in self.map.annotations{
            self.map.removeAnnotation(annotation)
        }
        for button in buttonList {
            map.removeOverlay(button.polygon)
        }
        buttonList.removeAll()
        

    }
    
    override func viewDidAppear(animated: Bool) {
        //Gör en egen back button
        self.tabBarController?.navigationItem.hidesBackButton = false
        
        print("\(removeAnnotations) remove annotations är vad jag är")
        
        if removeAnnotations {
            for annotation in map.annotations{
                map.removeAnnotation(annotation)
            }
        }
        
        self.tabBarController?.navigationItem.hidesBackButton = false
        //let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back:")
        //self.tabBarController?.navigationItem.leftBarButtonItem = newBackButton;
        
        //zoom in to location every time map opens, maby change?
        if let coordinate: CLLocationCoordinate2D = searchCoordinate
        {
            let lat = coordinate.latitude
            let long = coordinate.longitude
            searchCoordinate = nil
            zoom(lat, long: long)
            
        }
        
        
        // Visa Searchbar och DrawView överst
        //navigationItem.titleView?.hidden = false
        showDrawView.superview?.bringSubviewToFront(showDrawView)
        print("showdrawview to front")

       
        //Sätt Parametrar och Datum utifrån Globala DataPassingContainer
        searchParams = DataContainer.sharedDataContainer.Parameters!
        searchDates = DataContainer.sharedDataContainer.Dates!
        print("\(searchParams) sök parametrer")
        print("\(searchDates) sök dagar")
        
        // SKapa en referens till ResultatTabVyn så att vi kan visa/dölja den
        guard let navController = self.view.window?.rootViewController as? NavigationController else
        {
            print ("jag fick ingen navigation controller")
            return
        }
        
        
        if navController.resView == nil{
            print("reference = nil")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            
            navController.resView = storyBoard.instantiateViewControllerWithIdentifier("ResView") as? CustomTabControllerViewController
            
        }

        navController.resView?.ShowHide()

        
    }
    
    //Action triggered by pressing the pen button
    @IBAction func showDrawView(sender: AnyObject) {
        drawView.superview?.bringSubviewToFront(drawView)
        showDrawView.superview?.sendSubviewToBack(showDrawView)
         print("DRAWVIEW to front")
        
        
    }

    
    // MARK: - Search weather
    @IBAction func searchWeather(sender: AnyObject) {
        
        for button in buttonList{
            self.map.removeOverlay(button.polygon)
            self.map.removeAnnotation(button)
        }
        
        //Do some changes with the appearance of the mapview
        self.map.superview?.bringSubviewToFront(map)
        self.loadingBackground.superview?.bringSubviewToFront(loadingBackground)
        self.loadingMonitor.superview?.bringSubviewToFront(loadingMonitor)
        self.loadingMonitor.startAnimating()
        
        
        
        DataContainer.sharedDataContainer.show = true
        searchParams = DataContainer.sharedDataContainer.Parameters!
        searchDates = DataContainer.sharedDataContainer.Dates!
        print("\(searchParams) sök parametrer")
        print("\(searchDates) sök dagar")
        
        // SKapa en referens till ResultatTabVyn så att vi kan visa/dölja den
        guard let navController = self.view.window?.rootViewController as? NavigationController else
        {
            print ("jag fick ingen navigation controller")
            return
        }
        
        
        if navController.resView == nil{
            print("reference = nil")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            
            navController.resView = storyBoard.instantiateViewControllerWithIdentifier("ResView") as? CustomTabControllerViewController
            
        }
        
        navController.resView?.ShowHide()
        
        
        for annotation in self.map.annotations
        {
            if annotation is ResultAnnotation
            {
                self.map.removeAnnotation(annotation)
            }
        }
        
        resultAnnotationsCurrentlyOnMap.removeAll()
        DataContainer.sharedDataContainer.ResultAnnotations?.removeAll()
       
        
        
        //Ändringar för kartvyn när sökning sker/har skett
        
        /*
        navigationItem.titleView?.hidden = true
        navigationItem.title = "Resultat"
        */
        
        
        
        
        //The list that will contain all the coordinates that we wish to compare weather for
        var coordinatesToSearchList : [[CLLocationCoordinate2D]] = []
        //The object which will take out the coordiantes inside the polygons
        let polygonSearcher = ContainsCoordinate()
        
        //För att senare kunna veta när de asynkrona uppgifterna är klara
        var numberOFSearchCoordinates = 0
        
        //use deletebutton list to access all the overlays on screen and fill the coordinatesToSearch list with them
        for button in buttonList{
            //Temporary stores the lines of the polygon which we are looking at the moment
            let tempPolygonLines = button.polygonCoordinates
            //performe the search and see which coordinates lies inside the polygon
            let coordinatesForPolygon = polygonSearcher.getCoordinatesIsidePolygon(tempPolygonLines)
            //Extend the newly fetched coordinates to the complete coordinates list
            numberOFSearchCoordinates += coordinatesForPolygon.count
            coordinatesToSearchList.append(coordinatesForPolygon)
        }
        
        //töm button list för att förbereda för nya sökningar
        buttonList.removeAll()

        //print("Antalet intressanta polygoner är: \(coordinatesToSearchList.count) och coordinater är \(numberOFSearchCoordinates)  Text")
        
        //Performe the folowing task in a seperate thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),{
            ParseJson(_numOfLocations: numberOFSearchCoordinates, _dateList: self.searchDates, _params: self.searchParams, _delegate: self).getWeatherForList(coordinatesToSearchList)
            })
        
            }
    
    func showLocation(){
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.map.showsUserLocation = true
    }

    /*
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
        navigationItem.titleView?.hidden = false
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        
        //Make sure that the overlay does not cover the searchbar
        definesPresentationContext = true
        
        //Give the LocationSearchTable access to add and modify the map
        resultSearchTable.map = self.map
    }
 */
    
    
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
        
        
        let lat:CLLocationDegrees = 56.170303
        let long:CLLocationDegrees = 14.863073
        
        
       
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
    
    //To show the custom annotation (DeleteAnnotation), this delegate method will be called when the annotation comes in view
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        //Om det är en annotation som sak visa upp resultat ska den konfigureras på följande sätt
        if let resultAnnotation = annotation as? ResultAnnotation{
            let resultPinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "ResultAnnotation")
            //lila färg
            resultPinAnnotation.pinColor = MKPinAnnotationColor.Green
            let weatherSymbol = resultAnnotation.weatherContainer.weatherSymbol
            print("weather Symbol is now \(weatherSymbol)")
            let image = imageForCallout(weatherSymbol)
            let viewWithImage = UIImageView(frame: CGRectMake(0, 0, 45, 45))
            viewWithImage.image = image
            resultPinAnnotation.leftCalloutAccessoryView = viewWithImage
            resultPinAnnotation.canShowCallout = true
            
            return resultPinAnnotation
        }

        
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
            
            //Brings back DrawView om området tas bort?
            showDrawView.superview?.bringSubviewToFront(showDrawView)
            
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
            print(i)
            i += 1
        }

    }
    

    
    
}
