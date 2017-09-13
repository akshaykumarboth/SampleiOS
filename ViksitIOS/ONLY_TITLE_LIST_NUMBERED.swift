//
//  ONLY_TITLE_LIST_NUMBERED.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ONLY_TITLE_LIST_NUMBERED: UIViewController {
    
    @IBOutlet var gifImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var listStack: UIStackView!
    var slide: CMSlide = CMSlide()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("slide id is",slide.id)
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        listStack.subviews.forEach { $0.removeFromSuperview() } // removing all subviews
        titleLabel.text = slide.title.text.trimmingCharacters(in: .whitespacesAndNewlines)
        var count = 1
        if slide.list.items.count > 0 {
            for item in slide.list.items {
                ThemeUtil.setNumberListItemTextLabelCustom(number: String(count), text: item.text, listStack: listStack)
                count += 1
            }
        }
        if !(slide.image.url.contains("ToDo.png")) {
            ImageAsyncLoader.loadImageAsync(url: slide.image.url, imgView: gifImageView)
        }
    }
    

}
