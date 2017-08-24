//
//  ONLYTITLELIST.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class ONLY_TITLE_LIST: UIViewController {
    
    var slide: CMSlide = CMSlide()

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var listStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("id ",slide.id)
        print("list is \(slide.list.items.count)")
        
        //let trimmedString = myString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        titleLabel.text = slide.title.text.trimmingCharacters(in: .whitespacesAndNewlines)
        //var textLabel: UILabel = UILabel()
        if slide.list.items.count > 0 {
            for item in slide.list.items {
                print(item.text)
                //text.append(item.text.trimmingCharacters(in: .whitespacesAndNewlines) + "\n")
                //var textLabel = UILabel(CGRect(x: 0, y: 0, width: 300, height: 30))
                var textLabel: UILabel = UILabel()
                textLabel.text = item.text.trimmingCharacters(in: .whitespacesAndNewlines)
                textLabel.font.withSize(20)
                textLabel.numberOfLines = 3
                textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                
                listStack.addArrangedSubview(textLabel)
            }
        }
        //listLabel.text = text
    }

    

}
