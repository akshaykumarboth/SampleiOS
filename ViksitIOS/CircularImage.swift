//
//  CircularImage.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/7/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class CircularImage: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius: CGFloat = self.bounds.size.width / 2.0
        clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    

}
