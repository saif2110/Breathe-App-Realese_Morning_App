//
//  BreatheDetailsVC.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 08/06/21.
//

import UIKit

class BreatheDetailsVC: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var bg: UIImageView!
    var imageforBG:UIImage = #imageLiteral(resourceName: "spo2BG")
    var yogaType:yogaType = .kapal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bg.image = imageforBG
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        nextButton.layer.cornerRadius = nextButton.bounds.height/2
        
        updateYogaStates(Type:yogaType)
        
        rateApp()
        
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
