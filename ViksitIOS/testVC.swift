//
//  testVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/28/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class testVC: UIViewController {

    @IBOutlet var errorView: UIView!
    @IBOutlet var submit: UIButton!
    @IBOutlet var paswField: TextFieldWithPadding!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSubmit(_ sender: UIButton) {
        
        view.addSubview(errorView)
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = errorView.bottomAnchor.constraint(equalTo: paswField.topAnchor)
        
        let leftConstraint = errorView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightConstraint = errorView.rightAnchor.constraint(equalTo: view.rightAnchor)
        
        let heightConstraint = errorView.heightAnchor.constraint(equalToConstant: 30)
        
        NSLayoutConstraint.activate([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
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
