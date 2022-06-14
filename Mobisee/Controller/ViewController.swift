//
//  ViewController.swift
//  Mobisee
//
//  Created by Vincentius Sutanto on 13/06/22.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // Do any additional setup after loading the view.
        let coordinate = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)

       // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = coordinate
        marker.title = "Sydneyaaa"
        marker.snippet = "Australia"
        marker.map = mapView
        
        print("License: \n\n\(GMSServices.openSourceLicenseInfo())")
        
    }


}

