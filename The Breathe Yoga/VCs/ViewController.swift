//
//  ViewController.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 03/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var height3: NSLayoutConstraint!
    @IBOutlet weak var height2: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackView2: UIStackView!
    
    @IBOutlet weak var tryPremium: UIButton!{
        didSet{
            tryPremium.buttonShadowforPremium()
        }
    }
    
    @IBOutlet weak var create: UIButton!{
        didSet{
            create.clipsToBounds = true
            create.layer.cornerRadius = create.bounds.height/2
        }
    }
    
    @IBAction func createAction(_ sender: Any) {
        let vc = TimePickerVC()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    @IBOutlet weak var createReminder: UIView!{
        didSet{
            createReminder.clipsToBounds = true
            createReminder.layer.cornerRadius = 20
            createReminder.layer.borderWidth = 1.1
            createReminder.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    
    @IBOutlet weak var but1: UIButton!{
        didSet{
            but1.buttonShadow()
        }
    }
    
    @IBOutlet weak var but2: UIButton!{
        didSet{
            but2.buttonShadow()
        }
    }
    
    @IBOutlet weak var but3: UIButton!{
        didSet{
            but3.buttonShadow()
        }
    }
    
    @IBOutlet weak var but4: UIButton!{
        didSet{
            but4.buttonShadow()
        }
    }
    
    @IBOutlet weak var but5: UIButton!{
        didSet{
            but5.buttonShadow()
        }
    }
    
    @IBOutlet weak var but6: UIButton!{
        didSet{
            but6.buttonShadow()
        }
    }
    
    
    
    @IBAction func upgrade(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let vc  = InAppPurchases()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewWillLayoutSubviews() {
        self.height.constant = (self.but1.bounds.width)-18
        self.height2.constant = (self.but3.bounds.width)-18
        self.height3.constant = (self.but5.bounds.width)-18
        self.tabBarController?.tabbar()
        self.view.layoutIfNeeded()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.getnumberOftimeAppOpen() == 1 {
            DispatchQueue.main.async {
                let vc = Welcome()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            }
        }else{
            if !UserDefaults.standard.isProMember() {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    let vc  = InAppPurchases()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
        
        
    }
    
    @IBAction func showAnuloma(_ sender: Any) {
//        if UserDefaults.standard.isProMember() {
//
            let Main = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = Main.instantiateViewController(identifier: "AnulomaVC") as! AnulomaVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
//
//        }else{
            
//            let vc = InAppPurchases()
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true)
            
        //}
        
    }
    
    @IBAction func showUjjayi(_ sender: Any) {
        if UserDefaults.standard.isProMember() {
            
            let Main = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = Main.instantiateViewController(identifier: "UjjayiVC") as! UjjayiVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }else{
            
            
            let vc = InAppPurchases()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }
        
    }
    
    @IBAction func heartBeatshow(_ sender: Any) {
        if UserDefaults.standard.isProMember() {
            
            let Main = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = Main.instantiateViewController(identifier: "howToMeasure") as! howToMeasure
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }else{
            
            
            let vc = InAppPurchases()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tryPremium.isHidden = UserDefaults.standard.isProMember()
        
//        `let but3Image = UserDefaults.standard.isProMember() ? #imageLiteral(resourceName: "anuloma") :  #imageLiteral(resourceName: "anuloma_pro.png")
//        but3.setImage(but3Image, for: .normal)`
        
        
        let but4Image = UserDefaults.standard.isProMember() ? #imageLiteral(resourceName: "ujjayi") :  #imageLiteral(resourceName: "ujjayi_pro")
        but4.setImage(but4Image, for: .normal)
        
        let but5Image = UserDefaults.standard.isProMember() ? #imageLiteral(resourceName: "beat") :  #imageLiteral(resourceName: "beat_pro")
        but5.setImage(but5Image, for: .normal)
        
    }
    
}
