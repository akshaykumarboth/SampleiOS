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
        if (!newPswrdField.text?.isEmpty && newPswrdField.text!.characters.count >= 4 && !confirmPswrdField.text?.isEmpty) {
            /*if (password.getText().toString().toLowerCase().trim().equalsIgnoreCase(confirm_password.getText().toString().toLowerCase().trim())) {
             new ResetAsync(this, jsonresponse, password.getText().toString()).execute();
             } else {
             error_text.setText("Password and Confirm Password are not matching.");
             error_text.setVisibility(View.VISIBLE);
             }
*/
            
        } else {
            
            if newPswrdField.text?.isEmpty {
                errorLabel.text = "Password field required."
                errorLabel.isHidden = false
            }
            
            if confirmPswrdField.text?.isEmpty {
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

}
