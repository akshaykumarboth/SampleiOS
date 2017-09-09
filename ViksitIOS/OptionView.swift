//
//  OptionView.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/7/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class OptionView: UIView {

    @IBOutlet var optionText: UITextView!
    @IBOutlet var optionContainer: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setBorderColor(color: UIColor) {
        optionContainer.backgroundColor = color
    }
    
    func setup(){
        
        optionContainer = loadViewFromNib()
        optionContainer.frame = self.bounds
        optionContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(optionContainer)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "OptionView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
