
import UIKit

class NotificationsVC: UIViewController {

    var notifications: Array<Notifications> = []
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Tab", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        nextViewController.selectedIndex = 0
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    func setHTMLString(testString: String,fontsize: String ) -> NSAttributedString{
        let str = ThemeUtil.wrapInHtml(body: testString, fontsize: fontsize)
        var attrStr = try! NSAttributedString(
            data: str.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        //textview.attributedText = attrStr
        return attrStr
    }
    
    func wrapInHtml(body: String) -> String {
        var html = "<html>"
        html += "<head>"
        html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
        html += "<style> body { font-size: 8px; padding: 0 !important; margin: 0 !important} </style>"
        html += "</head>"
        html += "<body>"
        html += body
        html += "</body>"
        html += "</html>"
        
        return html
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            let complexObject = ComplexObject(JSONString: complexCache)
            notifications = complexObject.notifications!
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140

        // Do any additional setup after loading the view.
    }

    
}

extension NotificationsVC: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(notifications[indexPath.row].id!)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        tableView.showsVerticalScrollIndicator = false
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationTableCell
        
        //loading image from url async
        do {
            let url = URL(string: notifications[indexPath.row].imageURL!)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    if data != nil {
                        cell.notificationImage.image = UIImage(data: data!)
                    } else {
                        cell.notificationImage.image = UIImage(named: "coins")
                    }
                    
                }
            }
        } catch let error as NSError {
            print(" Error \(error)")
        }
        
        cell.notificationDuration.text = notifications[indexPath.row].time
        //cell.notificationMessageView.isUserInteractionEnabled = false
        //cell.notificationMessageView.loadHTMLString(wrapInHtml(body: notifications[indexPath.row].message!), baseURL: nil)
        cell.notificationMessage.attributedText = setHTMLString(testString: notifications[indexPath.row].message!, fontsize: "15")
        
        return cell
    }


}
