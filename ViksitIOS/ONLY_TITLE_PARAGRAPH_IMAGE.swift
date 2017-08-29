//
//  ONLY_TITLE_PARAGRAPH_IMAGE.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ONLY_TITLE_PARAGRAPH_IMAGE: UIViewController {
    
    @IBOutlet var gifImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var para: UILabel!
    @IBOutlet var imageView: UIImageView!
    var slide: CMSlide = CMSlide()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = slide.title.text
        para.attributedText = Helper.setHTMLString(testString: slide.paragraph.text, fontsize: "18")
        ImageAsyncLoader.loadImageAsync(url: slide.image.url, imgView: gifImageView)

        // Do any additional setup after loading the view.
    }

}
