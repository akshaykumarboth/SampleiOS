//
//  ONLY_PARAGRAPH.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ONLY_PARAGRAPH: UIViewController {
    
    
    @IBOutlet var gifImageView: UIImageView!
    @IBOutlet var paraStack: UIStackView!
    //@IBOutlet var textView: UILabel!
    
    var slide: CMSlide = CMSlide()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("slide id is \(slide.id)")
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        paraStack.subviews.forEach { $0.removeFromSuperview() } // removing all subviews
        
        let para: UILabel = UILabel()
        para.attributedText = Helper.setHTMLString(testString: slide.paragraph.text, fontsize: "8")
        
        paraStack.addArrangedSubview(para)
        if (slide.image_BG != "null" || slide.image_BG != "none"){
            ImageAsyncLoader.loadImageAsync(url: slide.image_BG, imgView: gifImageView)
        } else {
            if !(slide.image.url.contains("ToDo.png")) {
                ImageAsyncLoader.loadImageAsync(url: slide.image.url, imgView: gifImageView)
            }
        }
    }
    

}
