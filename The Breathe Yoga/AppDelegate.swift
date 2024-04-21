//
//  AppDelegate.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 03/06/21.
//

import AVFoundation
import StoreKit
import UIKit
import Purchases
import IQKeyboardManagerSwift
import Firebase
import FirebaseCore

let DarkColor = #colorLiteral(red: 0.8497030139, green: 0.3857004344, blue: 0.2624953985, alpha: 1)
let LightColor = #colorLiteral(red: 1, green: 0.8345591559, blue: 0.780843773, alpha: 0.3)

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
    FirebaseApp.configure()
    
    createSQLDataBase()
    
    Purchases.debugLogsEnabled = false
    Purchases.configure(withAPIKey: "appl_NNAiDDAIGSXBkCCddrZIwfgyAii")
    
    UserDefaults.standard.setnumberOftimeAppOpen(value:
                                                  UserDefaults.standard.getnumberOftimeAppOpen()+1)
    
    isSubsActive()
    
    IQKeyboardManager.shared.enable = true
    
    //mockData()
    
    insertYogaState(Localkapal: 0, Localsama: 0, Localanuloma: 0, Localujjayi: 0, LocalanotherOne: 0, LocalanotherTwo: 0)
    
//      updateYogaStates(Type: .kapal)
//      updateYogaStates(Type: .sama)
//      updateYogaStates(Type: .anuloma)
//      updateYogaStates(Type: .ujjayi)
    
    return true
  }
  

  
  func applicationDidBecomeActive(_ application: UIApplication) {
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
    } catch {
      print("AVAudioSessionCategoryPlayback not work")
    }
  }
  
  func isSubsActive(){
    Purchases.shared.purchaserInfo { (purchaserInfo, error) in
      
        if !(purchaserInfo?.entitlements.active.isEmpty)! {
        
        UserDefaults.standard.setisProMember(value: true)
        
      }else{
        
        UserDefaults.standard.setisProMember(value: false)
      }
    }
  }
  
  
  ///MARK - Moke Data Insert
  func mockData(){
    for i in 0...2{
      inserInto(TableName: .Yoga, Value: "4", Date: "3 Jul,\n10:20 PM")
      inserInto(TableName: .HeartRate, Value: "\(i)\nBPM", Date: "3 Jul,\n10:20 PM")
    }
  }
  
}


@IBDesignable extension UIStackView {
  @IBInspectable override var cornerRadius: CGFloat {
    set {
      layer.cornerRadius = newValue
    }
    get {
      return layer.cornerRadius
    }
  }
}


@IBDesignable extension UIButton {
  
  @IBInspectable override var borderWidth: CGFloat {
    set {
      layer.borderWidth = newValue
    }
    get {
      return layer.borderWidth
    }
  }
  
  @IBInspectable override var cornerRadius: CGFloat {
    set {
      layer.cornerRadius = newValue
    }
    get {
      return layer.cornerRadius
    }
  }
  
  @IBInspectable override var borderColor: UIColor? {
    set {
      guard let uiColor = newValue else { return }
      layer.borderColor = uiColor.cgColor
    }
    get {
      guard let color = layer.borderColor else { return nil }
      return UIColor(cgColor: color)
    }
  }
  
  
  @IBInspectable override var isfullCorner: Bool {
    set {
      if newValue {
        layer.cornerRadius = layer.bounds.height/2
      }
    }
    get {
      return layer.cornerRadius == layer.bounds.height/2
    }
  }
  
  
  
}

extension UIView {
  
  @IBInspectable var borderWidth: CGFloat {
    set {
      layer.borderWidth = newValue
    }
    get {
      return layer.borderWidth
    }
  }
  
  @IBInspectable var cornerRadius: CGFloat {
    set {
      layer.cornerRadius = newValue
    }
    get {
      return layer.cornerRadius
    }
  }
  
  @IBInspectable var borderColor: UIColor? {
    set {
      guard let uiColor = newValue else { return }
      layer.borderColor = uiColor.cgColor
    }
    get {
      guard let color = layer.borderColor else { return nil }
      return UIColor(cgColor: color)
    }
  }
  
  
  @IBInspectable var isfullCorner: Bool {
    set {
      if newValue {
        layer.cornerRadius = layer.bounds.height/2
      }
    }
    get {
      return layer.cornerRadius == layer.bounds.height/2
    }
  }
  
}

extension UIView {
  
  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
    if #available(iOS 11.0, *) {
      clipsToBounds = true
      layer.cornerRadius = radius
      layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    } else {
      let path = UIBezierPath(
        roundedRect: bounds,
        byRoundingCorners: corners,
        cornerRadii: CGSize(width: radius, height: radius)
      )
      let mask = CAShapeLayer()
      mask.path = path.cgPath
      layer.mask = mask
    }
  }
  
  @IBInspectable var addshadow: Bool {
      get {
          return layer.shadowOpacity > 0.0
      }
      set {
          if newValue == true {
              self.normalShadow()
          }
      }
  }
  
  func normalShadow(){
      self.layer.shadowColor = UIColor.gray.cgColor
      self.layer.shadowOpacity = 0.3
      self.layer.shadowOffset = CGSize.zero
      self.layer.shadowRadius = 3
      self.layer.cornerRadius = 16
      self.clipsToBounds = false
  }
}




extension UITextView {

  func addHyperLinksToText(originalText: String, hyperLinks: [String: String]) {
    let style = NSMutableParagraphStyle()
    style.alignment = .left
    let attributedOriginalText = NSMutableAttributedString(string: originalText)
    for (hyperLink, urlString) in hyperLinks {
        let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
        let fullRange = NSRange(location: 0, length: attributedOriginalText.length)
        attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
      attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 13), range: fullRange)
    }
    
    self.linkTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.black,
        NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
    ]
    self.attributedText = attributedOriginalText
  }
}





enum exText:String {
  case inhale = "Inhale 🌬️"
  case exhale = "Exhale 💨"
  case hold = "Hold ⌛"
  
}


enum AnulomaexText:String {
  case inhale = "Inhale With Left Nostril Close 🌬️"
  case exhale = "Exhale With Right Nostril Close 💨"
  case hold = "Hold ⌛"
  
}

enum UjjayiText:String {
  case inhale = "Inhale With Both Nostril (Normal) 🌬️"
  case exhale = "Exhale Through Mouth 💨"
  case hold =   "Hold ⌛"
  case halfWay = "Close Your Mouth & Exhale Through Nose 👃🏼"
}
  


extension UIImageView {
  
  func shrink(duration:Float = 5){
    UIView.animate(withDuration: TimeInterval(duration),
        animations: {
            self.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        },
        completion: { _ in
      UIView.animate(withDuration: TimeInterval(duration)) {
                self.transform = CGAffineTransform.identity
            }
        })

  }
  
  
  
  func expand(duration:Float = 5){
    UIView.animate(withDuration: TimeInterval(duration),
        animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        },
        completion: { _ in
            UIView.animate(withDuration: TimeInterval(duration)) {
              self.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            }
        })

  }
  
  func rotate() {
          let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
          rotation.toValue = NSNumber(value: Double.pi * 2)
          rotation.duration = 2
          rotation.isCumulative = true
          rotation.repeatCount = Float.greatestFiniteMagnitude
          self.layer.add(rotation, forKey: "rotationAnimation")
      }
  
}


func getDate() -> String{
  let date = Date()
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "dd-MMM-yyyy"
  dateFormatter.timeZone = .current
  let localDate = dateFormatter.string(from: date)
  return localDate
}


func rateApp() {
    if #available(iOS 10.3, *) {
        SKStoreReviewController.requestReview()

    } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)

        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
