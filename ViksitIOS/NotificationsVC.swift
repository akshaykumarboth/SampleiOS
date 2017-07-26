//
//  NotificationsVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/26/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class NotificationsVC: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    var notifications: Array<Notifications> = []
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationTableCell
        
        //cell.notificationImage.image = UIImage(named: notifications[indexPath.row] + ".jpg" )
        /*if let checkedUrl = URL(string: notifications[indexPath.row].imageURL!) {
            //imageView.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl)
        }*/
        //cell.notificationDuration.text = notifications[indexPath.row].time
        cell.notificationMessage.text = notifications[indexPath.row].message
        cell.notificationDuration.text = notifications[indexPath.row].time
        
        return cell
    }
    
    
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                //self.imageView.image = UIImage(data: data)
            }
            
            do {
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileName = "feroz"
                let fileURL = documentsURL.appendingPathComponent("\(fileName).png")
                print("fileURL \(fileURL.absoluteString)")
                if let pngImageData = UIImagePNGRepresentation( UIImage(data: data)!) {
                    try pngImageData.write(to: fileURL, options: .atomic)
                }
            } catch let myError {
                print("caught: \(myError)")
            }        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            var complexObject = ComplexObject(JSONString: complexCache)
            notifications = complexObject.notifications!
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
