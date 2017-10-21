//
//  HoriPickerVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/9/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class HoriPickerVC: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var myPicker: UIPickerView!
    
    var pickerList: [String] = ["Akshay", "Abhinav", "Feroz", "Mayank", "Ravi"]
    
    var rotationAngle: CGFloat!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rotationAngle = 90 * (.pi/180)
        var y = myPicker.frame.origin.y
        myPicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        myPicker.frame = CGRect(x: 0, y: Int(y), width: Int(view.frame.width), height: 10)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        
        label.text = pickerList[row]
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
                print("data reloaded")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
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
