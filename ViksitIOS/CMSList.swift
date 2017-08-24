//
//  CMSParagraph.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/22/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation
import SWXMLHash

class CMSList {
    var list_type: String = ""
    var mergedAudioURL: String = ""
    var mergedAudioDuration: Int = -1
    var items: [CMSTextItem] = []
    
    init() {
        self.list_type = ""
        self.mergedAudioURL = ""
        self.mergedAudioDuration = -1
        self.items = []
    }
    
    init(xml: XMLIndexer) {
        do {
            if let xml: XMLIndexer = xml {
                //for attributes
                for (key, value) in (xml.element?.allAttributes)! {
                    //print("list ",key, "  ", value.text)
                    
                    
                    if key == "merged_audio" {
                        self.mergedAudioURL = value.text
                        //print("list mergedAudioURL is ",self.mergedAudioURL )
                    }
                    
                    if key == "list_type" {
                        self.list_type = value.text
                        //print("list list_type is ",self.list_type )
                    }
                    
                }
                
                if let mergedAudioDuration = xml["mergedAudioDuration"].element?.text {
                    self.mergedAudioDuration = Int(mergedAudioDuration)!
                    //print("list mergedAudioDuration is ",self.mergedAudioDuration )
                }
                
                if let x: Int = xml.children.count {
                    var list2: Array<CMSTextItem> = []
                    for i in 0..<x {
                       //print("list item",xml.children[i].element?.name)
                        if xml.children[i].element?.name == "li" {
                            list2.append(CMSTextItem(xml: xml.children[i]))
                        }
                    }
                    self.items = list2
                }
                
                
            }
        } catch let error as IndexingError {
            // error is an IndexingError instance that you can deal with
            print("error -> \(error)")
            
        }
    }
}
