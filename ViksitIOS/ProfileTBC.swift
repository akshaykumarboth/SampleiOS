//
//  ProfileTBC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/3/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ProfileTBC: UITabBarController {

    @IBOutlet var tabbar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabbar.tintColor = UIColor(red: 235/255, green: 56/255, blue: 79/255, alpha: 1.00)
        tabbar.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
    }

}
