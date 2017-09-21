//
//  DummVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class DummVC: UIViewController {
    
    
    @IBOutlet var stack: UIStackView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let option: TickOptionView = TickOptionView(frame: CGRect.zero)
        option.optionText.text = "thiw is for the pourpose of tetsti g in fi os thiw is for the pourpose of tetsti g in fi os  thiw is for the pourpose of tetsti g in fi os  "
        stack.addArrangedSubview(option)
        

        // Do any additional setup after loading the view.
    }

   
}
