//
//  RoleTableCell.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/26/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class RoleTableCell: UITableViewCell {
    
    @IBOutlet var roleImage: UIImageView!
    @IBOutlet var roleCategory: UILabel!
    @IBOutlet var roleName: UILabel!
    
    @IBOutlet var bgCardView: UIView!
    @IBOutlet var roleProgress: UIProgressView!
    @IBOutlet var roleMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgCardView.backgroundColor = UIColor.white
        bgCardView.layer.cornerRadius = 3.0
        contentView.backgroundColor = UIColor.gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
