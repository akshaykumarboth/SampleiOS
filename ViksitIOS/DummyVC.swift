//
//  DummyVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/4/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class DummyVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
   
    
    @IBOutlet var mLabel: UILabel!
    
    @IBOutlet var mPicker: UIPickerView!
    
    var pickerList = ["Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female"]
    
    
    @IBOutlet var pickView: UIView!
    
    @IBOutlet var roles: UIButton!
    @IBAction func onRolesPressed(_ sender: UIButton) {
        if sender.isSelected {
            hideRoles()
            sender.isSelected = false
        } else {
            showRoles()
            sender.isSelected = true
        }
    }
    
    func showRoles() {
        view.addSubview(pickView)
        
        let topConstraint = pickView.topAnchor.constraint(equalTo: roles.bottomAnchor)
        let rightConstraint = pickView.rightAnchor.constraint(equalTo: view.rightAnchor)
        let widthConstraint = pickView.widthAnchor.constraint(equalToConstant: view.frame.width/2)
        let heightConstraint = pickView.heightAnchor.constraint(equalToConstant: CGFloat(30 * pickerList.count))
        
        NSLayoutConstraint.activate([topConstraint, rightConstraint, widthConstraint, heightConstraint])
        view.layoutIfNeeded()
    }
    
    func hideRoles(){
        pickView.removeFromSuperview()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mPicker.dataSource = self
        mPicker.delegate = self

        pickView.translatesAutoresizingMaskIntoConstraints = false
        // Do any additional setup after loading the view.
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mLabel.text = pickerList[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

}
