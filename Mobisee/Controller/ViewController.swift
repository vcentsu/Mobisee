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

    
    @IBOutlet weak var gmapView: GMSMapView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    let manager = CLLocationManager()
//    var mapView = GMSMapView()
    var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    var backButtonTap = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

            // Restore the navigation bar to default
            navigationBar.setBackgroundImage(nil, for: .default)
            navigationBar.shadowImage = nil
    }
    
    //extension ViewController: PlanJourneyDelegate{
        func didTapPlace(with coordinates: CLLocationCoordinate2D, text: String) {
            
            //remove all pins in map
            self.gmapView.clear()
             
            //add pin in map
            let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 50.0)
            print(coordinates)
            
            gmapView = GMSMapView.map(withFrame: view.frame, camera: camera)
            gmapView.frame = view.bounds
//            view.addSubview(mapView)
            let marker = GMSMarker()
            marker.position = coordinates
            marker.map = gmapView
        
        }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
        backButtonTap = true
    }
}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // Do any additional setup after loading the view.
        let coordinate = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 16.0)
        gmapView.animate(toLocation: coordinate)
        gmapView.camera = camera
        gmapView.animate(to: camera)
//        view.addSubview(mapView)

       // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = coordinate
        marker.map = self.gmapView
//        marker.title = "Sydneyaaa"
//        marker.snippet = "Australia"
        
        if backButtonTap == true{
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailMapSB") as? DetailedMapController{
                vc.origin = "\(coordinate.latitude),\(coordinate.longitude)"
                backButtonTap = false
                print("License: \n\n\(GMSServices.openSourceLicenseInfo())")
            }
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



