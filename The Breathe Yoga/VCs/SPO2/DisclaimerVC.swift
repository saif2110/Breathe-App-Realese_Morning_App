//
//  DisclaimerVC.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 05/06/21.
//

import UIKit

class DisclaimerVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var myView: UITableView!
    
    @IBOutlet weak var readyButton: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emojiArray.count
    }
    
    let emojiArray = ["🚭","🏃","🌬","😫","🩺","🫀","🫁","⛹️‍♀️"]
    
    let emojiName = ["shouldn't have smoked or drank today","haven't done jogging in the past 1 hr","shouldn't have asthma","shouldn't have feeling any kind of stress","shouldn't have chronic diseases","shouldn't have any heart condition","shouldn't have any lungs condition","shouldn't have played any outdoor game in the past 1 hr"]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.clipsToBounds = true
        cell.textLabel?.minimumScaleFactor = 0.5
        cell.textLabel?.numberOfLines = 0
        cell.imageView?.image = emojiArray[indexPath.row].image()
        cell.textLabel?.text = emojiName[indexPath.row]
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        
        readyButton.layer.cornerRadius = readyButton.bounds.height/2
        
        myView.delegate = self
        myView.dataSource = self
        myView.reloadData()
    }
    
    @IBAction func readyAction(_ sender: Any) {
        dismiss(animated: false) {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            
            if var topController = keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                
                let story = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = story.instantiateViewController(withIdentifier: "BearthSPO2") as! BearthSPO2
                vc.modalPresentationStyle = .overFullScreen
                topController.present(vc, animated: false, completion: nil)
                
        }
    }
  }
}
