//
//  HowToSpo2.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 05/06/21.
//

import UIKit

class HowToSpo2: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        
        nextButton.layer.cornerRadius = nextButton.bounds.height/2
    }
    

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
