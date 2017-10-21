//
//  CMSTitle.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/22/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation
import SWXMLHash

class CMSText {
    var type: String = ""
    var text: String = ""
    var fragmentAudioUrl: String = ""
    var fragmentDuration: Int = -1
    
    init() {
        self.text = ""
        self.fragmentAudioUrl = ""
        self.fragmentDuration = -1
    }
    
    init(xml : XMLIndexer){
        do {
            if let xml: XMLIndexer = xml {
                if let type = (xml.element?.name) {
                    self.type = type
                }
                
                //print("CMSText type is \(self.type)")
                //for attributes
                for (key, value) in (xml.element?.allAttributes)! {
                    //print("CMSText",key, "  ", value.text)
                    if key == "fragment_duration" {
                        self.fragmentDuration = Int(value.text)!
                        //print("CMSText fragmentDuration is ",self.fragmentDuration )
                    }
                    
                }
                
                if let text = xml.element?.text {
                    self.text = text
                    //print("CMSText text is \(self.text)")
                }
            }
        } catch let error as IndexingError {
            
            print("error -> \(error)")
        }
    }
}
