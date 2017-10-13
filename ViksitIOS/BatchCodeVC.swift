//
//  BatchCodeVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/25/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class BatchCodeVC: UIViewController {
    
    @IBOutlet var errorLabel: UILabel!
    
    @IBOutlet var input1: TextFieldWithPadding!
    @IBOutlet var input2: TextFieldWithPadding!
    @IBOutlet var input3: TextFieldWithPadding!
    @IBOutlet var input4: TextFieldWithPadding!
    @IBOutlet var input5: TextFieldWithPadding!
    @IBOutlet var input6: TextFieldWithPadding!
    @IBOutlet var submitBtn: UIButton!
    @IBOutlet var skipBtn: UIButton!
    
    var userID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        setup()
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        errorLabel.isHidden = true
    }
    
    func setup() {
        input1.tag = 1
        input2.tag = 2
        input3.tag = 3
        input4.tag = 4
        input5.tag = 5
        input6.tag = 6
        
        input1.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        input2.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        input3.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        input4.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        input5.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        input6.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        
        submitBtn.addTarget(self, action: #selector(onSubmitPressed), for: .touchUpInside)
        skipBtn.addTarget(self, action: #selector(onSkipPressed), for: .touchUpInside)
    }
    
    func onSubmitPressed() {
        errorLabel.isHidden = true
        if input1.text != "" && input2.text != "" && input3.text != "" && input4.text != "" && input5.text != "" && input6.text != ""{
            var batchCodeString = "\(input1.text!)\(input2.text!)\(input3.text!)\(input4.text!)\(input5.text!)\(input6.text!)"
            print("Batch code is \(batchCodeString)")
            let batchCodeParams = [
                "batchCode" : batchCodeString
            ]
            do {
                DispatchQueue.global(qos: .userInteractive).async {
                    //background thread
                    let response = Helper.makeHttpCall(url: "http://elt.talentify.in/t2c/user/\(self.userID)/batch", method: "POST", param: batchCodeParams)
                    DispatchQueue.main.async {
                        // main ui thread
                        if (response != nil && response != "null" && !response.isEmpty && response.contains("HTTP Status") && response .contains("istarViksitProComplexKey")) {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Welcome", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
                            //nextViewController.userID = self.userID
                            self.present(nextViewController, animated:true, completion:nil)
                        } else if (response != "null" && response.contains("istarViksitProComplexKey")) {
                            self.errorLabel.text = response.replacingOccurrences(of: "istarViksitProComplexKey", with: "").replacingOccurrences(of: "\\", with: "")
                            self.errorLabel.isHidden = false
                        } else {
                            self.errorLabel.text = "Please contact your school administrators."
                            self.errorLabel.isHidden = false
                        }
                    }
                }
            }catch let error as NSError {
                print(" Error \(error)")
            }
            

        } else {
            errorLabel.text = "Please enter a valid batch code."
            errorLabel.isHidden = false
        }
            
    }
    
    func onSkipPressed() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Welcome", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
        nextViewController.userID = self.userID
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    func textChanged(sender: UITextField) {
        if (sender.text?.characters.count)! ==  1 {
            
            let nextField = sender.superview?.viewWithTag(sender.tag + 1) as UIResponder!
            nextField?.becomeFirstResponder()
        } else if (sender.text?.characters.count)! ==  0 {
            let nextField = sender.superview?.viewWithTag(sender.tag - 1) as UIResponder!
            nextField?.becomeFirstResponder()
        }
        
    }


}
