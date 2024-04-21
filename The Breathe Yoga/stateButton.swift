//
//  stateButton.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 20/07/21.
//

import UIKit

@IBDesignable
class stateButton: UIButton {
    
    @IBInspectable
    var emojiimage:String = "🙂"
    {
        didSet{
            self.imageView?.layer.cornerRadius = (self.imageView?.layer.bounds.height)!/2
            self.setTitleColor(#colorLiteral(red: 0.1293964982, green: 0.1294215322, blue: 0.1293910444, alpha: 1), for: .normal)
            self.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9490196078, blue: 0.9843137255, alpha: 1)
            self.setImage(emojiimage.imageState(), for: .normal)
            self.setTitle(self.currentTitle! + "  ", for: .normal)
            self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.height/2
    }
    
    func selectMe(){
        self.setTitleColor(#colorLiteral(red: 0.9058823529, green: 0.9176470588, blue: 0.937254902, alpha: 1), for: .normal)
        self.backgroundColor = #colorLiteral(red: 0.3802725375, green: 0.5103173256, blue: 0.9063069224, alpha: 1)
    }
    
    func DeselectMe(){
        self.setTitleColor(#colorLiteral(red: 0.1293964982, green: 0.1294215322, blue: 0.1293910444, alpha: 1), for: .normal)
        self.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9490196078, blue: 0.9843137255, alpha: 1)
    }
    
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)) ?? .zero
        let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right + (self.imageView?.bounds.width)! + 10, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom + 20)
        
        return desiredButtonSize
    }
}
