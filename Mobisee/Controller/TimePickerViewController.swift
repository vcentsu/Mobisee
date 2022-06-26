//
//  TimePickerViewController.swift
//  Mobisee
//
//  Created by Vincentius Sutanto on 26/06/22.
//

import UIKit

class TimePickerViewController: UIViewController {
    
    var pickTime: String = ""

    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Leaving Time"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
    }
    
    @objc func didTapDone(){

        if checkInput(){
            print(pickTime)
            performSegue(withIdentifier: "unwindToCategory", sender: self)
            
        }
    }
    
    func checkInput() -> Bool {

//        let category = pickCategory
        if pickTime == "" {
            showAlert()
            return false
        }
        return true
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "No Time Selected", message: "Select time you want", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {action in print("tapped dismiss")}))
        present(alert, animated: true)
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
