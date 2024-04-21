//
//  Welcome.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 20/06/21.
//

import UIKit

class Welcome: UIViewController {
    
    @IBOutlet weak var continueBut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        continueBut.clipsToBounds = true
        continueBut.layer.cornerRadius = continueBut.bounds.height/2
    }
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true) {
            DispatchQueue.main.async {
              
                if let topController =
                    UIApplication.topViewController() {
                    let vc  = InAppPurchases()
                    vc.modalPresentationStyle = .fullScreen
                    topController.present(vc, animated: true, completion: nil)
                }
                
            }
        }
    }
    
}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
