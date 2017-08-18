//
//  LessonCVCell.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/18/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class LessonCVCell: UICollectionViewCell {
    
    @IBOutlet var completionImg: UIImageView!
    
    
    @IBOutlet var lessonTitle: UILabel!
    
    
    @IBOutlet var lessonDescription: UILabel!
    @IBOutlet var progress: UIProgressView!
    
    @IBOutlet var beginSkillBtn: UIButton!
    
    @IBAction func onBeginSkillPressed(_ sender: UIButton) {
    }
    
    
}
