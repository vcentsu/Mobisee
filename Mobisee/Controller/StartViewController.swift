//
//  StartViewController.swift
//  Mobisee
//
//  Created by Vincentius Sutanto on 22/06/22.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func pressPlanBtn(_ sender: Any) {
        let planJourneyVC =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlanJourneyID")
        if let sheet = planJourneyVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 24
        }
        
        self.present(planJourneyVC, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
