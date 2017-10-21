//
//  CMSImage.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/22/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation
import SWXMLHash

class CMSMedia {
    var type: String  = ""//"video" or "image"
    var fragmentDuration: Int = 0
    var title: String = ""
    var url: String = ""
    var description: String = ""
    var fragmentAudioUrl: String = ""
    
    init() {
        self.type = ""
        self.fragmentDuration = -1
        self.title = ""
        self.url = ""
        self.description = ""
        self.fragmentAudioUrl = ""

    }
    
    init(xml : XMLIndexer) {
        
        do {
            if let xml: XMLIndexer = xml {
                if let type = (xml.element?.name) {
                    self.type = type
                }
                
                //for attributes
                if let attributes = (xml.element?.allAttributes) {
                    for (key, value) in attributes {
                        //print("image",key, "  ", value.text)
                        
                        if key == "url" {
                            self.url = value.text
                            //print("image url is ",self.url )
                        } else if key == "fragment_duration" {
                            self.fragmentDuration = Int(value.text)!
                            //print("image fragment_duration is ",self.fragmentDuration )
                        } else if key == "title" {
                            self.title = value.text
                            //print("image title is ",self.title )
                        }
                        
                    }
                }

                if let description = xml["description"].element?.text {
                    self.description = description
                }

            }
            
            

        } catch let error as IndexingError {
            // error is an IndexingError instance that you can deal with
            print("error -> \(error)")
            
        }
        
        
    }
}
