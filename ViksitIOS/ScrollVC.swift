//
//  ScrollVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/6/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ScrollVC: UIViewController {

    @IBOutlet var stack: UIStackView!
    @IBOutlet var quesView: UITextView!
    
    var testString: String = "<!DOCTYPE html><html><head><style> body { font-size: 10px;} table, th, td {border: 1px solid black;border-collapse: collapse;padding: 0 !important; margin: 0 !important;}</style></head><body><table style=\"width:100%\"><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr></table></body></html>"

    override func viewDidLoad() {
        super.viewDidLoad()

        quesView.attributedText = setHTMLString(testString: testString, fontsize: "1")
        
        var para: OptionView
        
        for i in 0..<4 {
            //let symbolTextLabel = SymbolTextLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            //paraStack.addArrangedSubview(symbolTextLabel)
            //
            para = OptionView()
            para.optionText.isScrollEnabled = false
            para.optionText.attributedText = setHTMLString(testString: testString, fontsize: "1")
            //para.attributedText = testString
            stack.addArrangedSubview(para)
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setHTMLString(testString: String,fontsize: String ) -> NSAttributedString {
        //let str = ThemeUtil.wrapInHtml(body: testString, fontsize: fontsize)
        let str = testString
        let attrStr = try! NSAttributedString(
            data: str.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        //textview.attributedText = attrStr
        return attrStr
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
