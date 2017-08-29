
import UIKit

class NotificationTableCell: UITableViewCell, UIWebViewDelegate {
    
    @IBOutlet var notificationImage: UIImageView!
    @IBOutlet var notificationMessage: UILabel!
    @IBOutlet var notificationDuration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //making the image circular
        self.notificationImage.layer.cornerRadius = self.notificationImage.frame.size.width / 2
        self.notificationImage.clipsToBounds = true
        
        //self.notificationMessageView.scalesPageToFit = true
        //self.notificationMessageView.frame=self.notiWebContainer.bounds;

        
        //setting fontsize for webview
        /*let textSize: Int = 20
        self.notificationMessageView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(textSize)%%'")*/
        
        
 
    }
    
    

}
