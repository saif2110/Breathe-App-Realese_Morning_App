//
//  SelectDeviceVC.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 17/07/21.
//

import UIKit
import DateTimePicker

class SelectDeviceVC: UIViewController,DateTimePickerDelegate {
    
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        if picker.tag == 1 {
            dateText.text = didSelectDate.string(format: "EEEE, MMM d")
            
        }else{
            timeText.text = didSelectDate.string(format: "hh:mm a")
        }
        
        // from EEEE, MMM d hh:mm a
        
        //d MMM,\nh:mm a
    }
    
    
    @IBOutlet weak var readyButton: UIButton!
    
    @IBOutlet weak var customSegmentView: UIView!
    @IBOutlet weak var oxymeter: CustomButton!
    @IBOutlet weak var appleWatch: CustomButton!
    @IBOutlet weak var textFiled: UITextField!
    
    @IBOutlet weak var Spo2TextFiled:UILabel!
    @IBOutlet weak var dateText:UITextField!
    
    @IBOutlet weak var timeText:UILabel!
    
    
    @IBOutlet weak var relaxed: stateButton!
    @IBOutlet weak var work: stateButton!
    @IBOutlet weak var woke: stateButton!
    @IBOutlet weak var sleep: stateButton!
    @IBOutlet weak var streesed: stateButton!
    @IBOutlet weak var active: stateButton!
    @IBOutlet weak var tired: stateButton!
    @IBOutlet weak var hungry: stateButton!
    
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        
        customSegmentView.layer.cornerRadius = customSegmentView.bounds.height/2
        customSegmentView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9490196078, blue: 0.9843137255, alpha: 1)
        
        readyButton.layer.cornerRadius = readyButton.bounds.height/2
        readyButton.alpha = 0.5
        
        oxymeter.select()
        
        textFiled.delegate = self
        textFiled.addTarget(self, action: #selector(rateTextFieldChanged), for: .editingChanged)
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(dateTextMethod))
        dateText.addGestureRecognizer(tap)
        dateText.text = Date().string(format: "EEEE, MMM d")
        dateText.isUserInteractionEnabled = true
        
        
        let tap2 = UITapGestureRecognizer()
        tap2.addTarget(self, action: #selector(timeTextMethod))
        timeText.addGestureRecognizer(tap2)
        timeText.text = Date().string(format: "hh:mm a")
        timeText.isUserInteractionEnabled = true
        
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func SelectButton(_ sender:stateButton){
        deselectAll()
        sender.selectMe()
    }
    
    func deselectAll(){
        relaxed.DeselectMe()
        work.DeselectMe()
        woke.DeselectMe()
        sleep.DeselectMe()
        streesed.DeselectMe()
        active.DeselectMe()
        tired.DeselectMe()
        hungry.DeselectMe()
    }
    
    
    @objc func dateTextMethod(){
        
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 7)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 0)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        picker.delegate = self
        picker.tag = 1
        
        picker.highlightColor = #colorLiteral(red: 0.3176470588, green: 0.5803921569, blue: 0.9529411765, alpha: 1)
        picker.isDatePickerOnly = true
        picker.dateFormat = "EEEE, MMM d"
        
        picker.frame = CGRect(x: 0, y: view.frame.size.height - picker.frame.size.height+20, width: view.frame.size.width, height: picker.frame.size.height)
        
        picker.show()
        
    }
    
    @objc func timeTextMethod(){
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 7)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 1)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        picker.delegate = self
        picker.tag = 2
        
        picker.highlightColor = #colorLiteral(red: 0.3176470588, green: 0.5803921569, blue: 0.9529411765, alpha: 1)
        picker.isTimePickerOnly = true
        picker.dateFormat = "hh:mm a"
        
        picker.frame = CGRect(x: 0, y: view.frame.size.height - picker.frame.size.height, width: view.frame.size.width, height: picker.frame.size.height)
        
        picker.show()
    }
    
    
    @IBAction func selected(_ sender: UIButton) {
        self.oxymeter.DeSelect()
        self.appleWatch.DeSelect()
        
        if sender.tag == 0 {
            oxymeter.select()
            
        }else{
            appleWatch.select()
            
        }
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        if textFiled.text!.count > 2 {
            
            let level = getSpO2New(time: Int(textFiled.text!.replacingOccurrences(of: "%", with: ""))!)
            
            let dateis = dateText.text! + " " + timeText.text!
            
            inserInto(TableName: .Yoga, Value: String(level), Date: convertDateFormatter(date: dateis))
            
            dismiss(animated: true) {
                NotificationCenter.default.post(name: NSNotification.Name("SelectDeviceVCEnded"), object: nil)
            }
            
        }
        
    }
    
}


extension  SelectDeviceVC: UITextFieldDelegate{
    
    
    @objc func rateTextFieldChanged (_ textField : UITextField){
        
        if textField.text == "0%"{
            textField.text = ""
        }
        if textField.text == "0"{
            textField.text = ""
        }
        
        
        let prevTextfiled = textField.text?.replacingOccurrences(of: "%", with: "")
        
        
        if prevTextfiled != "" {
            
            if Int(prevTextfiled!)! <= 100 {
                
                textField.text = ""
                textField.text = prevTextfiled! + "%"
                textField.textColor = #colorLiteral(red: 0.3176470588, green: 0.5803921569, blue: 0.9529411765, alpha: 1)
                Spo2TextFiled.textColor = #colorLiteral(red: 0.3176470588, green: 0.5803921569, blue: 0.9529411765, alpha: 1)
                
            }else{
                
                textField.text?.removeLast()
                view.endEditing(true)
            }
        }
        
        print(textFiled.text!.count)
        readyButton.alpha = textFiled.text!.count < 3 ? 0.5 : 1
        
        //        if textFiled.text!.count < 3 {
        //            readyButton.alpha = 0.5
        //        }else{
        //            readyButton.alpha = 1
        //        }
        
        //readyButton.alpha = 0.5
        
    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) && textField.text!.count > 1  {
            //delete the second to last character
            let text = textField.text!
            let textDouble = text.replacingOccurrences(of: "%", with: "")
            let doubleAdjusted = Double(textDouble)! / 10.0
            
            //pad to three decimal places
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 0
            formatter.minimumFractionDigits = 0
            formatter.roundingMode = .down
            
            let num = NSNumber(value: doubleAdjusted)
            let newText = formatter.string(from: num)!
            textField.text = "\(newText)%"
            
        }
        
        return true
    }
    
}
