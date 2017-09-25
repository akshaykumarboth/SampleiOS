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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        var email: String = emailField.text!
        var phone: String = mobileField.text!
        var password: String = passwordField.text!
        
        if validate(email: email, phone: phone, password: password) == true {
            let signupParams = [
                "email" : email,
                "mobile" : phone,
                "password" : password
            ]
            
            //var signupResponse = Helper.makeHttpCall(url: "http://elt.talentify.in/t2c/user/create", method: "POST", param: signupParams)
            let signupResponse = Helper.makeHttpCall(url: "http://192.168.1.4:8080/t2c/user/create", method: "POST", param: signupParams)

            print(signupResponse)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Welcome", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
            self.present(nextViewController, animated:true, completion:nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
