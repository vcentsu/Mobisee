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
    let apiKey = "AIzaSyCtqBUAWmad-1yoHww05Z6XS7jKfZZWdXo"

    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawGoogleAPIDirection()
    }
    
    func drawGoogleAPIDirection(){
        //hardcoded placeholder
        let origin = "\(-6.213390),\(106.851940)"
        let destination = "\(-6.17519), \(106.82710)"
        
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
                    
                    self.getTotalDistance()
                    
                    OperationQueue.main.addOperation({
                        for route in routes {
                            let routeOverviewPolyline:NSDictionary = (route as! NSDictionary).value(forKey: "overview_polyline") as! NSDictionary
                            
                            let points = routeOverviewPolyline.object(forKey: "points")
                            let path = GMSPath.init(fromEncodedPath: points! as! String)
                            let polyline = GMSPolyline.init(path: path)
                            polyline.strokeWidth = 3
                            polyline.strokeColor = UIColor(red: 91, green: 157, blue: 87, alpha: 1.0)
                            
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
        markerSource.position = CLLocationCoordinate2D(latitude: -6.213390, longitude: 106.851940)
        markerSource.title = "Point A"
        markerSource.map = detailMapView
        
        let markerDestination = GMSMarker()
        markerSource.position = CLLocationCoordinate2D(latitude: -6.17519, longitude: 106.82710)
        markerSource.title = "Point B"
        markerDestination.map = detailMapView
        
    }
    
    func getTotalDistance(){
        //hardcoded placeholder
        let origin = "\(-6.213390),\(106.851940)"
        let destination = "\(-6.17519), \(106.82710)"
        
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
}
