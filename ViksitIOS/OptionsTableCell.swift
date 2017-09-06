//
//  OptionsTableCell.swift
//
//
//  Created by Akshay Kumar Both on 9/5/17.
//  Copyright © 2017 Akshay Kumar Both. All rights reserved.
//

import UIKit

class OptionsTableCell: UITableViewCell {
    
    //@IBOutlet var optionHeightConstraint: NSLayoutConstraint!
    @IBOutlet var cView: UIView!
    @IBOutlet var optionWebView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.optionWebView.delegate = self
        
        // Initialization code
    }
    
}


 extension OptionsTableCell: UIWebViewDelegate {
 
    public func webViewDidStartLoad(_ webView: UIWebView) {
        debugPrint("Start Loading")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print(webView.scrollView.contentSize.height)
        resizeToContent(webView: webView)
        //optionTableView.beginUpdates()
        //optionTableView.endUpdates()
        
    }
 
    func resizeToContent(webView: UIWebView){
        webView.scrollView.isScrollEnabled = false
        let height = webView.stringByEvaluatingJavaScript(from: "(document.height !== undefined) ? document.height : document.body.offsetHeight;")
        
        var dynamicFrame: CGRect = webView.frame
        dynamicFrame.size.height = CGFloat(Float(height!)!) * 1.1
        webView.frame = dynamicFrame
        
        //cView.frame.size.height = dynamicFrame.size.height
        //heightConstraint.constant = CGFloat(Float(height!)!) * 1.1
        
    }
 
 }

