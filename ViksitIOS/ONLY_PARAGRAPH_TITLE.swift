//
//  ONLY_PARAGRAPH_TITLE.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ONLY_PARAGRAPH_TITLE: UIViewController {

    @IBOutlet var gifImageView: UIImageView!
    @IBOutlet var para: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    var slide: CMSlide = CMSlide()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //paraWebView.setText(text: slide.paragraph.text, font: 18)
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        para.attributedText = Helper.setHTMLString(testString: slide.paragraph.text, fontsize: "18")
        titleLabel.text = slide.title.text
        if !(slide.image.url.contains("ToDo.png")) {
            ImageAsyncLoader.loadImageAsync(url: slide.image.url, imgView: gifImageView)
        }
    }
    

}
