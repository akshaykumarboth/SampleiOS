//
//  PerformanceVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/3/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class PerformanceVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    var studentProfile: StudentProfile?
    var skills: [Skills]?
    var childSkills: [Skills] = []
    
    @IBOutlet var childSkillTableView: UITableView!
    
    
    @IBOutlet var skillCollections: UICollectionView!
    
    @IBOutlet var profileImage: CircularImage!
    @IBOutlet var userXPLabel: UILabel!
    @IBOutlet var userBatchRankLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    
    var t_count: Int = 0
    var lastCell: StackViewCell = StackViewCell()
    var button_tag: Int = -1
    
    
    
    @IBAction func uploadPhotoPressed(_ sender: CircularButton) {
    }
    
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        goto(storyBoardName: "Tab", storyBoardID: "TabBarController")
    }
    
    
    @IBAction func onLogoutPressed(_ sender: UIButton) {
        goto(storyBoardName: "Tab", storyBoardID: "TabBarController")
    }
    

    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            studentProfile = ComplexObject(JSONString: complexCache).studentProfile!
            skills = ComplexObject(JSONString: complexCache).skills!
        }
        
        loadImageAsync(url: (studentProfile?.profileImage)!, imgView: profileImage)
        if let xp = studentProfile?.experiencePoints {
            userXPLabel.text = "\(xp)"
        }
        
        if let rank = studentProfile?.batchRank {
            userBatchRankLabel.text = "#" + "\(rank)"
        }
        
        if let name = studentProfile?.firstName {
            userNameLabel.text = name
        }
        
        
        //
        childSkills = (skills?[0].skills)!
        //childSkillTableView.layer.frame.size.height = view.frame.size.height
        childSkillTableView.register(UINib(nibName: "StackViewCell", bundle: nil), forCellReuseIdentifier: "StackViewCell")
        childSkillTableView.allowsSelection = true
        childSkillTableView.separatorStyle = .none
        
        //view.addSubview(tableView)
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skills!.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "superSkillCell", for: indexPath) as! SuperSkillCell
            
        cell.superSkillName.text = skills?[indexPath.row].name
        //loading image async
        loadImageAsync(url: (skills?[indexPath.row].imageURL)!, imgView: cell.superSkillImage)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: skillCollections.frame.height * 0.9, height: skillCollections.frame.height) //use height whatever you wants.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print((skills?[indexPath.row].name)!)
        
        for skill in skills!{
            if skill.name == (skills?[indexPath.row].name)! {
                childSkills = skill.skills!
                for child in childSkills {
                    print("childname->  \(child.name)")
                }
                
            }
        }
        DispatchQueue.main.async{
            self.childSkillTableView.reloadData()
        }

       
    }
    
    
    //table view implementation
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var openViewHeight: Int = 80
        
        if indexPath.row == button_tag {
            return CGFloat(openViewHeight + 200)
        } else {
            return CGFloat(openViewHeight)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if childSkills.count != 0 {
            return childSkills.count
        }
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StackViewCell", for: indexPath) as! StackViewCell
        
        if !cell.cellExists {
            cell.childSkillNameLabel.text = childSkills[indexPath.row].name
            cell.childSkillProgress.progress = Float ((childSkills[indexPath.row].percentage)!/100)
            cell.childSkillDetailsLabel.text = "\(childSkills[indexPath.row].userPoints!)/\(childSkills[indexPath.row].totalPoints!) XP   \u{2022} \(childSkills[indexPath.row].skills?.count) subskills"
            
            var grandchildSkillView: GrandChildSkillItem
            
            for grandChildSkill in (childSkills[indexPath.row].skills)! {
                grandchildSkillView = GrandChildSkillItem()
                if grandChildSkill.name! != nil {
                    //grandchildSkillView.grandChildSkillName.text = grandChildSkill.name!
                } else {
                    grandchildSkillView.grandChildSkillName.text = ""
                }
                
                //grandchildSkillView.grandChildSkillProgress.progress = Float(grandChildSkill.percentage!/100)
                cell.grandChildStackView.addSubview(grandchildSkillView)
            }
            
            //cell.touchView.tag = t_count
            //cell.touchView.addTarget(self, action: #selector(cellOpened(sender:)), for: .touchUpInside)
            t_count += 1
            cell.cellExists = true
        }
        
        UIView.animate(withDuration: 0){
            cell.contentView.layoutIfNeeded()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // cellOpened(sender: <#T##UIButton#>)
    }
    
    func cellOpened(sender: UIButton) {
        print("cell iopened ")
        self.childSkillTableView.beginUpdates()
        
        
        let previosCellTag = button_tag
        if lastCell.cellExists {
            self.lastCell.animate(duration: 0.2, c: {
                self.view.layoutIfNeeded()
            })
            
            if sender.tag == button_tag {
                button_tag = -1
                lastCell = StackViewCell()
            }
        }
        
        if sender.tag != previosCellTag {
            button_tag = sender.tag
            
            lastCell = childSkillTableView.cellForRow(at: IndexPath(row: button_tag, section: 0)) as! StackViewCell
            self.lastCell.animate(duration: 0.2, c: {
                self.view.layoutIfNeeded()
            })
        }
        
        self.childSkillTableView.endUpdates()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
   

}
