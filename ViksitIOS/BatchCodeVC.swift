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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        setup()
        // Do any additional setup after loading the view.
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
        skipBtn.addTarget(self, action: #selector(onSKipPressed), for: .touchUpInside)
    }
    
    func onSubmitPressed() {
    
    }
    
    func onSKipPressed() {
        
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
