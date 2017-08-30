//
//  ModulesVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/2/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ModulesVC: UIViewController {
    
    var course: Courses?
    var modules: Array<Modules> = []
    
    
    @IBOutlet var progressLabel: UILabel!
    @IBOutlet var userPointsLabel: UILabel!
    @IBOutlet var totalPointsLabel: UILabel!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var roleTitle: UILabel!
    
    @IBAction func onInfoPressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Modules", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RoleInfoVC") as! RoleInfoVC
        nextViewController.course = course
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    func ordinal(i:Int)-> String{
        var sufixes: [String] = ["th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th"]
        switch (i % 100) {
            case 11,12,13:
                return String(i) + "th"
            default:
                return String(i) + sufixes[i % 10]
    
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        modules = (course?.modules)!
        // Do any additional setup after loading the view.
        
        progressLabel.text = String(Int( (course?.progress)!)) + "%"
        userPointsLabel.text = String(describing: (course?.userPoints)!) + " XP"
        totalPointsLabel.text = "of " + String(describing: (course?.totalPoints)!) + " XP earned"
        rankLabel.text = ordinal(i: (course?.rank)!)
        roleTitle.text = course?.name
    }

    @IBAction func onBackPressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Tab", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        
        nextViewController.selectedIndex = 1
        self.present(nextViewController, animated:true, completion:nil)
    }


}

extension ModulesVC: UITableViewDataSource, UITableViewDelegate  {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modules.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        let cell = tableView.dequeueReusableCell(withIdentifier: "moduleCell", for: indexPath) as! ModuleCell
        
        //inserting omage from url async
        ImageAsyncLoader.loadImageAsync(url: modules[indexPath.row].imageURL!, imgView: cell.moduleImage)
        cell.moduleNameLabel.text = modules[indexPath.row].name
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(modules[indexPath.row].id as Any)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Modules", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LessonVC") as! LessonVC
        
        nextViewController.lessons = modules[indexPath.row].lessons!
        nextViewController.course = course
        nextViewController.toolbarTitleText = modules[indexPath.row].name!
        self.present(nextViewController, animated:true, completion:nil)
    }
    
}
