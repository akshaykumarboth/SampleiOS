//
//  ONLYTITLE.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ONLY_TITLE: UIViewController {
    
    var slide: CMSlide = CMSlide()
    @IBOutlet var titel: UILabel!
    @IBOutlet var gifImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("templateName:   \(slide.templateName)")
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        titel.text = slide.title.text
        if !(slide.image.url.contains("ToDo.png")) {
            ImageAsyncLoader.loadImageAsync(url: slide.image.url, imgView: gifImageView)
        }
    }

}
