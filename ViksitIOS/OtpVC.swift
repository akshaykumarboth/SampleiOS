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
    @IBOutlet var errorLabel: UILabel!
    
    var mobileNo: String?
    var userID: Int?
    var otp: String?
    var timer: Timer! = Timer()
    var timeLeft = 180
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyBtn.backgroundColor = UIColor.Custom.themeColor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        setup()

    }
    
    func timerRunning() {
        
        timeLeft -= 1
        timeRemaining.text = "\(timeLeft/60):\(timeLeft%60)"
        if timeLeft == 0 {
            resendOTPBtn.isEnabled = true
            timer.invalidate()
            
        }
    }
    
    func submitPressed() {
        if OTPField.text != "" {
            if otp == OTPField.text {
                //goto reset password vc
                let storyBoard : UIStoryboard = UIStoryboard(name: "Welcome", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
                nextViewController.userID = userID
                
                self.present(nextViewController, animated:true, completion:nil)
            } else {
                //wrong password
                errorLabel.text = "Oops! The OTP is incorrect."
                errorLabel.isHidden = false
            }
        } else {
            errorLabel.text = "OTP is required."
            errorLabel.isHidden = false
        }
    }
    func resendOtpPressed() {
        timeLeft = 180
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerRunning), userInfo: nil, repeats: true)
        resendOTPBtn.isEnabled = false
        resendOTPBtn.setTitle("OTP has been resent", for: .disabled)
        
        DispatchQueue.global(qos: .userInitiated).async {
            let otpResponse = Helper.makeHttpCall(url: "http://elt.talentify.in/t2c/user/\(self.userID)/mobile?mobile=\(self.mobileNo)", method: "PUT", param: [:])
            DispatchQueue.main.async {
                self.otp = otpResponse
            }
        }
    }
    
    func setup() {
        otpSentLabel.text = "An OTP has been sent to your phone number ending with xxxxx\(mobileNo?.substring(from: (mobileNo?.index((mobileNo?.startIndex)!, offsetBy: 6))!))"
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerRunning), userInfo: nil, repeats: true)
        resendOTPBtn.isEnabled = false
        resendOTPBtn.addTarget(self, action: #selector(self.resendOtpPressed), for: .touchUpInside)
        verifyBtn.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)
        
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        errorLabel.isHidden = true
    }
    
    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
    }
    
}
