//
//  XmlVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit
import SWXMLHash

class XmlVC: UIViewController {
    
    var cmSlide: CMSlide?
    var slideList: [CMSlide] = []
    @IBOutlet var lblNameData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xmlParsing()
        
        // Do any additional setup after loading the view.
    }

    
    func xmlParsing(){
        do {
            let lessonResponse: String = Helper.makeHttpCall (url : "http://cdn.talentify.in:9999/lessonXMLs/163/163/163.xml", method: "GET", param: [:])
            let xml = try! SWXMLHash.parse(lessonResponse)
            
            if xml["lesson"] != nil {
                var list2: Array<CMSlide> = []
                for i in 0..<xml["lesson"].children.count {
                    if xml["lesson"].children[i].element?.name == "slide" {
                        list2.append(CMSlide(xml: xml["lesson"].children[i] ))
                    }
                    print("\n")
                }
                self.slideList = list2
                
            }
        } catch let error as IndexingError {
            // error is an IndexingError instance that you can deal with
            print("error is -> \(error)")
        }
        
        
        

    }
    
}

