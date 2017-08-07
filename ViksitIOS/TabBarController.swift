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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
