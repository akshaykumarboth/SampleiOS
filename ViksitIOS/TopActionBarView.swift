//
//  TopActionBarView.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/14/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class TopActionBarView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet var profileImgBtn: UIButton!
    @IBOutlet var notificationBtn: UIButton!
    @IBOutlet var coinsBtn: UIButton!
    @IBOutlet var xpLabel: UILabel!
    
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
        view.backgroundColor = UIColor.Custom.themeColor
        //view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "OptionView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
