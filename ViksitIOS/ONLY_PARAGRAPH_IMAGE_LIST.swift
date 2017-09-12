//
//  ONLY_PARAGRAPH_IMAGE_LIST.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ONLY_PARAGRAPH_IMAGE_LIST: UIViewController {
    
    @IBOutlet var paraStack: UIStackView!
    
    @IBOutlet var gifImageView: UIImageView!
    @IBOutlet var imageView: UIImageView!
    
    var slide: CMSlide = CMSlide()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if slide.list.items.count > 0 {
            for item in slide.list.items {
                if item.text != "" {
                    print(item.text)
                    ThemeUtil.setParaListTextLabelCustom(text: item.text, paraStack: paraStack)
                }
            }
        }
        if !(slide.image.url.contains("ToDo.png")) {
            ImageAsyncLoader.loadImageAsync(url: slide.image.url, imgView: gifImageView)
        }
        
    }

    
}
