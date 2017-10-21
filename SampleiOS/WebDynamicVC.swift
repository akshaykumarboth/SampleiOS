//
//  WebDynamicVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/26/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class WebDynamicVC: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet var textView: UILabel!
    @IBOutlet var testView: DynamicTextWebView!
    
    var testString: String = "  1<b>MS Excel Workshop</b><b>MS Excel Workshop</b>2 <b>MS Excel Workshop</b>3 1<b>MS Excel Workshop</b><b>MS Excel Workshop</b>2 <b>MS Excel Workshop</b>3 5 <b>MS Excel Workshop</b>6"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.loadHTMLString(ThemeUtil.wrapInHtml(body: testString,fontsize: "17"), baseURL: nil)
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        textView.text = testString
        textView.font = UIFont.systemFont(ofSize: 17)
        
        testView.setText(text: testString, font: 20)
        
        // Do any additional setup after loading the view.
    }
        
}

