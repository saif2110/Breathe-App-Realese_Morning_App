//
//  AnulomaVC.swift
//  The Breathe Yoga
//
//  Created by Saif on 18/09/22.
//

import UIKit

class AnulomaVC: UIViewController {

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
    
    UIApplication.shared.open(URL(string: "https://www.arhantayoga.org/anulom-vilom/")!)
    
  }
}
