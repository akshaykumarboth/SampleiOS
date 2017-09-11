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
        textLabel.font?.withSize(textSize)
        //textLabel.font = UIFont(name: (textLabel.font?.fontName)!, size: textSize)
    }
    
    func setText(text: String, symbolCode: String){
        textLabel.text = text
        symbolLabel.text = symbolCode
        //symbolSpacingConstraint.constant = symbolLabel.frame.width + 5
        //textLabel.numberOfLines = 15
        ///textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    
    func setAttributedText(text: String, symbolCode: String){
        //textLabel.text = text
        symbolLabel.attributedText = setHTMLString(testString: symbolCode)
        textLabel.attributedText = setHTMLString(testString: text)
        //symbolSpacingConstraint.constant = symbolLabel.frame.width + 5
        //textLabel.numberOfLines = 15
        ///textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    
    func setHTMLString(testString: String) -> NSAttributedString {
        //let str = ThemeUtil.wrapInHtml(body: testString, fontsize: fontsize)
        // if the string is not wrapped in html tags then wrap it and uncomment above line
        let str = testString
        let attrStr = try! NSAttributedString(
            data: str.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        //textview.attributedText = attrStr
        return attrStr
    }

    
    //set space between symbol and the text
    func setSpacing(spacing: CGFloat){
        symbolSpacingConstraint.constant = spacing
        view.layoutIfNeeded()
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
