//
//  TabBarController.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/27/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    @IBOutlet var tabbar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //changing tint color of tab bar
        tabbar.tintColor = UIColor.Custom.themeColor
        tabbar.backgroundColor = UIColor.white   //The rest of your code

    }

}
