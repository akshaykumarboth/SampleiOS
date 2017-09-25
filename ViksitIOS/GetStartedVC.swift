//
//  GetStartedVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/24/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class GetStartedVC: UIViewController {
    
    @IBOutlet var appIconView: UIImageView!
    @IBOutlet var getStartedBTn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStartedBTn.backgroundColor = UIColor.Custom.themeColor
        
        // Do any additional setup after loading the view.
    }

}
