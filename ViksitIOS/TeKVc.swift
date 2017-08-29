//
//  TeKVc.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/27/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

var MyObservationContext = 0

class TeKVc: UIViewController {

    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var webviewHeightConstraint: NSLayoutConstraint!
    
    var observing = false
    var testString: String = "  1<b>MS Excel Workshop</b><b>MS Excel Workshop</b>2 <b>MS Excel Workshop</b>3 <b>MS Excel Workshop</b> <b>MS Excel Workshop</b>4 <b>MS Excel Workshop</b>5 <b>MS Excel Workshop</b>6 1<b>MS Excel Workshop</b><b>MS Excel Workshop</b>2 <b>MS Excel Workshop</b>3 <b>MS Excel Workshop</b> <b>MS Excel Workshop</b>4 <b>MS Excel Workshop</b>5 <b>MS Excel Workshop</b>6"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.loadHTMLString(ThemeUtil.wrapInHtml(body: testString,fontsize: "17"), baseURL: nil)
        webview.scrollView.isScrollEnabled = false
        webview.scrollView.bounces = false
        webview.delegate = self
        
    }
    
    deinit {
        stopObservingHeight()
    }
    
    func startObservingHeight() {
        let options = NSKeyValueObservingOptions([.new])
        webview.scrollView.addObserver(self, forKeyPath: "contentSize", options: options, context: &MyObservationContext)
        observing = true;
    }
    
    func stopObservingHeight() {
        webview.scrollView.removeObserver(self, forKeyPath: "contentSize", context: &MyObservationContext)
        observing = false
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath else {
            super.observeValue(forKeyPath: nil, of: object, change: change, context: context)
            return
        }
        switch keyPath {
        case "contentSize":
            if context == &MyObservationContext {
                webviewHeightConstraint.constant = webview.scrollView.contentSize.height
            }
        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

extension TeKVc: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webviewHeightConstraint.constant = webview.scrollView.contentSize.height
        if (!observing) {
            startObservingHeight()
        }
    }
}
