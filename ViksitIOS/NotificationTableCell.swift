
import UIKit

class NotificationTableCell: UITableViewCell, UIWebViewDelegate {
    
    @IBOutlet var notificationImage: UIImageView!
    @IBOutlet var notificationMessageView: UIWebView!
    @IBOutlet var notificationDuration: UILabel!
    @IBOutlet var notiWebContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //making the image circular
        self.notificationImage.layer.cornerRadius = self.notificationImage.frame.size.width / 2
        self.notificationImage.clipsToBounds = true
        
        
        //setting fontsize for webview
        /*let textSize: Int = 500
        notificationMessageView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('body')[0].style.webkitTextSi‌​zeAdjust= '\(textSize)%%'")*/
        
        var x = Int(notificationMessageView.stringByEvaluatingJavaScript(from: "document.body.offsetHeight")!)
        print("height -> \(x)")
        self.notiWebContainer.frame.size = CGSize(width: notiWebContainer.frame.width, height: CGFloat(x!))
 
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
