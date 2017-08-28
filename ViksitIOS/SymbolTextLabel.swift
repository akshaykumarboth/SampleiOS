//
//  BulletTextView.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/26/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class SymbolTextLabel: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var symbolSpacingConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
    }
    
    func setFontSize(textSize: CGFloat){
        //symbolLabel.font =  UIFont().withSize(textSize)
        //textLabel.font =  UIFont().withSize(textSize)
        symbolLabel.font.withSize(textSize)
        textLabel.font.withSize(textSize)
    }
    
    func setText(text: String, symbolCode: String){
        textLabel.text = text
        symbolLabel.text = symbolCode
        textLabel.numberOfLines = 15
        textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    
    //set space between symbol and the text
    func setSpacing(spacing: CGFloat){
        symbolSpacingConstraint.constant = spacing
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SymbolTextLabel", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
}



//let u = SymbolTextView(frame: CGRect.zero)
//let v = SymbolTextView()
