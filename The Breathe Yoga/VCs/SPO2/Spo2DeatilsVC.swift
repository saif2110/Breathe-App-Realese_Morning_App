//
//  Spo2DeatilsVC.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 05/06/21.
//

import UIKit

class Spo2DeatilsVC: UIViewController {
    
    @IBOutlet weak var saveBut: UIButton!
    
    var count = 0
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playSound(name: "exhale")
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        saveBut.layer.cornerRadius = saveBut.bounds.height/2
        
        label.attributedText = resultMessage()
        
    }
    
    func resultMessage() -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: "\(getSpO2(time:count))",
                                                   attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]);
        
        attrString.append(NSMutableAttributedString(string: "\nSpO2",
                                                    attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]))
        return attrString
    }
    
    @IBAction func saveButton(_ sender: Any) {
        //save
        inserInto(TableName: .Yoga, Value: String(count), Date: getDatetoadd())
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        dismiss(animated: true, completion: nil)
    }
    
}
