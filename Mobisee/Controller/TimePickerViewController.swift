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
        
        //timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
    }
    
    @objc func timePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        pickTime = formatter.string(from: sender.date)
    }
    
    @objc func didTapDone(){
        if pickTime == "" {
            
            // Alert "continue with current time?"
            let alert = UIAlertController(title: "", message: "Do you want to continue with current time?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
                print("tapped dismiss")
            }))
            
            alert.addAction(UIAlertAction(title: "Sure", style: .default, handler: {action in
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                self.pickTime = formatter.string(from: self.timePicker.date)
                print(self.pickTime)
                self.done()
            }))
            
            present(alert, animated: true)
        }
        
        done()
    }
    
    func done() {
        if checkInput(){
            performSegue(withIdentifier: "unwindToCategory", sender: self)
        }
    }
    
    func checkInput() -> Bool {
        
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
