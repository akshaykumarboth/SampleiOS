//
//  ONLYTITLEIMAGE.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ONLY_TITLE_IMAGE: UIViewController {
    
    @IBOutlet var gifImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    var slide: CMSlide = CMSlide()

    override func viewDidLoad() {
        super.viewDidLoad()

        print(slide.templateName)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        titleLabel.text = slide.title.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (slide.image_BG != "null" || slide.image_BG != "none"){
            ImageAsyncLoader.loadImageAsync(url: slide.image_BG, imgView: gifImageView)
        } else {
            if !(slide.image.url.contains("ToDo.png")) {
                ImageAsyncLoader.loadImageAsync(url: slide.image.url, imgView: gifImageView)
            }
        }
        
        
    }

    
}
