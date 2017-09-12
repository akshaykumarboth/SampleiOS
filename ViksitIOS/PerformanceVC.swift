//
//  PerformanceVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/3/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class PerformanceVC: UIViewController {
    
    var studentProfile: StudentProfile?
    var skills: [Skills] = []
    var childSkills: [Skills] = []
    var grandChildSkills: [Skills] = []
    var selectedRowIndex: IndexPath = IndexPath(row: -1, section: 0)
    var isExpanded: Bool = false
    
    
    @IBOutlet var subSkillTableView: UITableView!
    @IBOutlet var skillCollections: UICollectionView!
    
    @IBOutlet var profileImage: CircularImage!
    @IBOutlet var userXPLabel: UILabel!
    @IBOutlet var userBatchRankLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    
    @IBAction func uploadPhotoPressed(_ sender: CircularButton) {
        let actionSheet = UIAlertController(title: "Change Photo", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: {
            action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            studentProfile = ComplexObject(JSONString: complexCache).studentProfile!
            skills = ComplexObject(JSONString: complexCache).skills!
        }
        
        ImageAsyncLoader.loadImageAsync(url: (studentProfile?.profileImage)!, imgView: profileImage)
        if let xp = studentProfile?.experiencePoints {
            userXPLabel.text = "\(xp)"
        }
        
        if let rank = studentProfile?.batchRank {
            userBatchRankLabel.text = "#" + "\(rank)"
        }
        
        if let name = studentProfile?.firstName {
            userNameLabel.text = name
        }
        childSkills = (skills.first?.skills)!
        
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    
}

extension PerformanceVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showCamera(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        
        present(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .photoLibrary
        
        present(cameraPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
    
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage  {
            profileImage.image = image
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

}

extension PerformanceVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skills.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "superSkillCell", for: indexPath) as! SuperSkillCell
        
        cell.superSkillName.text = skills[indexPath.row].name
        //loading image async
        ImageAsyncLoader.loadImageAsync(url: (skills[indexPath.row].imageURL)!, imgView: cell.superSkillImage)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: skillCollections.frame.height * 0.9, height: skillCollections.frame.height) //use height whatever you wants.
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print((skills[indexPath.row].name)!)
        
        for skill in skills{
            if skill.name == (skills[indexPath.row].name)! {
                childSkills = skill.skills!
            }
        }
        
        self.subSkillTableView.reloadData()
    }

}

extension PerformanceVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let openViewHeight: Int = 58
        
        if (indexPath.row == selectedRowIndex.row && isExpanded == false){
            isExpanded = true
            return CGFloat(openViewHeight + 38 * (childSkills[indexPath.row].skills?.count)!)
            
        } else if (indexPath.row == selectedRowIndex.row && isExpanded == true){
            isExpanded = false
            return CGFloat(openViewHeight)
        } else {
            isExpanded = false
            return CGFloat(openViewHeight)
        }
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childSkills.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(childSkills[indexPath.row].name)
        selectedRowIndex = indexPath
        tableView.beginUpdates()
        
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "SubSkillTableCell", for: indexPath) as! SubSkillTableCell
        let cell = tableView.cellForRow(at: indexPath) as! SubSkillTableCell
        
        for subview in cell.grandSkillStack.subviews {
            subview.removeFromSuperview()
        }
        
        var grandSkillView: GrandChildSkillItem
        grandChildSkills = (childSkills[indexPath.row].skills)!
        for grandchildskill in grandChildSkills {
            grandSkillView = GrandChildSkillItem(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
            grandSkillView.grandChildSkillNameLabel.text = grandchildskill.name
            grandSkillView.grandChildSkillProgress.progress = Float(grandchildskill.percentage!)
            
            cell.grandSkillStack.addArrangedSubview(grandSkillView)
        }
        
        tableView.endUpdates()
        
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubSkillTableCell", for: indexPath) as! SubSkillTableCell
        cell.subSkillName.text = childSkills[indexPath.row].name
        cell.subSkillProgress.progress = Float(childSkills[indexPath.row].percentage!)
        
        if let uPoints = childSkills[indexPath.row].userPoints  {
            if let tPoints = childSkills[indexPath.row].totalPoints {
                if let count = childSkills[indexPath.row].skills?.count {
                    cell.subSkillDetail.text = "\(uPoints)" + "/" + "\(tPoints)" + "XP \u{2022} " + "\(count)" + " subskills"
                }
                
            }
        }
        
        return cell
    }

}
