//
//  ScrollVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/6/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ScrollVC: UIViewController {

    @IBOutlet var option1: OptionView!
    @IBOutlet var option2: OptionView!
    @IBOutlet var option3: OptionView!
    @IBOutlet var option4: OptionView!
    @IBOutlet var option5: OptionView!
    @IBOutlet var option6: OptionView!
    
    var testString: String = "<!DOCTYPE html><html><head><style> table, th, td {border: 1px solid black;border-collapse: collapse;padding: 0 !important; margin: 0 !important;}</style></head><body><table style=\"width:100%\"><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr></table></body></html>"

    var tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        option1.optionText.attributedText = setHTMLString(testString: testString)
        option2.removeFromSuperview()
        option3.removeFromSuperview()
        option4.removeFromSuperview()
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(ScrollVC.myviewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        option1.addGestureRecognizer(tapGesture)
        option1.isUserInteractionEnabled = true
        
        // Do any additional setup after loading the view.
    }
    
    func myviewTapped(_ sender: UITapGestureRecognizer) {
        
        if self.option1.backgroundColor == UIColor.yellow {
            self.option1.backgroundColor = UIColor.green
        }else{
            self.option1.backgroundColor = UIColor.yellow
        }
    }
    
    func setHTMLString(testString: String) -> NSAttributedString {
        //let str = ThemeUtil.wrapInHtml(body: testString, fontsize: fontsize)
        // if the string is not wrapped in html tags then wrap it and uncomment above line
        let str = testString
        let attrStr = try! NSAttributedString(
            data: str.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        //textview.attributedText = attrStr
        return attrStr
    }
    

}
