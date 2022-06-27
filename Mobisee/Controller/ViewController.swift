//
//  ViewController.swift
//  Mobisee
//
//  Created by Vincentius Sutanto on 13/06/22.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces

class ViewController: UIViewController{
    
    let manager = CLLocationManager()
    var mapView = GMSMapView()
    var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    var mapDidUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        title = "Add your location"

    }
    
    //extension ViewController: PlanJourneyDelegate{
        func didTapPlace(with coordinates: CLLocationCoordinate2D, text: String) {
            
            //remove all pins in map
            self.mapView.clear()
             
            //add pin in map
            let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 50.0)
            
            print(coordinates)
            
            mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
            mapView.frame = view.bounds
            view.addSubview(mapView)
            let marker = GMSMarker()
            marker.position = coordinates
            marker.map = mapView
        
        }
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // Do any additional setup after loading the view.
        let coordinate = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)

       // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = coordinate
        marker.title = "Sydneyaaa"
        marker.snippet = "Australia"
        marker.map = mapView
        
        print("License: \n\n\(GMSServices.openSourceLicenseInfo())")
        
        if mapDidUpdate == true{
            didTapPlace(with: coordinates, text: "check")
        }
        else{
            return
        }
        
    }
}

//    func updateSearchResults(for searchController: UISearchController) {
//        guard let query = searchController.searchBar.text,
//              !query.trimmingCharacters(in: .whitespaces).isEmpty,
//              let resultsVC = searchController.searchResultsController as? ResultSearchViewControllerOld
//        else{
//            return
//        }
//
////        resultsVC.delegate = self
//
//        GooglePlacesManager.shared.findPlaces(query: query) { result in
//            switch result{
//            case .success(let places):
//                print(places)
//                print("Found Places")
//
//                DispatchQueue.main.async {
//                    resultsVC.update(with: places)
//                }
//
//            case .failure(let error):
//                print(error)
//
//            }
//        }
//    }



