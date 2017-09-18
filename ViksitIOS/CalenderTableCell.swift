//
//  CalenderTableCell.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/31/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class CalenderTableCell: UITableViewCell {
    
    @IBOutlet var blueBtn: CircularButton!

    @IBOutlet var eventMonthLabel: UILabel!
    @IBOutlet var eventDateLabel: UILabel!
    @IBOutlet var evenDot: CircularButton!
    @IBOutlet var eventDurationLabel: UILabel!
    
    @IBOutlet var eventName: UILabel!
    @IBOutlet var eventBottomLine: UIView!
    @IBOutlet var eventCardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        eventCardView.layer.cornerRadius = 3.0
        blueBtn.layer.borderWidth = 3
        blueBtn.layer.borderColor = UIColor(red:0.96, green:0.96, blue:0.98, alpha:1.0).cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
