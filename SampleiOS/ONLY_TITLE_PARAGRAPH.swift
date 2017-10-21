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
    @IBOutlet var paragraphText: UITextView!
    var slide: CMSlide = CMSlide()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(slide.templateName)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //paragraphText.setht(text: slide.paragraph.text, font: 18)
        //paragraphText.setHTMLFromString(htmlText: slide.paragraph.text)
        titleLabel.text = slide.title.text
        
        //paragraphText.attributedText = Helper.setHTMLString(testString: slide.paragraph.text, fontsize: "14")
        paragraphText.setHTMLFromString(htmlText: slide.paragraph.text)
        paragraphText.font = paragraphText.font?.withSize(10)
        
        if (slide.image_BG != "null" || slide.image_BG != "none"){
            ImageAsyncLoader.loadImageAsync(url: slide.image_BG, imgView: gifImageView)
        } else {
            if !(slide.image.url.contains("ToDo.png")) {
                ImageAsyncLoader.loadImageAsync(url: slide.image.url, imgView: gifImageView)
            }
        }
    }

    

}
