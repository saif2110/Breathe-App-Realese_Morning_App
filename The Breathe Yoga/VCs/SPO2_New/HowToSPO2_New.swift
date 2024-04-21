//
//  HowToSPO2_New.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 17/07/21.
//

import UIKit

class HowToSPO2_New: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        
        nextButton.layer.cornerRadius = nextButton.bounds.height/2
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(SelectDeviceVCEnded),
                                               name: NSNotification.Name("SelectDeviceVCEnded"),
                                               object: nil)
    }
    
    
    @objc func SelectDeviceVCEnded() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
