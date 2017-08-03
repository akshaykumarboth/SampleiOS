//
//  TasksVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/26/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class TasksVC: UIViewController {

    
    @IBOutlet var profileBtn: UIButton!
    
    @IBAction func onNotificationPressed(_ sender: UIButton) {
        goto(storyBoardName: "Modules", storyBoardID: "NotificationsVC")
        
    }
    
    @IBAction func onProfilePressed(_ sender: UIButton) {
        goto(storyBoardName: "Modules", storyBoardID: "NotificationsVC")
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.tintColor = UIColor(red: 235/255, green: 56/255, blue: 79/255, alpha: 1.00)
        self.tabBarController?.tabBar.backgroundColor = UIColor.white        //The rest of your code
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var profileImgUrl: String = ""
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            profileImgUrl = (ComplexObject(JSONString: complexCache).studentProfile?.profileImage)!
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
