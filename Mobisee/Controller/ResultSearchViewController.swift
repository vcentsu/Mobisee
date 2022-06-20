//
//  ResultSearchViewController.swift
//  Mobisee
//
//  Created by Anak Agung Gede Agung Davin on 15/06/22.
//

import UIKit
import CoreLocation

protocol ResultSearchViewControllerDelegate: AnyObject{
    func didTapPlace(with coordinates: CLLocationCoordinate2D)
}

class ResultSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    weak var delegate: ResultSearchViewControllerDelegate?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var places: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .clear
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    public func update(with places: [Place]){
        tableView.isHidden = false
        print(places.count)
        self.places = places
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
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
                    self.delegate?.didTapPlace(with: coordinate)
                }

            case .failure(let error):
                print(error)
            }
        }
    }

}
