//
//  RolesVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/26/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class RolesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var roles: Array<Courses> = []
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        let cell = tableView.dequeueReusableCell(withIdentifier: "roleCell", for: indexPath) as! RoleTableCell
        
        //inserting omage from url async
        let url = URL(string: roles[indexPath.row].imageURL!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.roleImage.image = UIImage(data: data!)
            }
        }
        //
        /*if let checkedUrl = URL(string: "http://shop.wwe.com/on/demandware.static/-/Sites/default/dw73135c17/images/slot/landing/superstar-landing/Superstar-Category_Superstar_562x408_paige.png") {
         imageView.contentMode = .scaleAspectFit
         downloadImage(url: checkedUrl)
         }
*/
        //cell.roleImage.image = UIImage(named: animals[indexPath.row] + ".jpg" )
        cell.roleCategory.text = roles[indexPath.row].category
        cell.roleMessage.text = roles[indexPath.row].message
        cell.roleName.text = roles[indexPath.row].name
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(roles[indexPath.row].id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            roles = ComplexObject(JSONString: complexCache).courses!
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func goto(identifier: String, storyboardName: String){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Tab", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //
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
            }
        }
    }
    
}
