//
//  BearthSPO2.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 05/06/21.
//


import UIKit
import MBCircularProgressBar

class BearthSPO2: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var MBProgress: MBCircularProgressBarView!
    
    var count = 28
    var mytimer:Timer?
    
    override func viewDidAppear(_ animated: Bool) {
        
        playSound(name: "inhale")
        
        UIView.animate(withDuration: 2.5) {
            
            self.MBProgress.value = CGFloat(self.count)
            
        } completion: { Bool in
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            self.mainLabel.attributedText = self.HOLDMessage()
            self.mytimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        mytimer?.invalidate()
        mytimer = nil
    }
    
    @objc func update() {
        
        if count < 15 {
            message.text = "Good Job. If possible keep holding or press below button & exhale 😮‍💨."
        }
        
        if(count > 0) {
            
            MBProgress.value = CGFloat(count - 1)
            count -= 1
            
        }else{
            mytimer?.invalidate()
            mytimer = nil
            
            dismiss(animated: false) {
                let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                
                if var topController = keyWindow?.rootViewController {
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                    }
                    
                    let story = UIStoryboard.init(name: "Main", bundle: nil)
                    let vc = story.instantiateViewController(withIdentifier: "Spo2DeatilsVC") as! Spo2DeatilsVC
                    vc.modalPresentationStyle = .overFullScreen
                    vc.count = self.count
                    topController.present(vc, animated: false, completion: nil)
                    
                }
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = nextButton.bounds.height/2
    }
    
    @IBAction func cantHold(_ sender: Any) {
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        
        mytimer?.invalidate()
        mytimer = nil
        dismiss(animated: false) {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            
            if var topController = keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                
                let story = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = story.instantiateViewController(withIdentifier: "Spo2DeatilsVC") as! Spo2DeatilsVC
                vc.modalPresentationStyle = .overFullScreen
                vc.count = self.count
                topController.present(vc, animated: false, completion: nil)
                
            }
        }
    }
    
    
    
    func HOLDMessage() -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: "HOLD",
                                                   attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40)]);
        
        attrString.append(NSMutableAttributedString(string: "\nBREATH",
                                                    attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)]))
        return attrString
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
