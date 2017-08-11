//
//  StackViewCell.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/10/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class StackViewCell: UITableViewCell {
    
    var cellExists: Bool = false
    
    @IBOutlet var openView: UIView!
    @IBOutlet var stuffView: UIView! {
        didSet {
            stuffView?.isHidden = true
            stuffView?.alpha = 0
        }
    }
   
    @IBOutlet var expandImg: UIImageView!
    @IBOutlet var childSkillNameLabel: UILabel!
    @IBOutlet var childSkillProgress: UIProgressView!
    @IBOutlet var childSkillDetailsLabel: UILabel!
    
    @IBOutlet var grandChildStackView: UIStackView!
    
    @IBOutlet var touchView: UIButton!
    
    @IBAction func onTouchedCell(_ sender: UIButton) {
        print("ekjnhbferhe")
    }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //self.contentView.backgroundColor = background_color
        
    }
    
    func animate(duration: Double, c: @escaping () -> Void) {
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                self.stuffView.isHidden = !self.stuffView.isHidden
                if self.stuffView.alpha == 1 {
                    self.stuffView.alpha = 0.5
                } else {
                    self.stuffView.alpha = 1
                }
            })
        }, completion: { (finished: Bool) in
            print("animation complete")
            c()
        })  
    }
    
    
}
