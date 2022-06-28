//
//  PlanJourneyViewController.swift
//  Mobisee
//
//  Created by Vincentius Sutanto on 14/06/22.
//

import UIKit
import CoreLocation

protocol PlanJourneyDelegate: AnyObject{
    func didTapPlace(with coordinates: CLLocationCoordinate2D, text: String)
}

class PlanJourneyViewController: UIViewController {
    
    @IBOutlet weak var searchViaMap: UIButton!
    @IBOutlet weak var resultTable: UITableView!
    @IBOutlet weak var arrivalTimeBtn: UIButton!
    
    var selectedTime: String = ""
    
    private var places: [Place] = []
    weak var delegate: PlanJourneyDelegate?
    let searchVC = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //table
        
        resultTable.delegate = self
        resultTable.dataSource = self
        resultTable.register(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        //search bar
        searchVC.searchBar.tag = 1
        searchVC.searchResultsUpdater = self
        searchVC.searchBar.placeholder = "Destination"
        searchVC.searchBar.backgroundColor = .clear
        navigationItem.searchController = searchVC
        
    }
    
    @IBAction func viaMapTapped(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainSB") as? ViewController{
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc, animated: true, completion: nil)
            }
        }
    
    @IBAction func arrivalTimeTapped(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PickTime") as? TimePickerViewController else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        if let vc = seg.source as? TimePickerViewController {
            arrivalTimeBtn.setTitle(" \(vc.pickTime)", for: .normal)
            print(vc.pickTime)
            selectedTime = vc.pickTime
        }
    }
    
    
}

extension PlanJourneyViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = places[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.isHidden = true
        
        let place = places[indexPath.row]
        GooglePlacesManager.shared.resolveLocation(for: place) { result in
            switch result{
            case .success(let coordinate):
                DispatchQueue.main.async {
//                    self.delegate?.didTapPlace(with: coordinate, text: "Check")

//                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainSB") as? ViewController{
//                        vc.modalPresentationStyle = .fullScreen
//                        vc.coordinates = coordinate
//                        vc.mapDidUpdate = true
//                        self.navigationController?.present(vc, animated: true, completion: nil)
//                    }
                    
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailMapSB") as? DetailedMapController{
                        vc.modalPresentationStyle = .fullScreen
                        vc.destination = "\(coordinate.latitude),\(coordinate.longitude)"
                        vc.titleDest = place.name
                        self.present(vc, animated: true, completion: nil)
                    }
                }

            case .failure(let error):
                print(error)
            }
        }
    }
}


extension PlanJourneyViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty
        else{
            return
        }
    
        GooglePlacesManager.shared.findPlaces(query: query) { result in
            switch result{
            case .success(let places):
                print(places)
                print("Found Places")
                
                DispatchQueue.main.async {
                    self.places = places
                    self.update()
                }
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    public func update(){
        resultTable.isHidden = false
        print(places.count)
        resultTable.reloadData()
    }
}

























//class ResultSearchViewControllerNew: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
////    private let tableView: UITableView = {
////        let table = UITableView()
////        table.register(UITableViewCell.self,
////                       forCellReuseIdentifier: "cell")
////        return table
////    }()
//    weak var delegate: ResultSearchViewControllerDelegate?
//
//    private var places: [Place] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
//        view.backgroundColor = .clear
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds
//    }
//
//    public func update(with places: [Place]){
//        tableView.isHidden = false
//        print(places.count)
//        self.places = places
//        tableView.reloadData()
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return places.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = places[indexPath.row].name
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        tableView.isHidden = true
//
//        let place = places[indexPath.row]
//        GooglePlacesManager.shared.resolveLocation(for: place) { result in
//            switch result{
//            case .success(let coordinate):
//                DispatchQueue.main.async {
//                    self.delegate?.didTapPlace(with: coordinate)
//                }
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//
//}
