//
//  TickOptionView.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class TickOptionView: UIView {
    @IBOutlet var optionText: UITextView!
    @IBOutlet var optionContainer: UIView!
    @IBOutlet var optionImg: UIImageView!
    @IBOutlet var imageWidth: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        
        optionContainer = loadViewFromNib()
        optionContainer.frame = self.bounds
        optionContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        optionContainer.layer.borderWidth = 4
        optionContainer.layer.borderColor = UIColor.red.cgColor
        
        addSubview(optionContainer)
    }
    
    func setBorderColor(color: UIColor) {
        optionContainer.backgroundColor = color
        optionContainer.layer.borderWidth = 4
        //optionContainer.layer.borderColor = UIColor.Custom.themeColor
    }
    
    func hideImage() {
        imageWidth.constant = 0
    }
    
    func showImage() {
        imageWidth.constant = 40
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TickOptionView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
