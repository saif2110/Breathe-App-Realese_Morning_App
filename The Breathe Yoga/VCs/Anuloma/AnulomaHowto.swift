//
//  AnulomaHowto.swift
//  The Breathe Yoga
//
//  Created by Saif on 02/10/22.
//

import UIKit

class AnulomaHowto: UIViewController {
  
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
        let vc = story.instantiateViewController(withIdentifier: "AnulomaBreatheVC") as! AnulomaBreatheVC
        vc.modalPresentationStyle = .overFullScreen
        topController.present(vc, animated: false, completion: nil)
        
      }
    }
  }
  
  
}

extension UIScrollView {
  
  func scrollToBottom() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: {
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height + self.contentInset.bottom)
        self.setContentOffset(bottomOffset, animated: true)
        
      })
  }
  
}
