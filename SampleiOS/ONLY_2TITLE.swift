//
//  GreenVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ONLY_2TITLE: UIViewController {
    
    
    @IBOutlet var title2Label: UILabel!
    @IBOutlet var title1Label: UILabel!
    @IBOutlet var gifImageView: UIImageView!
    
    var slide: CMSlide = CMSlide()

    override func viewDidLoad() {
        super.viewDidLoad()

        print(slide.templateName)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        title1Label.text = slide.title.text.trimmingCharacters(in: .whitespacesAndNewlines)
        title2Label.text = slide.title2.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if (slide.image_BG != "null" || slide.image_BG != "none"){
            ImageAsyncLoader.loadImageAsync(url: slide.image_BG, imgView: gifImageView)
        } else {
            if !(slide.image.url.contains("ToDo.png")) {
                ImageAsyncLoader.loadImageAsync(url: slide.image.url, imgView: gifImageView)
            }
        }
    }

    

}
