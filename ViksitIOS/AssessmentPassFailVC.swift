//
//  AssessmentPassVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit
import CircleProgressBar

class AssessmentPassFailVC: UIViewController {
    
    var report: AssessmentReports?
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var progressView: CircleProgressBar!
    @IBOutlet var messageDescriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (report?.message?.contains("passed"))! {
            messageLabel.text = report?.message
            progressView.setProgress((CGFloat((report?.userScore)!/(report?.totalScore)!)), animated: true)
            //progressView.progressBarProgressColor =
            messageDescriptionLabel.text = report?.messageDescription
        } else if (report?.message?.contains("failed"))!{
            messageLabel.text = report?.message
            progressView.setProgress((CGFloat((report?.userScore)!/(report?.totalScore)!)), animated: true)
            //progressView.progressBarProgressColor =
            messageDescriptionLabel.text = report?.messageDescription
        }

        // Do any additional setup after loading the view.
    }

   
}
