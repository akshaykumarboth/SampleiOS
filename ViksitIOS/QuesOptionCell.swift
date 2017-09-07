//
//  QuesOptionCell.swift
//
//
//  Created by Akshay Kumar Both on 9/2/17.
//  Copyright © 2017 Akshay Kumar Both. All rights reserved.
//

import UIKit

class QuesOptionCell: UICollectionViewCell {
    
    var cellSize: CGFloat = 0
    
    var content : [String] = ["test1<br>test1<br>test1<br>test1<br>test1<br>test1", "test22<br>test22<br>test22<br>test22<br>test22<br>test22"]
    var contentHeights : [CGFloat] = [0.0, 0.0]
    
    
    var testString: String = "<!DOCTYPE html><html><head><style> table, th, td {border: 1px solid black;border-collapse: collapse;padding: 0 !important; margin: 0 !important;}</style></head><body><table style=\"width:100%\"><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr></table></body></html>"
    
    var tests : [String] = ["<!DOCTYPE html><html><head><style> table, th, td {border: 1px solid black;border-collapse: collapse;padding: 0 !important; margin: 0 !important;}</style></head><body><table style=\"width:100%\"><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Kotresh</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr></table></body></html>",
                            
                            
                            "<!DOCTYPE html><html><head><style> table, th, td {border: 1px solid black;border-collapse: collapse;padding: 0 !important; margin: 0 !important;}</style></head><body><table style=\"width:100%\"><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Kotresh</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr></table></body></html>",
                            
                            "<!DOCTYPE html><html><head><style> table, th, td {border: 1px solid black;border-collapse: collapse;padding: 0 !important; margin: 0 !important;}</style></head><body><table style=\"width:100%\"><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Kotresh</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr></table></body></html>",
                            
                            "<!DOCTYPE html><html><head><style> table, th, td {border: 1px solid black;border-collapse: collapse;padding: 0 !important; margin: 0 !important;}</style></head><body><table style=\"width:100%\"><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Kotresh</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr></table></body></html>",
                            
                            
                            "<!DOCTYPE html><html><head><style> table, th, td {border: 1px solid black;border-collapse: collapse;padding: 0 !important; margin: 0 !important;}</style></head><body><table style=\"width:100%\"><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Kotresh</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr></table></body></html>",
                            
                            "<!DOCTYPE html><html><head><style> table, th, td {border: 1px solid black;border-collapse: collapse;padding: 0 !important; margin: 0 !important;}</style></head><body><table style=\"width:100%\"><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Kotresh</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr></table></body></html>" ]
    
    @IBOutlet var quesHeightConstraint: NSLayoutConstraint!
    @IBOutlet var quesWebView: UIWebView!
    @IBOutlet var optionTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.quesWebView.delegate = self
        self.optionTableView.delegate = self
        self.optionTableView.dataSource = self
        
        // Initialization code
        
    }
}


extension QuesOptionCell: UIWebViewDelegate {
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
        debugPrint("Start Loading")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.scrollView.isScrollEnabled = false
        print(webView.scrollView.contentSize.height)
        resizeToContent(webView: webView)
        
    }
    
    func resizeToContent(webView: UIWebView){
        
        //let height = webView.stringByEvaluatingJavaScript(from: "(document.height !== undefined) ? document.height : document.body.offsetHeight;")
        var dynamicFrame: CGRect = webView.frame
        dynamicFrame.size.height = webView.scrollView.contentSize.height
        webView.frame = dynamicFrame
        
        //self.cellSize = dynamicFrame.height + 40
        
        print(webView.frame.height)
        
    }
    
}



extension QuesOptionCell: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        //return (cellSize)
    }
    */
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsTableCell", for: indexPath) as! OptionsTableCell
        //cell.optionWebView.tag = indexPath.row
        //cell.optionWebView.delegate = self
        cell.optionWebView.loadHTMLString(tests[indexPath.row], baseURL: nil)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         let storyBoard : UIStoryboard = UIStoryboard(name: "Modules", bundle:nil)
         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ModulesVC") as! ModulesVC
         
         nextViewController.course = roles[indexPath.row]
         self.present(nextViewController, animated:true, completion:nil)
         */
        
        tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = UIColor.blue
        print([indexPath.row] as Any)
    }
    
}

 /*

extension QuesOptionCell: UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsTableCell", for: indexPath) as! OptionsTableCell
        let htmlString = content[indexPath.row]
        let htmlHeight = contentHeights[indexPath.row]
        
        cell.optionWebView.tag = indexPath.row
        cell.optionWebView.delegate = self
        cell.optionWebView.loadHTMLString(htmlString, baseURL: nil)
        cell.optionWebView.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: htmlHeight)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return contentHeights[indexPath.row]
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.scrollView.isScrollEnabled = false
        if (contentHeights[webView.tag] != 0.0)
        {
            // we already know height, no need to reload cell
            return
        }
        
        contentHeights[webView.tag] = webView.scrollView.contentSize.height
        //optionTableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: webView.tag, inSection: 0)], withRowAnimation: .Automatic)
        
        let indexPath = IndexPath(item: webView.tag, section: 0)
        optionTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
 */
