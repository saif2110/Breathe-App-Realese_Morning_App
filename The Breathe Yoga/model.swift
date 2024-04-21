//
//  model.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 06/06/21.
//

import Foundation
import UIKit
import AVFoundation
import StoreKit
import PDFKit
import PDFGenerator

var player: AVAudioPlayer?
var player2: AVAudioPlayer?

func playSound(name:String) {
    guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        
        /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
        /* iOS 10 and earlier require the following line:
         player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
        
        guard let player = player else { return }
        
        player.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}

func stopSound(){
    player?.stop()
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

func getDatetoadd() -> String{
    return Date().string(format: "d MMM,\nh:mm a")
}


func getSpO2(time:Int) -> String {
    let count = 28 - time
    
    if count >= 25 && count <= 29 {
        
        return "≈95%-99%"
    }else if count >= 20 && count < 25 {
        
        return "≈92%-95%"
    }else if count >= 18 && count < 20 {
        
        return "≈90%-92%"
    }else if count >= 15 && count < 18 {
        
        return "≈85%-90%"
    }else if count >= 10 && count < 15 {
        
        return "≈82%-85%"
    }else if count >= 5 && count < 10 {
        
        return "≈80%-82%"
    }else{
        
        return "≈65%-75%"
    }
}

func getSpO2New(time:Int) -> Int {
    let count = time
    
    if count >= 95 && count <= 100 {
        
        return 1
    }else if count >= 92 && count < 95 {
        
        return 5
    }else if count >= 90 && count < 93 {
        
        return 9
    }else if count >= 85 && count < 90 {
        
        return 11
    }else if count >= 80 && count < 85 {
        
        return 13
    }else if count >= 75 && count < 80 {
        
        return 18
    }else if count >= 70 && count < 75 {
        
        return 22
    }else if count >= 65 && count < 70 {
        
        return 26
    }else if count >= 60 && count < 65 {
        
        return 27
    }else{
        
        return 28
    }
    
}


func convertDateFormatter(date: String) -> String {
    //    let dateFormatter = DateFormatter()
    //    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    //    dateFormatter.dateFormat = "EEEE, MMM d hh:mm a"//this your string date format
    //
    //    let enUSPOSIXLocale:Locale = Locale(identifier: "en_US_POSIX")
    //    dateFormatter.locale = enUSPOSIXLocale
    //    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    //
    //    let convertedDate = dateFormatter.date(from: date)
    //
    //    guard dateFormatter.date(from: date) != nil else {
    //        assert(false, "no date from string")
    //        return ""
    //
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d hh:mm a"
        let date = dateFormatter.date(from: date)
        return (date?.string(format: "d MMM,\nh:mm a"))!
    }


extension UIView {
    
    func shadow()  {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 25
    }
    
    func shadow2()  {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
    }
    
    func shadow3()  {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
    }
    
}

extension UITabBarController {
    
    func tabbar(){
        let selfHeight = self.view.bounds.height/10
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundColor = .white
        self.tabBar.barStyle = .default
        self.tabBar.layer.cornerRadius = 35
        self.tabBar.frame.size.height = selfHeight
        self.tabBar.frame.origin.y = view.frame.height - selfHeight
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabShadow()
    }
    
    private func tabShadow()  {
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOpacity = 0.5
        self.tabBar.layer.shadowOffset = CGSize.zero
        self.tabBar.layer.shadowRadius = 35
    }
    
}

extension UIButton {
    
    func buttonShadow(){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 25
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
    }
  
  func buttonShadowforPremium(){
      self.layer.shadowColor = UIColor.lightGray.cgColor
      self.layer.shadowOpacity = 0.3
      self.layer.shadowOffset = CGSize.zero
      self.layer.shadowRadius = 10
      self.layer.cornerRadius = 10
      self.clipsToBounds = true
  }
    
}


func myAlt(titel:String,message:String)-> UIAlertController{
    let alert = UIAlertController(title: titel, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                    switch action.style{
                                    case .default:
                                        print("")
                                    case .cancel:
                                        print("")
                                    case .destructive:
                                        print("")
                                    @unknown default:
                                        fatalError()
                                    }}))
    
    return alert
    
}


var indicator = UIActivityIndicatorView()

func startIndicator(selfo:UIViewController) {
    indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    indicator.color = #colorLiteral(red: 0.3166302741, green: 0.5789432526, blue: 0.9529353976, alpha: 1)
    indicator.frame = selfo.view.frame
    indicator.center = selfo.view.center
    selfo.view.addSubview(indicator)
    selfo.view.bringSubviewToFront(indicator)
    indicator.startAnimating()
}

func stopIndicator() {
    indicator.stopAnimating()
}


func requestToRate() {
    if #available(iOS 14.0, *) {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    } else if #available(iOS 10.3, *) {
        SKStoreReviewController.requestReview()
    }
}

extension UITableView {
    
    func exportAsPdfFromTable() -> URL {
        let priorBounds = self.bounds
        setBoundsForAllItems()
        self.layoutIfNeeded()
        let pdfData = createPDF()
        self.bounds = priorBounds
        return saveTablePdf(data: pdfData)
        //return pdfData.copy() as? Data
    }
    
    private func getContentFrame() -> CGRect {
        return CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)
    }
    
    private func createPDF() -> NSMutableData {
        
        UIGraphicsBeginImageContextWithOptions(self.contentSize, false, 0)
        
        self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let priorBounds: CGRect = self.bounds
        let fittedSize: CGSize = self.sizeThatFits(CGSize(width: priorBounds.size.width, height: self.contentSize.height))
        
        let pdfPageBounds: CGRect = CGRect(x: 0, y: 0, width: fittedSize.width, height: (fittedSize.height))
        let pdfData: NSMutableData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
        
        // 2. calculate number of part of tableview, loop and get snapshot
        let iterationCount = Int(ceil(self.contentSize.height / self.bounds.size.height))
        
        for i in 0..<iterationCount {
            self.setContentOffset(CGPoint(x: 0, y: Int(self.bounds.size.height) * i), animated: false)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
        }
        
        UIGraphicsEndPDFContext()
        
        
        let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let documentsFileName = documentDirectories! + "/" + "MyPDF.pdf"
        pdfData.write(toFile: documentsFileName, atomically: true)
        
        return pdfData
    }
    
    private func setBoundsForAllItems() {
        if self.isEndOfTheScroll() {
            self.bounds = getContentFrame()
        } else {
            self.bounds = getContentFrame()
            self.reloadData()
        }
    }
    
    private func isEndOfTheScroll() -> Bool  {
        let contentYoffset = contentOffset.y
        let distanceFromBottom = contentSize.height - contentYoffset
        return distanceFromBottom < frame.size.height
    }
    
    // Save pdf file in document directory
    private func saveTablePdf(data: NSMutableData) -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectoryPath = paths[0]
        let pdfPath = docDirectoryPath.appendingPathComponent("DataLogs2.pdf")
        if data.write(to: pdfPath, atomically: true) {
            return pdfPath
        }else{
            return URL(string: "Null URL")!
        }
    }
}


//chnage emoji to image
extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 35, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func imageState() -> UIImage? {
        let size = CGSize(width: 25, height: 25)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 20)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
