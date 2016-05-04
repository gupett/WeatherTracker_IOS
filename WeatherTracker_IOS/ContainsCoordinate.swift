//
//  ContainsCoordinate.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 27/04/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

import MapKit



class ContainsCoordinate {
    
    func insidePolygon(lines: [CLLocationCoordinate2D], coordinate: CLLocationCoordinate2D, map: MKMapView, view: UIView) -> (Bool){
        
        
        
        let maxCoordinates = maxCoordiantesOfPolygon(lines)
        
        //Testar så att punkt befinner sig innanför koordinat
        
        if !(insideSquare(coordinate, map: map, view: view, maxCoordinates: maxCoordinates)){
            
            return false
            
        }
        
        
        let p3 = map.convertCoordinate(coordinate, toPointToView: view)
        
        let tempP4 = map.convertCoordinate(maxCoordinates.0, toPointToView: view)
        
        let p4 = CGPoint(x: tempP4.x+1, y: tempP4.y+1)
        
        var numOfIntersections = 0
        
        
        
        let max = lines.count - 1
        
        for (var i = 0; i < max; i++){
            
            //let coordinate : CLLocationCoordinate2D = map.convertPoint(lines[0].start, toCoordinateFromView: map)
            
            let p1 = map.convertCoordinate(lines[i], toPointToView: view)
            
            let p2 = map.convertCoordinate(lines[i+1], toPointToView: view)
            
            
            
            numOfIntersections = numOfIntersections + intersect(p1, point2: p2, intersectingPoints: p3, point4: p4)
            
        }
        
        //om rayen skär udda antal linjer ligger punkten i polygonen annars inte.
        
        if (numOfIntersections % 2 == 1){
            
            return true
            
        }
        
        return false
        
    }
    
    
    //ser om coordinaten ligger utanför fyrkanten som begränsar polygonen
    
    func insideSquare(coordiante: CLLocationCoordinate2D, map: MKMapView, view: UIView, maxCoordinates: (CLLocationCoordinate2D,
        
        CLLocationCoordinate2D, CLLocationCoordinate2D, CLLocationCoordinate2D)) -> (Bool){
        
        let point = map.convertCoordinate(coordiante, toPointToView: view)
        
        
        let minX = map.convertCoordinate(maxCoordinates.0, toPointToView: view).x
        
        let maxX = map.convertCoordinate(maxCoordinates.1, toPointToView: view).x
        
        let minY = map.convertCoordinate(maxCoordinates.1, toPointToView: view).y
        
        let maxY = map.convertCoordinate(maxCoordinates.0, toPointToView: view).y
        
        
        if (point.x < minX || point.x > maxX){
            
            return false
            
        }
        
    
        if (point.y < minY || point.y > maxY){
            
            return false
            
        }
        
        
        return true
        
    }
    
    
    //tar fram minsta fyrkant som polygonen ligger innanför
    
    func maxCoordiantesOfPolygon(coordiates: [CLLocationCoordinate2D]) -> (CLLocationCoordinate2D,
        
        CLLocationCoordinate2D, CLLocationCoordinate2D, CLLocationCoordinate2D){
            
            var minX: Double = 1000000
            
            var maxX: Double = -100000
            
            var minY: Double = 100000
            
            var maxY: Double = -100000
            
            
            
            for coordiane in coordiates{
                
                if (coordiane.latitude < minX){
                    
                    minX = coordiane.latitude
                    
                }else if (coordiane.latitude > maxX){
                    
                    maxX = coordiane.latitude
                    
                }else if (coordiane.longitude < minY){
                    
                    minY = coordiane.longitude
                    
                }else if (coordiane.longitude > maxY){
                    
                    maxY = coordiane.longitude
                    
                }
                
            }
            
            print("minX ", minX, " miny ", minY)
            print("MaxX ", maxX, " MaxY ", maxY)
            
            let upperLeft = CLLocationCoordinate2D(latitude: minX, longitude: maxY)
            
            let upperRight = CLLocationCoordinate2D(latitude: maxX, longitude: maxY)
            
            let lowerLeft = CLLocationCoordinate2D(latitude: minX, longitude: minY)
            
            let lowerRight = CLLocationCoordinate2D(latitude: maxX, longitude: minY)
            
            
            
            return (upperLeft, upperRight, lowerLeft, lowerRight)
            
    }
    
    
    
    func intersect(point1: CGPoint, point2: CGPoint, intersectingPoints point3: CGPoint, point4: CGPoint) -> (Int){
        
        
        //skapar en ekvation från p1 och p2 för att se om p3 och p4 hamnar på olika sidor
        
        //om de hamnar på olika sidor kan det potentialt vara så att linjerna skär varandra
        
        var funcParam = returnFunction(point1, point2: point2)
        
        
        
        var a = funcParam.0
        
        var b = funcParam.1
        
        var c = funcParam.2
        
        
        
        var t1: Double = a * Double(point3.x) + b * Double(point3.y) + c
        
        var t2: Double = a * Double(point4.x) + b * Double(point4.y) + c
        
        
        
        if(t1 < 0 && t2 < 0){
            
            print("Not intersecting")
            
            return 0
            
        }
        
        if(t1 > 0 && t2 > 0){
            
            print("Not intersecting")
            
            return 0
            
        }
        
        
        //utför test igen fast nu från andra hållet
        
        funcParam = returnFunction(point3, point2: point4)
        
        
        a = funcParam.0
        
        b = funcParam.1
        
        c = funcParam.2
        
        
        
        t1 = a * Double(point1.x) + b * Double(point1.y) + c
        
        t2 = a * Double(point2.x) + b * Double(point2.y) + c
        
        
        
        if(t1 < 0 && t2 < 0){
            
            print("Not intersecting")
            
            return 0
            
        }
        
        if(t1 > 0 && t2 > 0){
            
            print("Not intersecting")
            
            return 0
            
        }
        
        
        
        print("lines intersecting")
        
        return 1
        
    }
    
    
    
    func returnFunction(point1: CGPoint, point2: CGPoint) -> (Double, Double, Double){
        
        let x1 = point1.x
        
        let y1 = point1.y
        
        let x2 = point2.x
        
        let y2 = point2.y
        
        
        
        // aX + bY + c = 0
        
        // Y = ((y1-y2)/(x1-x2))X + m
        
        // Y(x1-x2) = (x1-x2)X + d
        
        // Y(x1-x2) + (x2-x1)X = d
        
        // c = -d = Y(x1-x2) + (x2-x1)X
        
        let a: Double = Double(y2 - y1)
        
        let b: Double = Double(x1 - x2)
        
        let c: Double = -((a * Double(x1)) + (b * Double(y1)))
        
        
        
        return (a,b,c)
        
    }
    
    func createSubSquaresForPolygon(coordinates: [CLLocationCoordinate2D], map: MKMapView, view: UIView) -> ([CGPoint], [CLLocationCoordinate2D]){
       
        let maxCoordinates = maxCoordiantesOfPolygon(coordinates)
        
        print("ihfgljk" + String(maxCoordinates.0),String(maxCoordinates.1),String(maxCoordinates.2),String(maxCoordinates.3))
        
        
        //Byter platts på minX och maxX
        let minX = Double(map.convertCoordinate(maxCoordinates.0, toPointToView: view).x)
        let maxX = Double(map.convertCoordinate(maxCoordinates.1, toPointToView: view).x)
        let minY = Double(map.convertCoordinate(maxCoordinates.2, toPointToView: view).y)
        let maxY = Double(map.convertCoordinate(maxCoordinates.0, toPointToView: view).y)
        
        print("minX ", minX, " miny ", minY)
        print("MaxX ", maxX, " MaxY ", maxY)
        
        let xHopp: Double = Double(maxX - minX)/16
        let yHopp: Double = Double(maxY - minY)/16
        
        print(xHopp, " xHopp ", yHopp, " yHopp")
        
        var y: Double = minY + yHopp
        var x: Double = minX + xHopp
        
        var pointList: [CGPoint] = []
        
        while(y < maxY){
            print("i y läget")
            while (x < maxX) {
                print("i x läget")
                pointList.append(CGPoint(x: x, y: y))
                x = x + xHopp
            }
            y = y + yHopp
        }
        
        var mapCoordinates: [CLLocationCoordinate2D] = []
        
        for point in pointList{
            mapCoordinates.append(map.convertPoint(point, toCoordinateFromView: view))
            print(String(map.convertPoint(point, toCoordinateFromView: view)))
        }
        
        
        return (pointList, mapCoordinates)
    }
    
    
    func coordinatesForSubSquaresOfPolygon(coordinates: [CLLocationCoordinate2D], map: MKMapView, view: UIView) -> [CLLocationCoordinate2D]{
        
        let maxCoordinates = maxCoordiantesOfPolygon(coordinates)
        
        print("ihfgljk" + String(maxCoordinates.0),String(maxCoordinates.1),String(maxCoordinates.2),String(maxCoordinates.3))
        
        
        //Byter platts på minX och maxX
        let minX = maxCoordinates.0.latitude
        let maxX = maxCoordinates.1.latitude
        let minY = maxCoordinates.2.longitude
        let maxY = maxCoordinates.0.longitude
        
        print("minX ", minX, " miny ", minY)
        print("MaxX ", maxX, " MaxY ", maxY)
        
        let xHopp: Double = Double(maxX - minX)/16
        let yHopp: Double = Double(maxY - minY)/16
        
        print(xHopp, " xHopp ", yHopp, " yHopp")
        
        var y: Double = minY + yHopp
        var x: Double = minX + xHopp
        
        var mapCoordinates: [CLLocationCoordinate2D] = []
        
        while(y < maxY){
            print("i y läget")
            x = minX + xHopp
            while (x < maxX) {
                print("i x läget")
                let coordinate = CLLocationCoordinate2D(latitude: x, longitude: y)
                print(String(coordinate))
                mapCoordinates.append(coordinate)
                x = x + xHopp
            }
            y = y + yHopp
        }
        

        
        return mapCoordinates
    }
    
    func intersectCoordinates(point1: CLLocationCoordinate2D, point2: CLLocationCoordinate2D, intersectingPoints point3: CLLocationCoordinate2D, point4: CLLocationCoordinate2D) -> (Int){
        
        
        //skapar en ekvation från p1 och p2 för att se om p3 och p4 hamnar på olika sidor
        
        //om de hamnar på olika sidor kan det potentialt vara så att linjerna skär varandra
        
        var funcParam = returnFunctionForCoordinates(point1, point2: point2)
        
        var a = funcParam.0
        
        var b = funcParam.1
        
        var c = funcParam.2
        
        
        
        var t1: Double = a * Double(point3.latitude) + b * Double(point3.longitude) + c
        
        var t2: Double = a * Double(point4.latitude) + b * Double(point4.longitude) + c
        
        
        
        if(t1 < 0 && t2 < 0){
            
            print("Not intersecting")
            
            return 0
            
        }
        
        if(t1 > 0 && t2 > 0){
            
            print("Not intersecting")
            
            return 0
            
        }
        
        
        //utför test igen fast nu från andra hållet
        
        funcParam = returnFunctionForCoordinates(point3, point2: point4)
        
        
        a = funcParam.0
        
        b = funcParam.1
        
        c = funcParam.2
        
        
        
        t1 = a * Double(point1.latitude) + b * Double(point1.longitude) + c
        
        t2 = a * Double(point2.latitude) + b * Double(point2.longitude) + c
        
        
        
        if(t1 < 0 && t2 < 0){
            
            print("Not intersecting")
            
            return 0
            
        }
        
        if(t1 > 0 && t2 > 0){
            
            print("Not intersecting")
            
            return 0
            
        }
        
        
        
        print("lines intersecting")
        
        return 1
        
    }

    func returnFunctionForCoordinates(point1: CLLocationCoordinate2D, point2: CLLocationCoordinate2D) -> (Double, Double, Double){
        
        let x1 = point1.latitude
        
        let y1 = point1.longitude
        
        let x2 = point2.latitude
        
        let y2 = point2.longitude
        
        
        
        // aX + bY + c = 0
        
        // Y = ((y1-y2)/(x1-x2))X + m
        
        // Y(x1-x2) = (x1-x2)X + d
        
        // Y(x1-x2) + (x2-x1)X = d
        
        // c = -d = Y(x1-x2) + (x2-x1)X
        
        let a: Double = Double(y2 - y1)
        
        let b: Double = Double(x1 - x2)
        
        let c: Double = -((a * Double(x1)) + (b * Double(y1)))
        
        
        
        return (a,b,c)
        
    }

    func insidePolygonCalculatedWithCoordinates(lines: [CLLocationCoordinate2D], coordinate: CLLocationCoordinate2D, map: MKMapView, view: UIView) -> (Bool){
        
        
        
        let maxCoordinates = maxCoordiantesOfPolygon(lines)
        
        //Testar så att punkt befinner sig innanför koordinat
        
        /*if !(insideSquare(coordinate, map: map, view: view, maxCoordinates: maxCoordinates)){
            
            return false
            
        }*/
        
        let tempLat = maxCoordinates.0.latitude - 1
        let templong = maxCoordinates.0.longitude + 1
        let outsidePoint = CLLocationCoordinate2D(latitude: tempLat, longitude: templong)
        var numOfIntersections = 0
        
        let max = lines.count - 1
        var i = 0
        while(i < max){
            
            //let coordinate : CLLocationCoordinate2D = map.convertPoint(lines[0].start, toCoordinateFromView: map)
            
            let p1 = lines[i]
            
            let p2 = lines[i+1]

            numOfIntersections = numOfIntersections + intersectCoordinates(p1, point2: p2, intersectingPoints: outsidePoint, point4: coordinate)
            
            i = i + 1
        }
        
        //om rayen skär udda antal linjer ligger punkten i polygonen annars inte.
        
        if (numOfIntersections % 2 == 1){
            
            return true
            
        }
        
        return false
        
    }
}
