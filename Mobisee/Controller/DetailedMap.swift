//
//  DetailedMap.swift
//  Mobisee
//
//  Created by Anak Agung Gede Agung Davin on 26/06/22.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class DetailedMapController: UIViewController {

    @IBOutlet weak var detailMapView: GMSMapView!
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    //hardcoded placeholder
    var origin = "\(-6.209960642473714),\(106.84987491861534)"
    var destination = "\(-6.17519),\(106.82710)"
    let apiKey = "AIzaSyCtqBUAWmad-1yoHww05Z6XS7jKfZZWdXo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawGoogleAPIDirection()
    }
    
    func drawGoogleAPIDirection(){
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=transit&key=\(apiKey)"
        let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: encodedURL!)
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if(error != nil){
                print("Error")
            }else{
                
                DispatchQueue.main.async {
                    self.detailMapView.clear()
                    self.addSourceDestinationMarkers()
                }
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options :.fragmentsAllowed) as! [String :AnyObject]
                    let routes = json["routes"] as! NSArray
                    print(routes)
//                    print(routes.object)
                    
                    self.getTotalDistance()
                    
                    OperationQueue.main.addOperation({
                        for route in routes {
                            let routeOverviewPolyline:NSDictionary = (route as! NSDictionary).value(forKey: "overview_polyline") as! NSDictionary
                            let legs = (route as! NSDictionary).value(forKey: "legs")
                            print(legs)
                            let steps = (legs as! NSArray).value(forKey: "steps")
                            let travelModes = (steps as! NSArray).value(forKey: "travel_mode")
//                            print(travelModes)
                            
                            
                            let points = routeOverviewPolyline.object(forKey: "points")
                            let path = GMSPath.init(fromEncodedPath: points! as! String)
                            let polyline = GMSPolyline.init(path: path)
                            polyline.strokeWidth = 3
                            polyline.strokeColor = UIColor(red: 100, green: 100, blue: 100, alpha: 1.0)
                            
                            let bounds = GMSCoordinateBounds(path: path!)
                            self.detailMapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 30.0))
                            
                            polyline.map = self.detailMapView
            
                        }
                    })
                    
                } catch let error as NSError{
                    print("error: \(error)")
                }
            }
        }).resume()
    }
    
    func addSourceDestinationMarkers(){
        let markerSource = GMSMarker()
//        markerSource.icon = UIImage(named: "PinPoint")
        markerSource.position = stringToCoord(longLat: origin)
        markerSource.title = "Point A"
        markerSource.map = detailMapView
        
        let markerDestination = GMSMarker()
//        markerSource.icon = UIImage(named: "PinPoint")
        markerDestination.position = stringToCoord(longLat: destination)
        markerDestination.title = "Point B"
        markerDestination.map = detailMapView
        
    }
    
    func getTotalDistance(){
        
        //can be acessed in api documentation
        let urlString = "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=\(destination)&mode=transit&origins=\(origin)&key=\(apiKey)&language=en-EN&transit_routing_preference=less_walking"
        let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: encodedURL!)
            
        URLSession.shared.dataTask(with: url!, completionHandler:{ (data, response, error) in
            if(error != nil){
                print("Error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options :.fragmentsAllowed) as! [String :AnyObject]
                    let rows = json["rows"] as! NSArray
                    print(rows)
                    
                    let dic = rows[0] as! Dictionary<String, Any>
                    let elements = dic["elements"] as! NSArray
                    let element = elements[0] as! Dictionary<String, Any>
                    
                    let distanceKM = element["distance"] as! Dictionary<String, Any>
                    let kiloMeter = distanceKM["text"] as! String
                    let durationMin = element["duration"] as! Dictionary<String, Any>
                    let minute = durationMin["text"] as! String
                    let fareInRP = element["fare"] as! Dictionary<String, Any>
                    let fareValue = fareInRP["value"] as! Int
                    
                    
                    DispatchQueue.main.async {
                        self.totalDistance.text = kiloMeter
                        print("\(String(describing: self.totalDistance.text))")
                        self.totalTime.text = minute + " Total Harga Rp." + String(fareValue)
                    }
                    
                }catch let error as NSError{
                    print("error: \(error)")
                }
                
            }
        }).resume()
    }
    
    func stringToCoord(longLat:String) -> CLLocationCoordinate2D{
        let coordArr = longLat.components(separatedBy: ",")
        
        let latitude = Double(coordArr[0])
        let longitude = Double(coordArr[1])
        
        return CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)
    }
}