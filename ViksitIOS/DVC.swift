import UIKit
import WebKit


class DVC: UIViewController {
    
    @IBOutlet var textview: UILabel!
    
    @IBOutlet var webview: UIWebView!
    @IBOutlet var sumbolView: SymbolTextLabel!
    
    var testString: String = "<!DOCTYPE html><html><head><style> table, th, td {border: 1px solid black;border-collapse: collapse;padding: 0 !important; margin: 0 !important;}</style></head><body><table style=\"width:100%\"><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr></table></body></html>"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //let str = ThemeUtil.wrapInHtml(body: testString, fontsize: "27")
        
        sumbolView.setText(text: "Understanding the meaning of sales", symbolCode: ThemeUtil.bulletSymbol)
        sumbolView.setFontSize(textSize: 8)

        print(view.frame.height)
        webview.delegate = self
        webview.loadHTMLString(testString, baseURL: nil)
        
    }
        
}

extension DVC: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print(webView.scrollView.contentSize.height)
        resizeToContent(webView: webView)
    }
    
    func resizeToContent(webView: UIWebView){
        webView.scrollView.isScrollEnabled = false
        let height = webView.stringByEvaluatingJavaScript(from: "(document.height !== undefined) ? document.height : document.body.offsetHeight;")
        var dynamicFrame: CGRect = webView.frame
        dynamicFrame.size.height = CGFloat(Float(height!)!) * 1.1
        webView.frame = dynamicFrame
    }
    
}

