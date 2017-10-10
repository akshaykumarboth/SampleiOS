//
//  ResetPasswordVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/25/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    @IBOutlet var newPswrdField: TextFieldWithPadding!
    @IBOutlet var confirmPswrdField: TextFieldWithPadding!
    @IBOutlet var submitBtn: UIButton!
    @IBOutlet var signInDifferentBtn: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    var userID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.backgroundColor = UIColor.Custom.themeColor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        setup()
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        errorLabel.isHidden = true
    }
    
    func setup() {
        submitBtn.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)
        signInDifferentBtn.addTarget(self, action: #selector(signInDifferentPressed), for: .touchUpInside)
    }
    
    func submitPressed() {
        errorLabel.isHidden = true
        if (!(newPswrdField.text?.isEmpty)! && newPswrdField.text!.characters.count >= 4 && !(confirmPswrdField.text?.isEmpty)!) {
            /*if (password.getText().toString().toLowerCase().trim().equalsIgnoreCase(confirm_password.getText().toString().toLowerCase().trim())) {
             new ResetAsync(this, jsonresponse, password.getText().toString()).execute();
             } else {
             error_text.setText("Password and Confirm Password are not matching.");
             error_text.setVisibility(View.VISIBLE);
             }
*/
            if newPswrdField.text == confirmPswrdField.text {
                
                let params: [String : Any] = [
                    "userId" : userID,
                    "password" : newPswrdField.text!
                    ]
                
                do{
                    DispatchQueue.global(qos: .userInitiated).async {
                        
                        let pswrdResponse = Helper.makeHttpCall(url: "http://elt.talentify.in/t2c/user/password/reset", method: "PUT", param: params as! [String : String])
                        DispatchQueue.main.async {
                            if (pswrdResponse != nil && pswrdResponse != "null" && !pswrdResponse.contains("istarViksitProComplexKey") && pswrdResponse.replacingOccurrences(of: "\\", with: "") == "done")  {
                                //goto changed password vc
                                self.goto(storyBoardName: "Welcome", storyBoardID: "PasswordChangedVC")
                                
                            } else if pswrdResponse != "null" && pswrdResponse.contains("istarViksitProComplexKey") {
                                errorLabel.text = pswrdResponse.replacingOccurrences(of: "\\", with: "").replacingOccurrences(of: "istarViksitProComplexKey", with: "")
                                self.errorLabel.isHidden = false
                            } else {
                                self.errorLabel.text = "Please check your internet connection"
                                self.errorLabel.isHidden = false
                            }
                        }
                    }
                } catch let error as NSError {
                    print(" Error \(error)")
                }
                
            } else {
                errorLabel.text = "Password and Confirm Password are not matching."
                errorLabel.isHidden = false
            }
        } else {
            
            if (newPswrdField.text?.isEmpty)! {
                errorLabel.text = "Password field required."
                errorLabel.isHidden = false
            }
            
            if (confirmPswrdField.text?.isEmpty)! {
                errorLabel.text = "Confirm Password field required."
                errorLabel.isHidden = false
            }
            
            if newPswrdField.text!.characters.count < 4 {
                errorLabel.text = "Password is too short (minimum 4 digits)."
                errorLabel.isHidden = false
            }
            
        }
    }
    
    func signInDifferentPressed() {
        
    }
    
    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
    }

}
