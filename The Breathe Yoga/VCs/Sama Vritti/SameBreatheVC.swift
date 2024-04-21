//
//  BreathVC.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 07/06/21.
//


import UIKit
import MBCircularProgressBar

class SameBreatheVC: UIViewController {
  
  @IBOutlet weak var countDown: UIButton!
  
  @IBOutlet weak var animationImage: UIImageView!
  
  @IBOutlet weak var progressBar: MBCircularProgressBarView!
  @IBOutlet weak var mainLabel: UILabel!
  @IBOutlet weak var bottomLabel: UILabel!
  @IBOutlet weak var nextButton: UIButton!
  
  var mytimer:Timer?
  var count = 10 //Number of inhale and exhale
  
  let totalDuretionforInhale = 4
  let totalDuretionforExcel = 4
  
  
  
  func CLOSEMessage() -> NSAttributedString {
    let attrString = NSMutableAttributedString(string: "CLOSE YOUR",
                                               attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]);
    
    attrString.append(NSMutableAttributedString(string: "\nEYES",
                                                attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)]))
    return attrString
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    nextButton.layer.cornerRadius = nextButton.bounds.height/2
    
    self.mytimer = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    self.animationImage.rotate()
  }
  
  
  override func viewDidDisappear(_ animated: Bool) {
    mytimer?.invalidate()
    mytimer = nil
  }
  
  @objc func update() {
    
    countDown.setTitle(String(count), for: .normal)
    
    
    if(count > 0) {
      
      self.breateIN()
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        self.breateHold(msg: .hold)
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
        self.breateOUT()
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 14.5) {
        self.breateHold(msg: .hold)
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
          vc.imageforBG = #imageLiteral(resourceName: "sama_BG")
          vc.yogaType = .sama
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
    self.mainLabel.text = exText.inhale.rawValue
    self.animationImage.expand(duration: 4)
    UIView.animate(withDuration: 4) {
      
      self.progressBar.value = 40
      
    } completion: { Bool in
      let generator = UINotificationFeedbackGenerator()
      generator.notificationOccurred(.success)
      
      self.mainLabel.text = exText.hold.rawValue
    }
  }
  
  
  func breateOUT() {
    stopSound()
    playSound(name: "exhale")
    self.mainLabel.text = exText.exhale.rawValue
    self.animationImage.shrink(duration: 4)
    UIView.animate(withDuration: 4) {
      
      self.progressBar.value = 0
      
    } completion: { Bool in
      let generator = UINotificationFeedbackGenerator()
      generator.notificationOccurred(.success)
      
      self.mainLabel.text = exText.hold.rawValue
      
    }
  }
  
  
  func breateHold(msg:exText) {
    stopSound()
    playSound(name: "hold")
    self.mainLabel.text = msg.rawValue
  }
  
  
}
