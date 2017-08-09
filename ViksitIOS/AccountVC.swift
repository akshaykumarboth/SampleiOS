//
//  AccountVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/3/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class AccountVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var studentProfile: StudentProfile? = nil
    
    struct Objects {
        var sectionName: String!
        var hasmap: [String : String]
        var sectionObjects: [String]!
    }
    
    var objectsArray = [Objects]()
    
    
    @IBOutlet var profileImage: CircularImage!
    
    @IBAction func uploadPhotoPressed(_ sender: CircularButton) {
    }
    
    
    
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        goto(storyBoardName: "Tab", storyBoardID: "TabBarController")
    }
    
    
    @IBAction func onLogoutPressed(_ sender: UIButton) {
        goto(storyBoardName: "Tab", storyBoardID: "TabBarController")
    }
    
    
    func loadImageAsync(url: String, imgView: UIImageView){
        do {
            
            let url = URL(string: url)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    if data != nil {
                        imgView.image = UIImage(data: data!)
                    } else {
                        imgView.image = UIImage(named: "coins")
                        
                    }
                }
            }
            
        }catch let error as NSError {
            print(" Error \(error)")
        }
    }
    
    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            studentProfile = ComplexObject(JSONString: complexCache).studentProfile!
        }
        var mNo: String = ""
        if let y = studentProfile?.mobile {
            mNo = "\(y)"
        }
        
        objectsArray = [
            Objects(sectionName: "Personal Details",
                    hasmap: ["Name":(studentProfile?.firstName)!, "Date of Birth": (studentProfile?.dateOfBirth)!, "Email":(studentProfile?.email)!, "Mobile number": mNo, "Password": "sumanth1"],
                    sectionObjects: ["Name", "Date of Birth", "Email", "Mobile number", "Password"]),
            
            Objects(sectionName: "Educational Qualifications",
                    hasmap: ["Institution of Current Enrollment":"akshay1", "Graduate Degree":"vinay1", "Department":"karthik1",],
                    sectionObjects: ["Institution of Current Enrollment", "Graduate Degree", "Department"])
        ]
        // Do any additional setup after loading the view.
        
        loadImageAsync(url: (studentProfile?.profileImage)!, imgView: profileImage)
        
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        
        if let textlabel = header.textLabel {
            textlabel.font = textlabel.font.withSize(12)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "accountCell") as! AccountCell!

        cell?.cellNameLabel.text = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        
        let key = objectsArray[indexPath.section].sectionObjects[indexPath.row] as String
        cell?.cellValueField.text = objectsArray[indexPath.section].hasmap[key]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray[section].sectionObjects.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectsArray.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectsArray[section].sectionName
    }

}
