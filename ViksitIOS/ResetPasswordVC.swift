//
//  ResetPasswordVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/25/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit
import Alamofire
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
            
            if newPswrdField.text == confirmPswrdField.text {
                
                let params: [String : String] = [
                    "userId" : "\(userID!)",
                    "password" : newPswrdField.text!
                    ]
                
                do{
                    DispatchQueue.global(qos: .userInteractive).async {
                        
                        let pswrdResponse = Helper.makeHttpCall(url: "http://elt.talentify.in/t2c/user/password/reset", method: "PUT", param: params )
                        //print(Alamofire.request("http://elt.talentify.in/t2c/user/password/reset", method: .PUT, parameters: params, encoding: "myBody", headers: [:]) )
                        
                        DispatchQueue.main.async {
                            print(pswrdResponse)
                            if (pswrdResponse != nil && pswrdResponse != "null" && pswrdResponse == "DONE")  {
                                //goto changed password vc
                                self.goto(storyBoardName: "Welcome", storyBoardID: "PasswordChangedVC")
                                
                            } else if pswrdResponse != "null" && pswrdResponse.contains("istarViksitProComplexKey") {
                                self.errorLabel.text = pswrdResponse.replacingOccurrences(of: "\\", with: "").replacingOccurrences(of: "istarViksitProComplexKey", with: "")
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
        goto(storyBoardName: "Welcome", storyBoardID: "LoginVC")
    }
    
    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
    }

}
