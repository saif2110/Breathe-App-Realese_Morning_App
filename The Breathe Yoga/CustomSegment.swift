//
//  CustomSegment.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 13/06/21.
//

import UIKit

class CustomButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.height/2
    }
    
    func select(){
        self.backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.5803921569, blue: 0.9529411765, alpha: 1)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.textColor = .white
    }
    
    func DeSelect(){
        self.backgroundColor = #colorLiteral(red: 0.9349441528, green: 0.9506772161, blue: 0.9825778604, alpha: 1)
        self.setTitleColor(#colorLiteral(red: 0.0762623623, green: 0.1070805863, blue: 0.1393731833, alpha: 1), for: .normal)
        self.titleLabel?.textColor = #colorLiteral(red: 0.0762623623, green: 0.1070805863, blue: 0.1393731833, alpha: 1)
    }

}
