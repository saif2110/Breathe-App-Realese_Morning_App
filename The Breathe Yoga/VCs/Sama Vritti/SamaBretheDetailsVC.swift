//
//  SamaBretheDetailsVC.swift
//  The Breathe Yoga
//
//  Created by Saif on 18/09/22.
//

import UIKit

class SamaBretheDetailsVC: UIViewController {

  
  @IBOutlet weak var nextButton: UIButton!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      let generator = UINotificationFeedbackGenerator()
      generator.notificationOccurred(.success)
      
      nextButton.layer.cornerRadius = nextButton.bounds.height/2
      
      updateYogaStates(Type: .sama)
  }
  
  @IBAction func done(_ sender: Any) {
      let nowDouble = NSDate().timeIntervalSince1970
      let mili = Int64(nowDouble*1000)
      
      //inserInto(TableName: .Breathe, Value: String(mili), Date: getDatetoadd())
      
      let generator = UINotificationFeedbackGenerator()
      generator.notificationOccurred(.error)
      dismiss(animated: true, completion: nil)
  }
  
  @IBAction func setReminder(_ sender: Any) {
    let vc = TimePickerVC()
    self.present(vc, animated: true, completion: nil)
  }
  
}
