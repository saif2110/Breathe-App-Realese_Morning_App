//
//  imageView.swift
//  Blood Oxygen Level App
//
//  Created by Junaid Mukadam on 18/06/21.
//

import UIKit

class imageViewCell: UITableViewCell {

    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var labelView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
     
        self.myImageView.layer.masksToBounds = true
        self.myImageView.layer.cornerRadius = 30
        self.myImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.labelView.layer.masksToBounds = true
        self.labelView.layer.cornerRadius = 30
        self.labelView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
