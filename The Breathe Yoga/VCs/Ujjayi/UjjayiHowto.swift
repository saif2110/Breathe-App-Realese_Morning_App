//
//  UjjayiHowto.swift
//  The Breathe Yoga
//
//  Created by Saif on 02/10/22.
//

import UIKit

class UjjayiHowto: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.scrollView.scrollToBottom()
    self.loadViewIfNeeded()
    
  }
  
  
  @IBAction func next(_ sender: Any) {
    
    dismiss(animated: false) {
      let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
      
      if var topController = keyWindow?.rootViewController {
        while let presentedViewController = topController.presentedViewController {
          topController = presentedViewController
        }
        
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "UjjayiBreatheVC") as! UjjayiBreatheVC
        vc.modalPresentationStyle = .overFullScreen
        topController.present(vc, animated: false, completion: nil)
        
      }
    }
  }
  
  
}

