//
//  TasksVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/26/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class TasksVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var tasks: Array<Tasks> = []

    @IBOutlet var cards: UICollectionView!
    
    @IBOutlet var coinsBtn: UIButton!
    @IBOutlet var experiencePoints: UILabel!
    @IBOutlet var profileBtn: UIButton!
    
   
    @IBAction func onCoinsPressed(_ sender: UIButton) {
        goto(storyBoardName: "Profile", storyBoardID: "LeaderboardVC")
    }
    
    @IBAction func onNotificationPressed(_ sender: UIButton) {
        goto(storyBoardName: "Modules", storyBoardID: "NotificationsVC")
        
    }
    
    @IBAction func onProfilePressed(_ sender: UIButton) {
        goto(storyBoardName: "Profile", storyBoardID: "ProfileTBC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var profileImgUrl: String = ""
        var xp: Int = 0
        var coins: Int = 0
        
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            tasks = (ComplexObject(JSONString: complexCache).tasks)!
            profileImgUrl = (ComplexObject(JSONString: complexCache).studentProfile?.profileImage)!
            xp = (ComplexObject(JSONString: complexCache).studentProfile?.experiencePoints)!
            coins = (ComplexObject(JSONString: complexCache).studentProfile?.coins)!
        }
        
        //inserting image from url async
        let url = URL(string: profileImgUrl)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                if data != nil {
                    self.profileBtn.setBackgroundImage(UIImage(data: data!), for: .normal)
                } else {
                    self.profileBtn.setBackgroundImage(UIImage(named: "coins"), for: .normal)
                }
                
            }
        }
        profileBtn = makeButtonRound(button: profileBtn, borderWidth: 2, color: UIColor.white)
        
        //set userpoints in toolbar
        coinsBtn.setTitle(" " + String(coins), for: .normal)
        experiencePoints.text = String(xp)
        
           }
    
    func makeButtonRound(button: UIButton, borderWidth: CGFloat, color: UIColor)-> UIButton{
        button.layer.cornerRadius = button.frame.width/2
        button.layer.masksToBounds = true
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = color.cgColor
        
        return button
    }

    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    
    //
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if tasks[indexPath.row].itemType == "LESSON_PRESENTATION" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "presentationCell", for: indexPath) as! PresentationCell
            
            cell.headerLabel.text = tasks[indexPath.row].header
            cell.titleLabel.text = tasks[indexPath.row].title
            cell.descriptionLabel.text = tasks[indexPath.row].description
            loadImageAsync(url: tasks[indexPath.row].imageURL!, imgView: cell.lessonImage)
            cell.videoImg.isHidden = true
            
            return cell
        } else if tasks[indexPath.row].itemType == "CLASSROOM_SESSION_STUDENT" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "assessmentCell", for: indexPath) as! AssessmentCell
            
            cell.headerLabel.text = tasks[indexPath.row].header
            cell.titleLabel.text = tasks[indexPath.row].title
            loadImageAsync(url: tasks[indexPath.row].imageURL!, imgView: cell.assessmentImg)
            cell.descriptionLabel.text = tasks[indexPath.row].classRoomName
            
            if let hrs = tasks[indexPath.row].durationHours {
                
                cell.numOfQuesLabel.text = String(hrs) + " hrs"
            }
            cell.quesText.text = "Duration"
            if let y = tasks[indexPath.row].classRoomId {
                cell.pointsLabel.text = "#" + String(y)
            }
            cell.xpText.text = "classRoom Id"
            cell.durationLabel.text = getSubstring(str: tasks[indexPath.row].time!, startOffest: 0, endOffset: -3)
            cell.timeText.text = "Time"
            
            cell.startBtn.setTitle("START CLASS", for: .normal)
            
            return cell
        } else if tasks[indexPath.row].itemType == "LESSON_VIDEO"{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "presentationCell", for: indexPath) as! PresentationCell
            
            cell.headerLabel.text = tasks[indexPath.row].header
            cell.titleLabel.text = tasks[indexPath.row].title
            cell.descriptionLabel.text = tasks[indexPath.row].description
            loadImageAsync(url: tasks[indexPath.row].imageURL!, imgView: cell.lessonImage)
            
            cell.videoImg.isHidden = false
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "presentationCell", for: indexPath) as! PresentationCell
            
            return cell
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        
        return CGSize(width: (cards.frame.width * 0.75), height: cards.frame.height * 0.75); //use height whatever you wants.
    }
    
    
   
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth:Float = Float(cards!.frame.size.width * 0.9)
        let currentOffSet:Float = Float(scrollView.contentOffset.x)
        
        let targetOffSet:Float = Float(targetContentOffset.pointee.x)
        
        var newTargetOffset:Float = 0
        
        if(targetOffSet > currentOffSet){
            newTargetOffset = ceilf(currentOffSet / pageWidth) * pageWidth
        }else{
            newTargetOffset = floorf(currentOffSet / pageWidth) * pageWidth
        }
        
        if(newTargetOffset < 0){
            newTargetOffset = 0;
        }else if (newTargetOffset > Float(scrollView.contentSize.width)){
            newTargetOffset = Float(scrollView.contentSize.width)
        }
        
        targetContentOffset.pointee.x = CGFloat(currentOffSet)
        scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: 0), animated: true)
        
    }
 
    
    override var prefersStatusBarHidden : Bool {
        return true
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
                        imgView.image = UIImage(named: "info")
                    }
                                    }
            }
        }catch let error as NSError {
            print(" Error \(error)")
        }
    }
    
    
    
    func getSubstring (str: String, startOffest: Int, endOffset: Int)-> String {
        let start = str.index(str.startIndex, offsetBy: startOffest)
        let end = str.index(str.endIndex, offsetBy: endOffset)
        let range = start..<end
        
        return str[range]
    }

    

}
