//
//  OtpVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/25/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class OtpVC: UIViewController {

    @IBOutlet var otpSentLabel: UILabel!
    @IBOutlet var OTPField: TextFieldWithPadding!
    @IBOutlet var verifyBtn: UIButton!
    @IBOutlet var resendOTPBtn: UIButton!
    @IBOutlet var notYourNumBtn: UIButton!
    @IBOutlet var timeRemaining: UILabel!
    
    var mobileNo: String?
    var otp: String?
    var jsonResponse: String?
    var timer: Timer! = Timer()
    var timeLeft: Int! = 180
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyBtn.backgroundColor = UIColor.Custom.themeColor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

    }
    
    func timerRunning() {
        
        timeLeft -= 1
        timeRemaining.text = "\(timeLeft/60):\(timeLeft%60)"
        if timeLeft == 0 {
            resendOTPBtn.isEnabled = true
            timer.invalidate()
            
        }
    }
    
    func resendOtpPressed() {
        timeLeft = 180
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerRunning), userInfo: nil, repeats: true)
        resendOTPBtn.isEnabled = false
    }
    
    func x() {
        otpSentLabel.text = "An OTP has been sent to your phone number ending with xxxxx\(mobileNo?.substring(from: (mobileNo?.index((mobileNo?.startIndex)!, offsetBy: 6))!))"
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerRunning), userInfo: nil, repeats: true)
        resendOTPBtn.isEnabled = false
        resendOTPBtn.addTarget(self, action: #selector(self.resendOtpPressed), for: .touchUpInside)
        
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
