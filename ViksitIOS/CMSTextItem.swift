//
//  CMSTextItem.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/22/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation
import SWXMLHash

class CMSTextItem {
    var text: String = ""
    var id: Int = 0
    var description: String = ""
    var fragmentAudioUrl: String = ""
    var fragmentDuration: Int = 0
    var childList: CMSList = CMSList()
    
    init(text: String, id: Int, description: String, fragmentAudioUrl: String, fragmentDuration: Int) {
        self.text = text
        self.id = id
        self.description = description
        self.fragmentAudioUrl = fragmentAudioUrl
        self.fragmentDuration = fragmentDuration
    }
    
    init(xml : XMLIndexer) {
        do {
            if let xml: XMLIndexer = xml {
            
                // for attributes
                for (key, value) in (xml.element?.allAttributes)! {
                    //print("list ",key, "  ", value.text)
                }
                
                if let description = xml["description"].element?.text {
                    self.description = description
                    //print("CMSTextItem description is ",self.description )
                }
                if let fragment_audio = xml["fragment_audio"].element?.text {
                    self.fragmentAudioUrl = fragment_audio
                    //print("CMSTextItem fragmentAudioUrl is ",self.fragmentAudioUrl )
                }
                if let id = xml["id"].element?.text {
                    self.id = Int(id)!
                    //print("CMSTextItem id is ",self.id )
                }
                if let text = xml["p"].element?.text {
                    self.text = text
                    //print("CMSTextItem text is ",self.text )
                }
                
                if let fragment_duration = xml["fragment_duration"].element?.text {
                    self.fragmentDuration = Int(fragment_duration)!
                    //print("CMSTextItem fragmentDuration is ",self.fragmentDuration )
                }
                
                if xml["ul"] != nil {
                    self.childList = CMSList(xml: xml["ul"])
                    //print("id is ",self.id )
                }

            }
            
        } catch let error as IndexingError {
            // error is an IndexingError instance that you can deal with
        }
    }
    
}
