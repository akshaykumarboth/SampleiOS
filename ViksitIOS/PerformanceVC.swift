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

   

}
