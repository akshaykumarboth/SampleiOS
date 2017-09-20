//
//  PurpleVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ONLY_2BOX: UIViewController {

    @IBOutlet var title1Label: UILabel!
    @IBOutlet var list1Stack: UIStackView!
    @IBOutlet var list2Stack: UIStackView!
    @IBOutlet var title2Label: UILabel!
    @IBOutlet var gifImageView: UIImageView!
    
    var slide: CMSlide = CMSlide()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("id ",slide.id)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        list1Stack.subviews.forEach { $0.removeFromSuperview() } // removing all subviews
        list2Stack.subviews.forEach { $0.removeFromSuperview() } // removing all subviews
        //setting title1, list1, title2
        title1Label.text = slide.title.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if slide.list.items.count > 0 {
            
            ThemeUtil.setListItemTextLabelCustom(text: slide.list.items[0].text, listStack: list1Stack)
            ThemeUtil.setListItemTextLabelCustom(text: slide.list.items[1].text, listStack: list2Stack)
            
        }
        title2Label.text = slide.title2.text.trimmingCharacters(in: .whitespacesAndNewlines)
        //setting bg Image
        if (slide.image_BG != "null" || slide.image_BG != "none"){
            ImageAsyncLoader.loadImageAsync(url: slide.image_BG, imgView: gifImageView)
        } else {
            if !(slide.image.url.contains("ToDo.png")) {
                ImageAsyncLoader.loadImageAsync(url: slide.image.url, imgView: gifImageView)
            }
        }
        
    }
    
    
    
}
