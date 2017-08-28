//
//  ONLY_TITLE_PARAGRAPH.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ONLY_TITLE_PARAGRAPH: UIViewController {
    
    
    @IBOutlet var gifImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var paraWebView: DynamicTextWebView!
    var slide: CMSlide = CMSlide()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        paraWebView.setText(text: slide.paragraph.text, font: 18)
        titleLabel.text = slide.title.text
        ImageAsyncLoader.loadImageAsync(url: slide.image.url, imgView: gifImageView)

        // Do any additional setup after loading the view.
    }

    

}
