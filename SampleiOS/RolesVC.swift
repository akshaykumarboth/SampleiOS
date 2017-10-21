//
//  RolesVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/26/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class RolesVC: UIViewController {
    
    var roles: Array<Courses> = []
    
    @IBOutlet var profileBtn: UIButton!
    @IBOutlet var coinsBtn: UIButton!
    @IBOutlet var experiencePoints: UILabel!
    @IBOutlet var topActionBar: UIView!
    
    @IBAction func onCoinsPressed(_ sender: Any) {
        goto(storyBoardName: "Profile", storyBoardID: "LeaderboardVC")
    }
    
        
    //todo
    @IBAction func onProfilePressed(_ sender: UIButton) {
        goto(storyBoardName: "Profile", storyBoardID: "ProfileTBC")
    }
    
    @IBAction func onNotificationPressed(_ sender: UIButton) {
        goto(storyBoardName: "Modules", storyBoardID: "NotificationsVC")
    }
    
    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topActionBar.backgroundColor = UIColor.Custom.themeColor
        
        var profileImgUrl: String = ""
        var xp: Int = 0
        var coins: Int = 0
        
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            roles = ComplexObject(JSONString: complexCache).courses!
            profileImgUrl = (ComplexObject(JSONString: complexCache).studentProfile?.profileImage)!
            xp = (ComplexObject(JSONString: complexCache).studentProfile?.experiencePoints)!
            coins = (ComplexObject(JSONString: complexCache).studentProfile?.coins)!
            
            setProfileImage(profileImgUrl: profileImgUrl)
        }
       
        //userXpBtn.setTitle(String(xp) + " xp", for: .normal)
        coinsBtn.setTitle(" " + String(coins), for: .normal)
        experiencePoints.text = String(xp)
        
    }
    
    func setProfileImage(profileImgUrl: String) {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let finalPath = path + "/Viksit/Viksit_PROFILE_PIC/profile_pic.jpg"
        let fileExists = FileManager().fileExists(atPath: finalPath)
        if fileExists {
            profileBtn.setBackgroundImage(UIImage(contentsOfFile: finalPath), for: .normal)
            print("found")
        } else {
            print("\(finalPath) not found")
            
            if let url = URL(string: profileImgUrl) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        if data != nil {
                            self.profileBtn.setBackgroundImage(UIImage(data: data!), for: .normal)
                        } else {
                            self.profileBtn.setBackgroundImage(UIImage(named: "coins"), for: .normal)
                        }
                    }
                }
            }
        }
        
        profileBtn.makeButtonRound(borderWidth: 2.5, borderColor: UIColor.white)
    }
    
    func makeButtonRound(button: UIButton, borderWidth: CGFloat, color: UIColor){
        button.layer.cornerRadius = button.frame.width/2
        button.layer.masksToBounds = true
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = color.cgColor
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
            }
        }
    }
    
}

extension RolesVC: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        let cell = tableView.dequeueReusableCell(withIdentifier: "roleCell", for: indexPath) as! RoleTableCell
        
        //inserting image from url async for roleImage
        //ImageAsyncLoader.loadImageAsync(url: roles[indexPath.row].imageURL!, imgView: cell.roleImage)
        
        setRoleImage(imgUrl: roles[indexPath.row].imageURL!, imageView: cell.roleImage)
        cell.roleCategory.text = roles[indexPath.row].category?.uppercased()
        cell.roleMessage.text = roles[indexPath.row].message
        cell.roleName.text = roles[indexPath.row].name
        cell.roleProgress.progress = Float(roles[indexPath.row].progress!/100)
        cell.roleProgress.trackTintColor = UIColor(red:0.96, green:0.96, blue:0.98, alpha:1.0)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Modules", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ModulesVC") as! ModulesVC
        
        nextViewController.course = roles[indexPath.row]
        self.present(nextViewController, animated:true, completion:nil)
        //print(roles[indexPath.row].id as Any)
    }
    
    func setRoleImage(imgUrl: String, imageView: UIImageView) {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let finalPath = path + "/Viksit/Viksit_ROLES/\(imgUrl.components(separatedBy: "/").last!)"
        print(finalPath)
        let fileExists = FileManager().fileExists(atPath: finalPath)
        if fileExists {
            imageView.image = UIImage(contentsOfFile: finalPath)
            print("found")
        } else {
            print("\(finalPath) not found")
            ImageAsyncLoader.loadImageAsync(url: imgUrl, imgView: imageView)
        }
        
    }

}
