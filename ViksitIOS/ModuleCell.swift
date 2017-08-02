//
//  ModuleCell.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/2/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ModuleCell: UITableViewCell {
    
    @IBOutlet var moduleNameLabel: UILabel!
    @IBOutlet var moduleImage: UIImageView!
    @IBOutlet var bgCardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgCardView.backgroundColor = UIColor.white
        bgCardView.layer.cornerRadius = 3.0

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
