//
//  ONLYTITLETREE.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ONLY_TITLE_TREE: UIViewController {
    var slide: CMSlide = CMSlide()
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var treeStack: UIStackView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //set everything here not in viewDidLoad
        treeStack.subviews.forEach { $0.removeFromSuperview() } // removing all subviews
        
        titleLabel.text = slide.title.text
        if slide.list.items.count > 0 {
            for item in slide.list.items {
                print(item.text)
                
                let treeItem = TreeItemView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                treeItem.itemTextLabel.textLabel.text = item.text
                if item.childList.items.count > 0 {
                    for child in item.childList.items {
                        treeItem.addChildItem(text: child.text)
                    }
                }
                
                treeStack.addArrangedSubview(treeItem)
                
            }
        }
        
        
        
    }

    

}
