//
//  PerformanceVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/3/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class PerformanceVC: UIViewController {
    
   
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

        // Do any additional setup after loading the view.
    }

   

}
