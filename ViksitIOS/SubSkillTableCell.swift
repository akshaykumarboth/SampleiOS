//
//  SubSkillTableCell.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/9/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class SubSkillTableCell: UITableViewCell {
    
    @IBOutlet var subSkillName: UILabel!
    @IBOutlet var subSkillProgress: UIProgressView!
    @IBOutlet var expandImg: UIImageView!
    @IBOutlet var grandSkillStack: UIStackView!
    
    @IBOutlet var subSkillDetail: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        expandImg.tintColor = UIColor(colorLiteralRed: 235/255, green: 56/255, blue: 79/255, alpha: 1.0)
        selectionStyle = .none
    }

   
}
