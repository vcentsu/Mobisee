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

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentModal()
    }
    
    private func presentModal(){
        let navPlanJourneyVC =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationPlanJourneyID")
        navPlanJourneyVC.isModalInPresentation = true
        if let sheet = navPlanJourneyVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 25
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
        }
        
        self.present(navPlanJourneyVC, animated: true, completion: nil)
    }

}
