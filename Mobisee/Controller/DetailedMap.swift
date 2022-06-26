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
    }
    
    func drawGoogleAPIDirection(){
        //hardcoded placeholder
        let origin = "\(-6.213390),\(106.851940)"
        let destination = "\(-6.17519), \(106.82710)"
        
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?avoid=highways&destination=\(destination)&mode=transit&origin=\(origin)&key=\(apiKey)"
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
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
                            <#body#>
                        }
                    })
                    
                } catch let error as NSError{
                    print("error: \(error)")
                }
                
            }
        }
    }
    
    func addSourceDestinationMarkers(){
        
    }
    
    func getTotalDistance(){
        //hardcoded placeholder
        let origin = "\(-6.213390),\(106.851940)"
        let destination = "\(-6.17519), \(106.82710)"
        
        //can be acessed in api documentation
        let urlString = "https://maps.googleapis.com/maps/api/distancematrix/json ?destinations=\(destination)&mode=transit&origins=\(origin)&key=\(apiKey)&language=en-EN&transit_routing_preference=less_walking"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if(error != nil){
                print("Error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options :.fragmentsAllowed) as! [String :AnyObject]
                    let rows = json["rows"] as! NSArray
                    print(rows)
                    
                    let dic = rows[0] as! Dictionary<String, Any>
                    let elements = dic["elements"] as! NSArray
                    let dis = elements[0] as! Dictionary<String, Any>
                    let distanceKM = dis["distance"] as! Dictionary<String, Any>
                    let kiloMeter = distanceKM["text"] as! String
                    
                    self.totalDistance.text = kiloMeter
                    print(kiloMeter + "KM")
                    
                }catch let error as NSError{
                    print("error: \(error)")
                }
                
            }
        }
        
    }
}
