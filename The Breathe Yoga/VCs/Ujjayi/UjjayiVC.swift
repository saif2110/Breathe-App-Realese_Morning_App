//
//  UjjayiVC.swift
//  The Breathe Yoga
//
//  Created by Saif on 02/10/22.
//

import UIKit

class UjjayiVC: UIViewController {

  @IBOutlet weak var knowMorelabel: UILabel!
  
    @IBOutlet weak var nextButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        nextButton.layer.cornerRadius = nextButton.bounds.height/2
        GoogleAdsClass.shared.presentAds()
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  @IBAction func knowMore(_ sender: Any) {
    
    UIApplication.shared.open(URL(string: "https://theyogainstitute.org/ujjayi-pranayama/")!)
    
  }
}
