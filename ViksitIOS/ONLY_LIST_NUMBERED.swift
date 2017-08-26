//
//  ONLY_LIST_NUMBERED.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ONLY_LIST_NUMBERED: UIViewController {
    
    
    @IBOutlet var listStack: UIStackView!
    @IBOutlet var gifImageView: UIImageView!
    
    var slide: CMSlide = CMSlide()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if slide.list.items.count > 0 {
            var count = 1
            for item in slide.list.items {
                print(item.text)
                ThemeUtil.setNumberListItemTextLabel(number: "\(count)", text: item.text, listStack: listStack)
                count += 1
                
            }
        }
        ImageAsyncLoader.loadImageAsync(url: slide.image.url, imgView: gifImageView)        // Do any additional setup after loading the view.
        
    }

    

}
