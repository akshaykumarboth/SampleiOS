//
//  NotificationTableCell.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/26/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class NotificationTableCell: UITableViewCell {
    
    @IBOutlet var notificationImage: UIImageView!
    
    @IBOutlet var notificationMessage: UILabel!
    
    @IBOutlet var notificationDuration: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //making the image circular
        self.notificationImage.layer.cornerRadius = self.notificationImage.frame.size.width / 2
        self.notificationImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
