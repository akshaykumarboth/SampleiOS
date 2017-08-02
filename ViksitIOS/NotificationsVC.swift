
import UIKit

class NotificationsVC: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    var notifications: Array<Notifications> = []
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(notifications[indexPath.row].id!)
    }
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Tab", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        nextViewController.selectedIndex = 0
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        tableView.showsVerticalScrollIndicator = false
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationTableCell
        
        //loading image from url async
        let url = URL(string: notifications[indexPath.row].imageURL!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.notificationImage.image = UIImage(data: data!)
            }
        }

        cell.notificationDuration.text = notifications[indexPath.row].time
        cell.notificationMessageView.isUserInteractionEnabled = false
        cell.notificationMessageView.loadHTMLString(wrapInHtml(body: notifications[indexPath.row].message!), baseURL: nil)
        
        return cell
    }
    
    
    
    
    func wrapInHtml(body: String) -> String {
        var html = "<html>"
        html += "<head>"
        html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
        html += "<style> body { font-size: 8px; padding: 0 !important; margin: 0 !important} </style>"
        /*html += "<script type=\"text/javascript\">"
        html += "window.onload = function() {"
        html +=  "window.location.href = \"ready://\" + document.body.offsetHeight; }"
        html += "</script>"*/
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

        // Do any additional setup after loading the view.
    }

    
}
