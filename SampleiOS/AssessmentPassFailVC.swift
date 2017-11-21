//
//  AssessmentPassVC.swift

import UIKit
import CircleProgressBar

class AssessmentPassFailVC: UIViewController {
    
    var report: AssessmentReports?
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var progressView: CircleProgressBar!
    @IBOutlet var messageDescriptionLabel: UILabel!
    @IBOutlet var viewReportBtn: UIButton!
    @IBOutlet var continueBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (report?.message?.contains("passed"))! {
            messageLabel.text = report?.message
            progressView.setProgress((CGFloat((report?.userScore)!/(report?.totalScore)!)), animated: true)
            progressView.progressBarProgressColor = UIColor(red:0.19, green:0.72, blue:0.96, alpha:1.0)
            messageDescriptionLabel.text = report?.messageDescription
        } else if (report?.message?.contains("failed"))!{
            messageLabel.text = report?.message
            progressView.setProgress((CGFloat((report?.userScore)!/(report?.totalScore)!)), animated: true)
            progressView.progressBarProgressColor = UIColor.Custom.themeColor
            messageDescriptionLabel.text = report?.messageDescription
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }

}
