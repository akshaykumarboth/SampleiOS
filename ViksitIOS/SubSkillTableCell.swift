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
    
    var isExpanded: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        expandImg.tintColor = UIColor.blue
    }

   
}
