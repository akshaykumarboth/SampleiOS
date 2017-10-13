//
//  OtpVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/25/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit
import Alamofire

class OtpVC: UIViewController {
    var backTag = ""

    @IBOutlet var otpSentLabel: UILabel!
    @IBOutlet var OTPField: TextFieldWithPadding!
    @IBOutlet var verifyBtn: UIButton!
    @IBOutlet var resendOTPBtn: UIButton!
    @IBOutlet var notYourNumBtn: UIButton!
    @IBOutlet var timeRemaining: UILabel!
    @IBOutlet var errorLabel: UILabel!
    
    var mobileNo: Int?
    var userID: Int?
    var otp: String?
    var timer: Timer! = Timer()
    var timeLeft = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("otp -> \(otp)")
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
            resendOTPBtn.setTitle("Resend OTP", for: .normal)
            timer.invalidate()
            
        }
    }
    
    func submitPressed() {
        self.errorLabel.isHidden = true
        print("otp -> \(otp)")
        if OTPField.text != "" {
            if otp == OTPField.text {
                if backTag == "SignUpVC" {
                    if let id = self.userID {
                        DispatchQueue.global(qos: .userInteractive).async {
                            
                           // print(Alamofire.request("", method: .put, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>))
                            
                            let response = Helper.makeHttpCall(url: "http://elt.talentify.in/t2c/user/\(id)/verify/true", method: "PUT", param: [:])
                            //Alamofire.request
                            
                            DispatchQueue.main.async {
                                print("response -> \(response)")
                                if (response != nil && response != "null" && !response.isEmpty && !response.contains("HTTP Status")) {
                                    let storyBoard : UIStoryboard = UIStoryboard(name: "Welcome", bundle:nil)
                                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BatchCodeVC") as! BatchCodeVC
                                    nextViewController.userID = self.userID
                                    self.present(nextViewController, animated:true, completion:nil)
                                } else {
                                    self.errorLabel.text = "Oops. Network Connectivty issue."
                                    self.errorLabel.isHidden = false
                                }
                            }
                        }
                    }
                    
                    
                }
                if backTag == "ForgotPasswordVC" {
                    //goto reset password vc
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Welcome", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
                    nextViewController.userID = userID
                    self.present(nextViewController, animated:true, completion:nil)
                }
                
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
        timeLeft = 60
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerRunning), userInfo: nil, repeats: true)
        resendOTPBtn.isEnabled = false
        resendOTPBtn.setTitle("OTP has been resent", for: .disabled)
        
        let resendQueue: DispatchQueue = DispatchQueue(label: "com.viksitIOS.resendOTPQueue", qos: .userInteractive, attributes: .concurrent)
        if let number = mobileNo {
            if let id = self.userID {
                resendQueue.async {
                    let otpResponse = Helper.makeHttpCall(url: "http://elt.talentify.in/t2c/user/\(id)/mobile?mobile=\(number)", method: "GET", param: [:])
                    DispatchQueue.main.async {
                        self.otp = otpResponse
                        print("resent otp -> \(self.otp)")
                    }
                }
            }
            
        }
        
    }
    
    func setup() {
        //otpSentLabel.text = "An OTP has been sent to your phone number ending with xxxxx\(mobileNo?.substring(from: (mobileNo?.index((mobileNo?.startIndex)!, offsetBy: 6))!))"
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
    
    
    
}
