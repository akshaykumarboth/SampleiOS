//
//  Option.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/11/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation

public class Option {
    public var id: Int?
    public var text: String?
    public var isSelected: Bool = false
    
    init(json: [String: Any]){
        if json["id"] != nil {
            self.id = (json["id"] as! Int)
            //print("skill id is ",self.id! )
        }
        
        if json["text"] != nil {
            self.text = (json["text"] as! String)
            //print("skill id is ",self.id! )
        }
    }
}
