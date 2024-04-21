//
//  TimePickerVC.swift
//  The Breathe Yoga
//
//  Created by Saif on 04/09/22.
//

import UIKit

class TimePickerVC: UIViewController {
 
  @IBOutlet weak var timePicker: UIDatePicker!
  var hr = 08
  var minut = 00
  
  @IBAction func setReminder(_ sender: Any) {
    localNotification(hour: hr, minut: minut)
  }
  
  @IBAction func close(_ sender: Any) {
    self.dismiss(animated: true)
  }
  
  @IBOutlet weak var mainView: UIView! {
    didSet{
       mainView.roundCorners([.topLeft,.topRight], radius: 18)
    }
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      let center = UNUserNotificationCenter.current()
      center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
          // Enable or disable features based on authorization.
          if error == nil {
             
          }
      }
      
      timePicker.addTarget(self, action: #selector(getTime(sender:)), for: .valueChanged)
        // Do any additional setup after loading the view.
    }
  
  @objc func getTime(sender: UIDatePicker) {
      self.getDate(date: sender.date)
  }

  func getDate(date: Date) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    let twentyFourHour = dateFormatter.string(from: date)
    print(twentyFourHour)
    
    hr = Int(twentyFourHour.split(separator: ":", maxSplits: 1, omittingEmptySubsequences: true).first ?? "08") ?? 08
    
    minut = Int(twentyFourHour.split(separator: ":", maxSplits: 1, omittingEmptySubsequences: true).last ?? "00") ?? 00
    
  
  }
  

  func localNotification(hour:Int,minut:Int){
    let notificationContent = UNMutableNotificationContent()
    notificationContent.title = "Hi, It's a time to do some Yoga 🧘"
    notificationContent.body = "It's time to roll out your yoga mat and relax your physical and mental health."
    notificationContent.badge = NSNumber(value: 1)
    notificationContent.sound = .default
                    
    var datComp = DateComponents()
    datComp.hour = hour
    datComp.minute = minut
    let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
    let request = UNNotificationRequest(identifier: "ID", content: notificationContent, trigger: trigger)
                    UNUserNotificationCenter.current().add(request) { (error : Error?) in
                    
                      DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Reminder has been set ⏰", message: "Note - Your old reminder replaced, if you have already set one.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                                        switch action.style{
                                                        case .default:
                                                            print("")
                                                          self.dismiss(animated: true)
                                                        case .cancel:
                                                            print("")
                                                        case .destructive:
                                                            print("")
                                                        @unknown default:
                                                            fatalError()
                                                        }}))
                        self.present(alert, animated: true, completion: nil)
                      }
                      
                        if let theError = error {
                            print(theError.localizedDescription)
                        }
                    }
  }

}
