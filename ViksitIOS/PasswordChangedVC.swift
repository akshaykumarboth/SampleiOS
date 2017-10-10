//
//  PasswordChangedVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/26/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class PasswordChangedVC: UIViewController {

    @IBOutlet var gotoLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gotoLoginBtn.backgroundColor = UIColor.Custom.themeColor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

        gotoLoginBtn.addTarget(self, action: #selector(onLoginPressed), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    func onLoginPressed() {
        goto(storyBoardName: "Welcome", storyBoardID: "LoginVC")
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
    }

}
