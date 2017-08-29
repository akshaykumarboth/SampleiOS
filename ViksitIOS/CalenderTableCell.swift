//
//  CalenderTableCell.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/31/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class CalenderTableCell: UITableViewCell {

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
        //eventNameView.scrollView.isScrollEnabled = false
        //eventNameView.scrollView.bounces = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
