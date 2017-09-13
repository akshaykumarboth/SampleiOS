//
//  ONLY_TITLE_PARAGRAPH_IMAGE_LIST.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ONLY_TITLE_PARAGRAPH_IMAGE_LIST: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var paraStack: UIStackView!
    @IBOutlet var gifImageView: UIImageView!
    
    var slide: CMSlide = CMSlide()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        paraStack.subviews.forEach { $0.removeFromSuperview() } // removing all subviews
        titleLabel.text = slide.title.text
        for item in slide.list.items {
            print(item.text)
            ThemeUtil.setParaListTextLabelCustom(text: item.text, paraStack: paraStack)
        }
        
        if (slide.image_BG != "null" || slide.image_BG != "none"){
            ImageAsyncLoader.loadImageAsync(url: slide.image_BG, imgView: gifImageView)
        } else {
            if !(slide.image.url.contains("ToDo.png")) {
                ImageAsyncLoader.loadImageAsync(url: slide.image.url, imgView: gifImageView)
            }
        }
    }

    
}
