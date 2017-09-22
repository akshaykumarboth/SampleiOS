//
//  QuesOptionCell.swift
//
//
//  Created by Akshay Kumar Both on 9/2/17.
//  Copyright © 2017 Akshay Kumar Both. All rights reserved.
//

import UIKit

class QuesOptionCell: UICollectionViewCell {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var quesView: UITextView!
    @IBOutlet var optionStack: UIStackView!
    @IBOutlet var quesNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
                // Initialization code
    }
}


