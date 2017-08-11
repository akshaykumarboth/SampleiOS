//
//  GrandChildSkillItem.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/10/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class GrandChildSkillItem: UIView {

    @IBOutlet var grandChildSkillView: UIView!
    
    @IBOutlet var grandChildSkillNameLabel: UILabel!
    
    @IBOutlet var grandChildSkillProgress: UIProgressView!
    
    var view: UIView!
    
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
        let nib = UINib(nibName: "GrandChildSkillItem", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

    
}
