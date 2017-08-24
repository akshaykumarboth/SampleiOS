//
//  LessonTestVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/24/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit
import SWXMLHash

class LessonTestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if DataCache.sharedInstance.cache["lesson"] == nil {
            let lessonResponse: String = Helper.makeHttpCall (url : "http://cdn.talentify.in:9999/lessonXMLs/163/163/163.xml", method: "GET", param: [:])
            DataCache.sharedInstance.cache["lesson"] = lessonResponse
        }
    }

    

}
