//
//  AnulomaBreatheDetails.swift
//  The Breathe Yoga
//
//  Created by Saif on 02/10/22.
//

import UIKit
import MBCircularProgressBar

class AnulomaBreatheVC: UIViewController {
    @IBOutlet weak var countDown: UIButton!
    
    @IBOutlet weak var animationImage: UIImageView!
    
    @IBOutlet weak var progressBar: MBCircularProgressBarView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var mytimer:Timer?
    var count = 10 //Number of inhale and exhale
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = nextButton.bounds.height/2
        
        self.mytimer = Timer.scheduledTimer(timeInterval: 11.5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
        
        
        self.animationImage.rotate()
        
        rateApp()
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        mytimer?.invalidate()
        mytimer = nil
    }
    
    @objc func update() {
        
        countDown.setTitle(String(count), for: .normal)
        
        
        if(count > 0) {
            
            self.breateIN()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                self.breateOUT()
            }
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
                    let vc = story.instantiateViewController(withIdentifier: "BreatheDetailsVC") as! BreatheDetailsVC
                    vc.modalPresentationStyle = .overFullScreen
                    vc.yogaType = .anuloma
                    topController.present(vc, animated: false, completion: nil)
                    
                }
            }
            
        }
        
    }
    
    
    @IBAction func done(_ sender: Any) {
        mytimer?.invalidate()
        mytimer = nil
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func breateIN() {
        stopSound()
        playSound(name: "inhale")
        self.animationImage.expand(duration: 4)
        UIView.animate(withDuration: 4) {
            
            self.progressBar.value = 40
            
        } completion: { Bool in
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            self.mainLabel.text = AnulomaexText.exhale.rawValue
        }
    }
    
    
    func breateOUT() {
        stopSound()
        playSound(name: "exhale")
        self.animationImage.shrink(duration: 4)
        UIView.animate(withDuration: 4) {
            
            self.progressBar.value = 0
            
        } completion: { Bool in
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            self.mainLabel.text = AnulomaexText.inhale.rawValue
        }
    }
    
    
    
    
}
