//
//  VerifyPhoneVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/25/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class VerifyPhoneVC: UIViewController {
    
    @IBOutlet var mobileField: TextFieldWithPadding!
    @IBOutlet var errorLabel: UILabel!
    
    var mobileNumber: Int?
    var userID: Int?
    
    @IBAction func onSubmitPressed(_ sender: UIButton) {
        errorLabel.isHidden = true
        if mobileField.text != nil && mobileField.text != "" && mobileField.text?.characters.count == 10 {
            let phoneNo = mobileField.text
            DispatchQueue.global(qos: .userInteractive).async {
                let response = Helper.makeHttpCall(url: "http://elt.talentify.in/t2c/user/\(self.userID)/mobile?mobile=\(phoneNo)", method: "PUT", param: [:])
                DispatchQueue.main.async {
                    if response != nil && response != "null" && !response.isEmpty && !response.contains("HTTP Status") && !response.contains("istarViksitProComplexKey") {
                        //goto otp vc
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Welcome", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VerifyOTPVC") as! VerifyOTPVC
                        nextViewController.mobileNo = self.mobileField.text!
                        nextViewController.userID = self.userID
                        nextViewController.otp = response
                        self.present(nextViewController, animated:true, completion:nil)
                    } else if (response != "null" && response.contains("istarViksitProComplexKey")) {
                        self.errorLabel.text = response.replacingOccurrences(of: "istarViksitProComplexKey", with: "").replacingOccurrences(of: "\\", with: "")
                        self.errorLabel.isHidden = false
                    } else {
                        self.errorLabel.text = "Oops. Network Connectvity issue. Please try again."
                        self.errorLabel.isHidden = false
                    }
                }
            }
        } else {
            errorLabel.isHidden = false
            errorLabel.text = "Phone no. is required (10 digits)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        
        mobileField.text = "\(mobileNumber!)"
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        errorLabel.isHidden = true
        view.endEditing(true)
    }

}
