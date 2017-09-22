//
//  AssessmentReportVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class AssessmentReportVC: UIViewController {
    
    //var backTag = ""
    var assessmentReport: AssessmentReports!
    var skills: [SkillsReport] = []
    var childSkills: [Skills] = []
    var selectedRowIndex: IndexPath = IndexPath(row: -1, section: 0)
    var isExpanded: Bool = false
    
    @IBOutlet var reportTitleLabel: UILabel!
    @IBOutlet var userScoreLabel: UILabel!
    @IBOutlet var totalScoreLabel: UILabel!
    @IBOutlet var accuracyLabel: UILabel!
    @IBOutlet var batchAvgLabel: UILabel!
    @IBOutlet var studentsAttemptedLabel: UILabel!
    @IBOutlet var skillTableView: UITableView!
    @IBOutlet var reviewQuestionsBtn: UIButton!
    @IBOutlet var repeatAssessmentBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        reportTitleLabel.text = assessmentReport.name
        userScoreLabel.text = "\(assessmentReport.userScore)"
        totalScoreLabel.text = "/\(assessmentReport.totalScore)"
        accuracyLabel.text = "\(assessmentReport.accuracy)"
        batchAvgLabel.text = "\(assessmentReport.batchAverage)"
        studentsAttemptedLabel.text  = "\(assessmentReport.usersAttemptedCount) of \(assessmentReport.totalNumberOfUsersInBatch) students have attempted this assessment."
    }

    

}

extension AssessmentReportVC: UITableViewDelegate, UITableViewDataSource {
    
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
            return CGFloat(openViewHeight + 38 * (skills[indexPath.row].skills?.count)!)
            
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
