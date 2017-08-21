//
//  XmlVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class XmlVC: UIViewController {

    
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf:(NSURL(string:"http://images.apple.com/main/rss/hotnews/hotnews.rss"))! as URL)!
        parser.delegate = self as! XMLParserDelegate
        parser.parse()
        //tbData!.reloadData()
    }
    
}
