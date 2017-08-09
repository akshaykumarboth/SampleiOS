//
//  SubSkillTableCell.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/9/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class SubSkillTableCell: UITableViewCell {
    
    @IBOutlet var expandableImg: UIImageView!
    @IBOutlet var subSkillName: UILabel!
    @IBOutlet var subSkillProgress: UIProgressView!
    @IBOutlet var subSkillDetail: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
