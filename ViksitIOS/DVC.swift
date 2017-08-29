import UIKit
import WebKit


class DVC: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var textview: UILabel!
    
    var testString: String = "  1<b>MS Excel Workshop</b><b>MS Excel Workshop</b>2 <b>MS Excel Workshop</b>3 <b>MS Excel Workshop</b> 2 <b>MS Excel Workshop</b>3 <b>MS Excel Workshop</b> <b>MS Excel Workshop</b>4 <b>MS Excel Workshop</b>5 <b>MS Excel Workshop</b>6"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        webView.scrollView.bounces = false
        webView.delegate = self
        webView.loadHTMLString(ThemeUtil.wrapInHtml(body: testString,fontsize: "17"), baseURL: nil)
        /*
        var attributedString = NSMutableAttributedString(string:"\(testString)")
        let attrs = [NSFontAttributeName : UIFont.systemFont(ofSize: 19.0)]
        var gString = NSMutableAttributedString(string:"g", attributes:attrs)
        attributedString.append(gString)
         
 */
        let str = ThemeUtil.wrapInHtml(body: testString, fontsize: "27")
        var attrStr = try! NSAttributedString(
            data: str.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        textview.attributedText = attrStr
        //textview.attributedText = attributedString

        print(view.frame.height)
        
    }
        
}

extension DVC: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        /*
        webView.evaluateJavaScript("document.height") { (result, error) in
            if error == nil {
                print(result)
            }
        }
        
        webView.evaluateJavaScript("document.width") { (result, error) in
            if error == nil {
                print(result)
            }
        }
 */
        
        webView.scrollView.isScrollEnabled=false;
        print(webView.scrollView.contentSize.height)
        heightConstraint.constant = webView.scrollView.contentSize.height
        
    }
    
}

