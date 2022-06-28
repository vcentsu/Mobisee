//
//  RecommendationViewController.swift
//  Mobisee
//
//  Created by Vincentius Sutanto on 27/06/22.
//

import UIKit

class RecommendationViewController: UIViewController {
    
    let OrangeForHead = UIColor(red: 255, green: 171, blue: 73, alpha: 1)
    let OrangeForBackground = UIColor(red: 255, green: 243, blue: 229, alpha: 1)
    let GreenForHead = UIColor(red: 91, green: 157, blue: 87, alpha: 1)
    let GreenForBackground = UIColor(red: 239, green: 255, blue: 238, alpha: 1)
    
    var recommendList = Route()

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
        if section == 0 {
            return 1
        }else{
            return 3
        }
        //return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCellID", for: indexPath) as? RecommendCell)!
        
        //cell.headView.backgroundColor. = UIColor(red: 255, green: 171, blue: 73, alpha: 1)
        //cell.backgroundColor = UIColor(red: 255, green: 243, blue: 229, alpha: 1)
        //cell.totalMin.text = "\(recommendList.recommend[indexPath.])"
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
