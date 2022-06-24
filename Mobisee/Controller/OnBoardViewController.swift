//
//  OnBoardViewController.swift
//  Mobisee
//
//  Created by Vincentius Sutanto on 21/06/22.
//

import UIKit

class OnBoardViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate{

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // DATA CONTROL
    var img = ["Card1", "Card2", "Card3"]
    var btn = [true, true, false]
    var activePage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pageControl.numberOfPages = img.count
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return img.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCellID", for: indexPath) as? ItemCell)!
        
        cell.image.image = UIImage(named: img[indexPath.row])
        cell.button.isHidden = btn[indexPath.row]
        // Parallax cell setup
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return collectionView.bounds.size;
        }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.section
    }
    
    @IBAction func pressSkipBtn(_ sender: Any) {
        activePage = 1
        collectionView.scrollToItem(at: IndexPath(item: 3, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func pressUnderstandBtn(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "StartView") as? StartViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
