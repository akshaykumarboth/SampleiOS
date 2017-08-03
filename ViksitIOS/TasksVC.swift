//
//  TasksVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/26/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class TasksVC: UIViewController {

    @IBOutlet var coinsBtn: UIButton!
    
    
    @IBOutlet var profileBtn: UIButton!
    
   
    
    
    @IBAction func onNotificationPressed(_ sender: UIButton) {
        goto(storyBoardName: "Modules", storyBoardID: "NotificationsVC")
        
    }
    
    @IBAction func onProfilePressed(_ sender: UIButton) {
        goto(storyBoardName: "Profile", storyBoardID: "ProfileTBC")
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.tintColor = UIColor(red: 235/255, green: 56/255, blue: 79/255, alpha: 1.00)
        self.tabBarController?.tabBar.backgroundColor = UIColor.white        //The rest of your code
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var profileImgUrl: String = ""
        var xp: Int = 0
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            profileImgUrl = (ComplexObject(JSONString: complexCache).studentProfile?.profileImage)!
            xp = (ComplexObject(JSONString: complexCache).studentProfile?.experiencePoints)!
        }
        
        //inserting image from url async
        let url = URL(string: profileImgUrl)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.profileBtn.setBackgroundImage(UIImage(data: data!), for: .normal)
            }
        }
        profileBtn = makeButtonRound(button: profileBtn, borderWidth: 2, color: UIColor.white)
        
        //set userpoints in toolbar
        //userXpBtn.setTitle(String(xp) + " xp", for: .normal)
        var spacing: CGFloat = 10 // the amount of spacing to appear between image and title
        coinsBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
        coinsBtn.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);

        // Do any additional setup after loading the view.
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
    

}
