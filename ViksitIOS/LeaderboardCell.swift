//
//  DummyCell.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/4/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class LeaderboardCell: UITableViewCell {
    
    @IBOutlet var studentImage: UIImageView!
    @IBOutlet var studentName: UILabel!
    @IBOutlet var studentRank: UILabel!
    @IBOutlet var studentXP: UILabel!
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
