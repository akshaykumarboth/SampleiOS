//
//  ForgotPasswordVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/25/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet var phoneNumberField: TextFieldWithPadding!
    @IBOutlet var submitBtn: UIButton!
    @IBOutlet var signInDifferentBtn: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.backgroundColor = UIColor.Custom.themeColor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        submitBtn.addTarget(self, action: #selector(onSubmitPressed), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    func onSubmitPressed() {
        print("submit pressed")
        
        if (phoneNumberField.text != nil && phoneNumberField.text != "" && phoneNumberField.text?.characters.count == 10) {
            //send http request
            errorLabel.isHidden = true
            let number = self.phoneNumberField.text!
            DispatchQueue.global(qos: .userInteractive).async {
                let response = Helper.makeHttpCall(url: "http://elt.talentify.in/t2c/user/password/forgot?mobile=\(number)", method: "GET", param: [:])
                
                //http://elt.talentify.in/t2c/user/password/forgot?mobile=9986919400
                if (response != "null" && response != nil && response != "" && !response.contains("HTTP Status")) {
                    let istarUser = IstarUser(jsonString: response)
                    if let userID = istarUser.id {
                        let otpResponse = Helper.makeHttpCall(url: "http://elt.talentify.in/t2c/user/\(userID)/mobile?mobile=\(number)", method: "GET", param: [:])
                        DispatchQueue.main.async {
                            //goto otp vc
                            //send phone and userid to otp vc to resend otp again if necessary
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Welcome", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                            nextViewController.mobileNo = self.phoneNumberField.text!
                            nextViewController.userID = userID
                            nextViewController.otp = otpResponse
                            self.present(nextViewController, animated:true, completion:nil)
                        }
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        self.errorLabel.text = "Oops. No account registered to this number."
                        self.errorLabel.isHidden = false
                    }
                    
                }
                
            }
        } else {
            if (phoneNumberField.text != nil && phoneNumberField.text != "") {
                errorLabel.text = "Phone number is too short"
                errorLabel.isHidden = false
            } else {
                errorLabel.text = "Phone number is required"
                errorLabel.isHidden = false
            }
        }
    }
    
    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        errorLabel.isHidden = true
        view.endEditing(true)
    }

}
