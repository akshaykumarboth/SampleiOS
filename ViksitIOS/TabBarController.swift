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
        tabbar.tintColor = UIColor(red: 235/255, green: 56/255, blue: 79/255, alpha: 1.00)
        tabbar.backgroundColor = UIColor.white        //The rest of your code

    }

}
