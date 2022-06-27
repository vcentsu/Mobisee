//
//  RecommendationViewController.swift
//  Mobisee
//
//  Created by Vincentius Sutanto on 27/06/22.
//

import UIKit

class RecommendationViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension RecommendationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCellID", for: indexPath) as? RecommendCell)!
        
        cell.headView.backgroundColor = .systemGreen
        cell.totalMin.text = "40"
        cell.startTime.text = "07.12"
        cell.endTime.text = "08.22"
        cell.firstMileImg.image = UIImage(named: "Transport2")
        cell.middleMileImg.image = UIImage(named: "Transport3")
        cell.lastMileImg.image = UIImage(named: "Transport1")

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    
}
