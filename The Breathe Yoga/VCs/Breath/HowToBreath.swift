//
//  HowToBreath.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 06/06/21.
//

import UIKit

class HowToBreath: UIViewController {
  
  @IBOutlet weak var knowMorelabel: UILabel!
  
    @IBOutlet weak var nextButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        nextButton.layer.cornerRadius = nextButton.bounds.height/2
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  @IBAction func knowMore(_ sender: Any) {
    
    UIApplication.shared.open(URL(string: "https://www.artofliving.org/in-en/yoga/breathing-techniques/skull-shining-breath-kapal-bhati")!)
    
  }
  
}
