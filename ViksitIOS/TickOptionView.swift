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
        
        addSubview(optionContainer)
    }
    
    func setBorder(color: UIColor, borderWidth: CGFloat) {
        optionContainer.layer.borderWidth = borderWidth
        optionContainer.layer.borderColor = color.cgColor
    }
    
    func removeBorder() {
        optionContainer.layer.borderWidth = 0
    }
    
    func setbackgroundColor(color: UIColor) {
        optionContainer.backgroundColor = color
    }
    
    func hideImage() {
        imageWidth.constant = 0
    }
    
    func showImage(image: UIImage) {
        optionImg.image = image
        imageWidth.constant = 40
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TickOptionView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
