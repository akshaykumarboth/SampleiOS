//
//  CustomWebView.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/28/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit



class CustomUIWebView: UIWebView, UIWebViewDelegate {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.scrollView.isScrollEnabled = false
        self.scrollView.bounces = false
        self.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.scrollView.isScrollEnabled = false
        self.scrollView.bounces = false
        self.delegate = self
    }
    
    func loadHTMLString(string: String!, baseURL: NSURL!) {
        var cssURL:String = Bundle.main.path(forResource: "webview", ofType: "css")!
        var s:String = "<html><head><title></title><meta name=\"viewport\" content=\"initial-scale=1, user-scalable=no, width=device-width\" /><link rel=\"stylesheet\" href=\"./webview.css\" ></link></head><body>"+string+"</body></html>";
        var url:NSURL
        
        if baseURL == nil {
            url = Bundle.main.bundleURL as NSURL
        } else {
            url = baseURL
        }
        
        super.loadHTMLString(s, baseURL: url as URL)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.webViewResizeToContent(webView: webView)
    }
    
    func webViewResizeToContent(webView: UIWebView) {
        webView.layoutSubviews()
        
        // Set to smallest rect value
        var frame:CGRect = webView.frame
        frame.size.height = 1.0
        webView.frame = frame
        
        var height:CGFloat = webView.scrollView.contentSize.height
        print("UIWebView.height: \(height)")
        
        //ebView.setHeight(height: height)
        let heightConstraint = NSLayoutConstraint(item: webView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: height)
        webView.addConstraint(heightConstraint)
        
        // Set layout flag
        webView.window?.setNeedsUpdateConstraints()
        webView.window?.setNeedsLayout()
    }
    
}
