//
//  DVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/28/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

var MyObservationContext = 0

class DVC: UIViewController {
    
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var webviewHeightConstraint: NSLayoutConstraint!
    var observing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.scrollView.isScrollEnabled = false
        webview.delegate = self
        webview.loadRequest(NSURLRequest(url: URL(string: "https://www.google.de/intl/de/policies/terms/regional.html")!) as URLRequest)
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
    
    func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutableRawPointer) {
        guard let keyPath = keyPath else {
            super.observeValueForKeyPath(nil, ofObject: object, change: change, context: context)
            return
        }
        switch (keyPath, context) {
        case("contentSize", &MyObservationContext):
            webviewHeightConstraint.constant = webview.scrollView.contentSize.height
        default:
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
}

extension DVC: UIWebViewDelegate {
    func webViewDidFinishLoad(webView: UIWebView) {
        //print(webView.request?.URL)
        webviewHeightConstraint.constant = webview.scrollView.contentSize.height
        if (!observing) {
            startObservingHeight()
        }
    }
}
