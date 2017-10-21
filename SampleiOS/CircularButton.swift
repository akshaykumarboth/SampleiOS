//
//  RoundedButton.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/24/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

//keep the width and height equal to make the button in circular shape
@IBDesignable public class CircularButton: UIButton {
        
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
        
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
        
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0.5 * bounds.size.width
        clipsToBounds = true
    }
}


