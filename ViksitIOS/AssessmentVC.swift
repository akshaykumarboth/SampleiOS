//
//  AssessmentVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/6/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit



class AssessmentVC: UIViewController {
    
    
    var testString: String = "<!DOCTYPE html><html><head><style> table, th, td {border: 1px solid black;border-collapse: collapse;padding: 0 !important; margin: 0 !important;}</style></head><body><table style=\"width:100%\"><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr></table></body></html>"
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    
}
extension AssessmentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuesOptionCell", for: indexPath) as! QuesOptionCell
        
        //cell.superSkillName.text = skills[indexPath.row].name
        //loading image async
        //ImageAsyncLoader.loadImageAsync(url: (skills[indexPath.row].imageURL)!, imgView: cell.superSkillImage)
        //cell.quesWebView.delegate = self
        cell.quesWebView.loadHTMLString(testString, baseURL: nil)
        
        //view.translatesAutoresizingMaskIntoConstraints = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width * 1, height: collectionView.frame.height) //use height whatever you wants.
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //print((skills[indexPath.row].name)!)
        
        
    }
    
}
/*

extension AssessmentVC: UIWebViewDelegate {
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
        debugPrint("Start Loading")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print(webView.scrollView.contentSize.height)
        resizeToContent(webView: webView)
        
    }
    
    func resizeToContent(webView: UIWebView){
        webView.scrollView.isScrollEnabled = false
        let height = webView.stringByEvaluatingJavaScript(from: "(document.height !== undefined) ? document.height : document.body.offsetHeight;")
        var dynamicFrame: CGRect = webView.frame
        dynamicFrame.size.height = webView.scrollView.contentSize.height
        //dynamicFrame.size.height = CGFloat(Float(height!)!) * 1.1
        webView.frame = dynamicFrame
        //cView.frame.size.height = dynamicFrame.size.height
    }
    
    
    
}
*/
