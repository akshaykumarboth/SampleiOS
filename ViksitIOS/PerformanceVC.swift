//
//  PerformanceVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/3/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class PerformanceVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var studentProfile: StudentProfile?
    var skills: [Skills]?
    
    @IBOutlet var skillCollections: UICollectionView!
    
    @IBOutlet var profileImage: CircularImage!
    @IBOutlet var userXPLabel: UILabel!
    @IBOutlet var userBatchRankLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    
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
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(skills?[indexPath.row].name)
        
        // Perform any action you want after a cell is tapped
        // Access the selected cell's index with the indexPath.row value
        
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
   

}
