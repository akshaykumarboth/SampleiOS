//
//  ONLYLIST.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ONLY_LIST: UIViewController {
    
    @IBOutlet var gifImageView: UIImageView!
    @IBOutlet var listStack: UIStackView!
    
    var slide: CMSlide = CMSlide()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(slide.templateName)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        listStack.subviews.forEach { $0.removeFromSuperview() } // removing all subviews
        if slide.list.items.count > 0 {
            for item in slide.list.items {
                //print(item.text)
                if item.text != "" {
                    ThemeUtil.setListItemTextLabelCustom(text: item.text, listStack: listStack)
                }
                
            }
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
