//
//  RecommendationViewController.swift
//  Mobisee
//
//  Created by Vincentius Sutanto on 27/06/22.
//

import UIKit

var totalTimePass = 100

class RecommendationViewController: UIViewController {
    
    let OrangeForHead = UIColor(red: 255, green: 171, blue: 73, alpha: 1)
    let OrangeForBackground = UIColor(red: 255, green: 243, blue: 229, alpha: 1)
    let GreenForHead = UIColor(red: 91, green: 157, blue: 87, alpha: 1)
    let GreenForBackground = UIColor(red: 239, green: 255, blue: 238, alpha: 1)
    var today : DateComponents!
    
    //Data Control
    var recommendList = Route()
    
    @IBOutlet weak var collectionView: UICollectionView!
    //@IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hardcoded struct variable
        today = getTodayString()
        recommendList.recommend[0][0].timeStart = "\(today.hour ?? 0).\(today.minute ?? 0)"
        recommendList.recommend[0][0].timeEnd = calcTime(duration: minute, timeStarted: today)
        recommendList.recommend[0][0].totalMin = (minute/60)
        recommendList.recommend[1][0].totalMin = (minute2/60)
        recommendList.recommend[1][0].timeStart = "\(today.hour ?? 0).\(today.minute ?? 0)"
        recommendList.recommend[1][0].timeEnd = calcTime(duration: minute2, timeStarted: today)
        
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 100
    }
    
    func getTodayString() -> DateComponents{

        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.hour,.minute], from: date)

        let hours = components.hour
        let minutes = components.minute

        let timeToday = DateComponents(
            day: 0,
            hour: hours,
            minute: minutes
        )

    return timeToday

    }
    
    func calcTime(duration: Int, timeStarted: DateComponents) -> String{
        var tempHour: Int?
        var tempMin: Int?
        let timeEndMin = (timeStarted.minute ?? 0) + (duration/60)
        
        if timeEndMin >= 60{
            tempHour = (timeStarted.hour ?? 0) + 1
            tempMin = timeEndMin - 60
        }
        else{
            tempHour = timeStarted.hour
            tempMin = timeEndMin
        }
        
        return "\(tempHour ?? 0).\(tempMin ?? 0)"
    }
}

extension RecommendationViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendList.recommend.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendList.recommend[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCellID", for: indexPath) as? RecommendCell)!
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.0
        
        //SHADOW
        cell.layer.shadowColor = UIColor.systemGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        
        
        if (recommendList.recommend[indexPath.section][indexPath.row].status == "best"){
            cell.backgroundColor = UIColor(named: "OrangeBackground")
            cell.headView.backgroundColor = UIColor(named: "OrangeMain")
        }else{
            cell.backgroundColor = UIColor(named: "GreenBackground")
            cell.headView.backgroundColor = UIColor(named: "GreenMain")
        }
        
        cell.totalMin.text = "\(recommendList.recommend[indexPath.section][indexPath.row].totalMin)"
        cell.startTime.text = recommendList.recommend[indexPath.section][indexPath.row].timeStart
        cell.endTime.text = recommendList.recommend[indexPath.section][indexPath.row].timeEnd
        cell.firstMileImg.image = UIImage(named: recommendList.recommend[indexPath.section][indexPath.row].first)
        cell.middleMileImg.image = UIImage(named: recommendList.recommend[indexPath.section][indexPath.row].middle)
        cell.lastMileImg.image = UIImage(named: recommendList.recommend[indexPath.section][indexPath.row].last)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }

}


//extension RecommendationViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 80.0
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "Recommended"
//        }else{
//            return "Others"
//        }
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return recommendList.recommend.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return recommendList.recommend[section].count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = (tableView.dequeueReusableCell(withIdentifier: "RecommendCellID", for: indexPath) as? RecommendationCell)!
//
//        if (recommendList.recommend[indexPath.section][indexPath.row].status == "best"){
//            cell.backView.backgroundColor =
//            cell.headView.backgroundColor =
//        }else{
//            cell.backView.backgroundColor =
//            cell.headView.backgroundColor =
//        }
//
//        cell.totalMin.text = "\(recommendList.recommend[indexPath.section][indexPath.row].totalMin)"
//        cell.startTime.text = recommendList.recommend[indexPath.section][indexPath.row].timeStart
//        cell.endTime.text = recommendList.recommend[indexPath.section][indexPath.row].timeEnd
//        cell.firstMileImg.image = UIImage(named: recommendList.recommend[indexPath.section][indexPath.row].first)
//        cell.middleMileImg.image = UIImage(named: recommendList.recommend[indexPath.section][indexPath.row].middle)
//        cell.lastMileImg.image = UIImage(named: recommendList.recommend[indexPath.section][indexPath.row].last)
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
//}
