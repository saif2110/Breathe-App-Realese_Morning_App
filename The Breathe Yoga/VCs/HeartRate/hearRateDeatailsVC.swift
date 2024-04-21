//
//  hearRateDeatailsVC.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 05/06/21.
//

import UIKit

class hearRateDeatailsVC: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var bpmText: UILabel!
    
    var bpm = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = nextButton.bounds.height/2
        
        if bpm.contains("Monitoring"){
            bpmText.attributedText = BPMMessage(bpm: "Error")
        }else{
            bpmText.attributedText = BPMMessage(bpm: bpm)
        }
        
        rateApp()
    }
    
    
    func BPMMessage(bpm:String) -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: bpm.replacingOccurrences(of: "\nBPM", with: ""),
                                                   attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 65)]);
        
        attrString.append(NSMutableAttributedString(string: "\nBPM",
                                                    attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28)]))
        return attrString
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func readyforSPO2(_ sender: Any) {
        
        inserInto(TableName: .HeartRate, Value: bpm, Date: getDatetoadd())
        
        dismiss(animated: true) {
            
            NotificationCenter.default.post(name: NSNotification.Name("readyforSPO2"), object: nil)
        }
        
        
    }
    
}
