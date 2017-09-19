//
//  OneVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/19/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class OneVC: UIViewController {
    
    @IBAction func pressed(_ sender: UIButton) {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
        case .online(.wwan):
            print("Connected via WWAN")
        case .online(.wiFi):
            print("Connected via WiFi")
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Reach().monitorReachabilityChanges()

        // Do any additional setup after loading the view.
    }

    

}
