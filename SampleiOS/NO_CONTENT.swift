//
//  RedVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class NO_CONTENT: UIViewController {
    
    @IBOutlet var gifImageView: UIImageView!
    var slide: CMSlide = CMSlide()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(slide.templateName)
    
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //print(slide.image.url)
        if (slide.image_BG != "null" || slide.image_BG != "none"){
            ImageAsyncLoader.loadImageAsync(url: slide.image_BG, imgView: gifImageView)
        } else{
            if !(slide.image.url.contains("ToDo.png")) {
                ImageAsyncLoader.loadImageAsync(url: slide.image.url, imgView: gifImageView)
            }
        }
        
        
    }

    
}
