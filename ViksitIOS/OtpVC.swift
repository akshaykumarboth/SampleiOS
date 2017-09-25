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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyBtn.backgroundColor = UIColor.Custom.themeColor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
