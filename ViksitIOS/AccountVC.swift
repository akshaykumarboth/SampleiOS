//
//  AccountVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/3/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class AccountVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct Objects {
        var sectionName: String!
        var sectionObjects: [String]!
    }
    
    var objectsArray = [Objects]()
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        goto(storyBoardName: "Tab", storyBoardID: "tasksVC")
    }
    
    
    @IBAction func onLogoutPressed(_ sender: UIButton) {
        goto(storyBoardName: "Tab", storyBoardID: "tasksVC")
    }
    
    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        objectsArray = [ Objects(sectionName: "section1", sectionObjects: ["akshay", "vinay", "karthik", "sumanth"]), Objects(sectionName: "section2", sectionObjects: ["akshay", "vinay", "karthik", "sumanth"]), Objects(sectionName: "section3", sectionObjects: ["akshay", "vinay", "karthik", "sumanth"]), Objects(sectionName: "section4", sectionObjects: ["akshay", "vinay", "karthik", "sumanth"]), Objects(sectionName: "section5", sectionObjects: ["akshay", "vinay", "karthik", "sumanth"]) ]
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "accountCell") as! UITableViewCell!
        cell?.textLabel?.text = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        
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
