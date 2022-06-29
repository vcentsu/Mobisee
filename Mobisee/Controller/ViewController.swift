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
    @IBOutlet weak var pickButton: UIView!
    let marker = GMSMarker()
    let manager = CLLocationManager()
//    var mapView = GMSMapView()
    var coordinateLive: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    var coordinateTap: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    var backButtonTap = false
    var longPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        self.gmapView.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: coordinateLive.latitude, longitude: coordinateLive.longitude, zoom: 16.0)
        gmapView.animate(toLocation: coordinateLive)
        gmapView.camera = camera
        gmapView.animate(to: camera)
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
    
    
    @IBAction func pickLocation(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailMapSB") as? DetailedMapController{
            vc.modalPresentationStyle = .fullScreen
            vc.destination = "\(coordinateTap.latitude),\(coordinateTap.longitude)"
            vc.origin = "\(coordinateLive.latitude),\(coordinateLive.longitude)"
            self.present(vc, animated: true, completion: nil)
        }
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
        coordinateLive = location.coordinate
        gmapView.isMyLocationEnabled = true
        gmapView.settings.myLocationButton = true
        
        print("License: \n\n\(GMSServices.openSourceLicenseInfo())")
    }
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinateTap: CLLocationCoordinate2D) {
        
        self.coordinateTap = coordinateTap
        marker.position = coordinateTap
        marker.map = self.gmapView
        longPressed = false
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailMapSB") as? DetailedMapController{
//            vc.destination = "\(coordinateTap.latitude),\(coordinateTap.longitude)"
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



