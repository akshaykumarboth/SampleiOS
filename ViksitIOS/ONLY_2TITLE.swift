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

        print("slide id is ",slide.id)
        
        title1Label.text = slide.title.text.trimmingCharacters(in: .whitespacesAndNewlines)
        title2Label.text = slide.title2.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        ImageAsyncLoader.loadImageAsync(url: slide.image.url, imgView: gifImageView)
        // Do any additional setup after loading the view.
    }

    

}
