//
//  howToMeasure.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 04/06/21.
//

import UIKit

class howToMeasure: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        nextButton.layer.cornerRadius = nextButton.bounds.height/2
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(readyforSPO2),
                                               name: NSNotification.Name("readyforSPO2"),
                                               object: nil)
    }
  @IBAction func openProof(_ sender: Any) {
    
    UIApplication.shared.open(URL(string: "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6834218/")!)
  }
  
    
    @objc func readyforSPO2() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cross(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
