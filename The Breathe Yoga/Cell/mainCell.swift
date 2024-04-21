//
//  mainCell.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 03/06/21.
//

import UIKit

class mainCell: UITableViewCell {
    
    @IBOutlet weak var deleteBut: UIButton!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var value: UIButton!
    
    var localid:String?
    var type:TableName?
  
   var FechedYoga:FechedDataYoga? {
     
     didSet{
         
         deleteBut.addTarget(self, action: #selector(deleteButMethod), for: .touchUpInside)
         value.isUserInteractionEnabled = false
         
         if type == .HeartRate {
             
             value.setImage(#imageLiteral(resourceName: "heart_list"), for: .normal)
             date.text = Feched?.date?.asSQL().replacingOccurrences(of: "'", with: "")
             let titel = Feched?.value?.asSQL().replacingOccurrences(of: "'", with: "").replacingOccurrences(of: "\n", with: " ")
             value.setTitle( "  " + titel!, for: .normal)
             localid = Feched?.id?.asSQL().replacingOccurrences(of: "'", with: "")
             
         }else{
             
             date.text = Feched?.date?.asSQL().replacingOccurrences(of: "'", with: "")
             let titel = Feched?.value?.asSQL().replacingOccurrences(of: "'", with: "").replacingOccurrences(of: "\n", with: " ")
             value.setTitle( "  " + getSpO2(time: Int(titel ?? "28")!), for: .normal)
             value.setImage(#imageLiteral(resourceName: "spo2_list"), for: .normal)
             localid = Feched?.id?.asSQL().replacingOccurrences(of: "'", with: "")
             
         }
         
         
         
     }
 }
  
  
  var Feched:FechedData? {
        
        didSet{
            
            deleteBut.addTarget(self, action: #selector(deleteButMethod), for: .touchUpInside)
            value.isUserInteractionEnabled = false
            
            if type == .HeartRate {
                
                value.setImage(#imageLiteral(resourceName: "heart_list"), for: .normal)
                date.text = Feched?.date?.asSQL().replacingOccurrences(of: "'", with: "")
                let titel = Feched?.value?.asSQL().replacingOccurrences(of: "'", with: "").replacingOccurrences(of: "\n", with: " ")
                value.setTitle( "  " + titel!, for: .normal)
                localid = Feched?.id?.asSQL().replacingOccurrences(of: "'", with: "")
                
            }else{
                
                date.text = Feched?.date?.asSQL().replacingOccurrences(of: "'", with: "")
                let titel = Feched?.value?.asSQL().replacingOccurrences(of: "'", with: "").replacingOccurrences(of: "\n", with: " ")
                value.setTitle( "  " + getSpO2(time: Int(titel ?? "28")!), for: .normal)
                value.setImage(#imageLiteral(resourceName: "spo2_list"), for: .normal)
                localid = Feched?.id?.asSQL().replacingOccurrences(of: "'", with: "")
                
            }
            
            
            
        }
    }
    
    @objc func deleteButMethod(){
        deleteData(TableName: type!, id: localid!)
        
        NotificationCenter.default.post(name: NSNotification.Name("refresh"), object: nil)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deleteBut.clipsToBounds = true
        deleteBut.layer.borderColor = UIColor.lightGray.cgColor
        deleteBut.tintColor = UIColor.lightGray
        deleteBut.layer.borderWidth = 0.5
        deleteBut.layer.cornerRadius = deleteBut.bounds.height/2
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}



