//
//  RoleInfoVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/2/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class RoleInfoVC: UIViewController {

    var course: Courses?
    var skills: [Skills] = []
    var childSkills: [Skills] = []
    var selectedRowIndex: IndexPath = IndexPath(row: -1, section: 0)
    var isExpanded: Bool = false
    
    @IBOutlet var roleImage: UIImageView!
    @IBOutlet var roleNameLabel: UILabel!
    @IBOutlet var roleDescriptionLabel: UILabel!
    
    @IBOutlet var skillTableView: UITableView!
    

    @IBAction func onClosePressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Modules", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ModulesVC") as! ModulesVC
        nextViewController.course = course
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roleImage.layer.cornerRadius = roleImage.frame.size.width / 2
        roleImage.clipsToBounds = true
        
        roleNameLabel.text = course?.name
        roleDescriptionLabel.text = course?.description
        skills = (course?.skillObjectives)!
        
        //loading image from url async
        ImageAsyncLoader.loadImageAsync(url: (course?.imageURL)!, imgView: self.roleImage)
        
        
    }

}

extension RoleInfoVC: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubSkillTableCell", for: indexPath) as! SubSkillTableCell
        cell.subSkillName.text = skills[indexPath.row].name
        cell.subSkillProgress.progress = Float(skills[indexPath.row].percentage!)
        if let uPoints = skills[indexPath.row].userPoints  {
            if let tPoints = skills[indexPath.row].totalPoints {
                if let count = skills[indexPath.row].skills?.count {
                    cell.subSkillDetail.text = "\(uPoints)" + "/" + "\(tPoints)" + "XP \u{2022} " + "\(count)" + " subskills"
                }
                
            }
        }
        
        //cell.subSkillDetail.text = "250/500 XP \u{2022} 5 subskills"
        for subview in cell.grandSkillStack.subviews {
            subview.removeFromSuperview()
        }
        
        
        var grandSkillView: GrandChildSkillItem
        childSkills = (skills[indexPath.row].skills)!
        for grandchildskill in childSkills {
            grandSkillView = GrandChildSkillItem(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
            grandSkillView.grandChildSkillNameLabel.text = grandchildskill.name
            grandSkillView.grandChildSkillProgress.progress = Float(grandchildskill.percentage!)
            
            cell.grandSkillStack.addArrangedSubview(grandSkillView)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let openViewHeight: Int = 55
        
        if (indexPath.row == selectedRowIndex.row && isExpanded == false){
            isExpanded = true
            return CGFloat(openViewHeight + 36 * (skills[indexPath.row].skills?.count)!)
            
        } else if (indexPath.row == selectedRowIndex.row && isExpanded == true){
            isExpanded = false
            return CGFloat(openViewHeight)
        } else {
            isExpanded = false
            return CGFloat(openViewHeight)
        }
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(skills[indexPath.row].name)
        selectedRowIndex = indexPath
        tableView.beginUpdates()
        
        tableView.endUpdates()
        
    }
    
}
