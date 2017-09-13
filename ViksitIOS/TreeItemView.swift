//
//  TreeItemView.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/13/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class TreeItemView: UIView {

    @IBOutlet var itemTextLabel: SymbolTextLabel!
    @IBOutlet var view: UIView!
    @IBOutlet var itemChildStack: UIStackView!

    
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
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TreeItemView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func addChildItem(text: String){
        let symbolTextLabel = SymbolTextLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        symbolTextLabel.symbolLabel.text = "\u{2022}"
        symbolTextLabel.textLabel.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        symbolTextLabel.setFontSize(textSize: 20)

        itemChildStack.addArrangedSubview(symbolTextLabel)
    }

    
}
