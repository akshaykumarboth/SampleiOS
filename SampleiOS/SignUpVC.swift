//
//  SignUpVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/24/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet var emailField: TextFieldWithPadding!
    @IBOutlet var mobileField: TextFieldWithPadding!
    @IBOutlet var passwordField: TextFieldWithPadding!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var signUpBtn: UIButton!
    @IBOutlet var showPasswordBtn: UIButton!
    var iconClick : Bool!
    
    
    @IBAction func togglePassword(_ sender: UIButton) {
        if(iconClick == true) {
            //show pswrd
            passwordField.isSecureTextEntry = false
            showPasswordBtn.tintColor = UIColor.Custom.themeColor
            iconClick = false
        } else {
            //hide pswrd
            passwordField.isSecureTextEntry = true
            showPasswordBtn.tintColor = UIColor(red:0.61, green:0.61, blue:0.61, alpha:1.0)
            iconClick = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconClick = true
        signUpBtn.backgroundColor = UIColor.Custom.themeColor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        errorLabel.isHidden = true
        view.endEditing(true)
    }
    @IBAction func onSignupPressed(_ sender: UIButton) {
        errorLabel.isHidden = true
        var email: String = emailField.text!
        var phone: String = mobileField.text!
        var password: String = passwordField.text!
        
        if validate(email: email, phone: phone, password: password) == true {
            let signupParams = [
                "email" : email,
                "mobile" : phone,
                "password" : password
            ]
            DispatchQueue.global(qos: .userInteractive).async {
                let signupResponse = Helper.makeHttpCall(url: "\(Constant.prodUrlString)t2c/user/create", method: "POST", param: signupParams)
                DispatchQueue.main.async {
                    if !signupResponse.isEmpty && signupResponse != nil && signupResponse != "null" && signupResponse != "[]" && !signupResponse.contains("istarViksitProComplexKey"){
                        print(signupResponse)
                        let studentprofile = StudentProfile(jsonString: signupResponse)
                        if type(of: studentprofile.id) != nil {
                            if let userID = studentprofile.id {
                                if let number = studentprofile.mobile {
                                    DispatchQueue.global(qos: .userInteractive).async {
                                        let otpResponse = Helper.makeHttpCall(url: "http://elt.talentify.in/t2c/user/\(userID)/mobile?mobile=\(number)", method: "GET", param: [:])
                                        DispatchQueue.main.async{
                                            if !otpResponse.isEmpty && otpResponse != nil && otpResponse != "null" && !otpResponse.contains("istarViksitProComplexKey"){
                                                let storyBoard : UIStoryboard = UIStoryboard(name: "Welcome", bundle:nil)
                                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                                                nextViewController.otp = otpResponse
                                                nextViewController.mobileNo = number
                                                nextViewController.userID = userID
                                                nextViewController.backTag = "SignUpVC"
                                                self.present(nextViewController, animated:true, completion:nil)
                                            }
                                            
                                        }
                                    }
                                }
                                
                            }
                        }
                        
                    } else if (signupResponse != "null" && signupResponse.contains("istarViksitProComplexKey")) {
                        self.errorLabel.text = signupResponse.replacingOccurrences(of: "istarViksitProComplexKey", with: "").replacingOccurrences(of: "\\", with: "")
                        self.errorLabel.isHidden = false
                    } else {
                        self.errorLabel.text = "Please check your internet connection."
                        self.errorLabel.isHidden = false
                    }
                    
                }
            }
            
            //let signupResponse = Helper.makeHttpCall(url: "\(Constant.localUrlString)t2c/user/create", method: "POST", param: signupParams)

            
        }
        
    }
    
    func validate(email: String , phone: String, password: String) -> Bool {
        if (password.characters.count == 0 || password.characters.count < 4 || email.characters.count < 4 || isValidEmail(testStr: email) == false || phone.characters.count == 0 || phone.characters.count != 10 /*|| isValidPhone(value: phone) == false*/) {
            var error_message: String = ""
            if email.characters.count == 0 {
                error_message = "Email id is required"
                //errorLabel.text = error_message
                //errorLabel.isHidden = false
                print(error_message)
            } else if isValidEmail(testStr: email) == false {
                error_message = "Please enter a valid email Id"
                //errorLabel.text = error_message
                //errorLabel.isHidden = false
                print(error_message)
            }
            
            if password.characters.count == 0 {
                if error_message != "" {
                    error_message += ", "
                }
                error_message += "password is required "
                //errorLabel.text = error_message
                //errorLabel.isHidden = false
                print(error_message)
                
            }  else if password.characters.count < 4 {
                error_message = error_message + "password is too short "
                //errorLabel.text = error_message
                //errorLabel.isHidden = false
                print(error_message)
            }
            
            if(phone.characters.count == 0 || phone.characters.count != 10){
                if error_message != "" {
                    error_message += "and "
                }
                
                error_message += "phone Number is required (10 Digit)"
                //errorLabel.text = error_message
                //errorLabel.isHidden = false
                print(error_message)
            } /*else if isValidPhone(value: phone) == false {
                error_message = "Phone Number is not vaild";
                //errorLabel.text = error_message
                //errorLabel.isHidden = false
                print(error_message)
            }*/
            
            errorLabel.text = error_message
            errorLabel.isHidden = false
            
            return false
        } else {
            errorLabel.isHidden = true
            return true
        }
    }
    
    func isValidPhone(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    func isValidEmail(testStr:String) -> Bool {
        //print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }

    
}
