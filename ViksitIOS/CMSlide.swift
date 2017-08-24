//
//  Slide.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/22/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation
import SWXMLHash

class CMSlide {
    var image_BG: String = ""
    var transition: String = ""
    var title: CMSText = CMSText()
    var title2: CMSText = CMSText()
    var paragraph: CMSText = CMSText()
    var list: CMSList = CMSList()
    var image: CMSMedia = CMSMedia()
    var video: CMSMedia = CMSMedia()
    var background: String = ""
    var backgroundTransition: String = ""
    var position: String = ""
    var templateName: String = ""
    var teacherNotes: String = ""
    var studentNotes: String = ""
    var slideDuration: Int = 0
    var id: Int = -1
    var order_id: Int = -1
    var fragmentCount: Int = -1
    var slideAudio: String = ""
    
    init(){
        self.image_BG = ""
        self.transition = ""
        self.title = CMSText()
        self.title2 = CMSText()
        self.paragraph = CMSText()
        self.list = CMSList()
        self.image = CMSMedia()
        self.video = CMSMedia()
        self.background = ""
        self.backgroundTransition = ""
        self.position = ""
        self.templateName = ""
        self.teacherNotes = ""
        self.studentNotes = ""
        self.slideDuration = 0
        self.id = -1
        self.order_id = -1
        self.fragmentCount = -1
        self.slideAudio = ""
    }
    
    
    init(xml : XMLIndexer) {
        
        do {
            //for attributes
            for (key, value) in (xml.element?.allAttributes)! {
                //print(key, "  ", value.text)
            
                if key == "image_bg" {
                    self.image_BG = value.text
                } else if key == "template" {
                    self.templateName = value.text
                } else if key == "background_transition" {
                    self.backgroundTransition = value.text
                } else if key == "background" {
                    self.background = value.text
                } else if key == "transition" {
                    self.transition = value.text
                } else if key == "fragmentCount" {
                    self.fragmentCount = Int(value.text)!
                }
            }
        
            if xml["slide_audio"] != nil {
                self.slideAudio = (xml["slide_audio"].element?.text)!
                //print("slideAudio is ",self.slideAudio )
            }
            
            if xml["id"] != nil {
                self.id = Int((xml["id"].element?.text)!)!
                print("slide id is ",self.id )
            }
            if xml["img"] != nil {
                self.image = CMSMedia(xml: xml["img"])
                //print("id is ",self.id )
            }
            if xml["video"] != nil {
                self.video = CMSMedia(xml: xml["video"])
                //print("id is ",self.id )
            }
            
            if xml["ul"] != nil {
                self.list = CMSList(xml: xml["ul"])
                //print("id is ",self.id )
            }
            
            if xml["order_id"] != nil {
                self.order_id = Int((xml["order_id"].element?.text)!)!
                //print("order_id is ",self.order_id )
            }
            if xml["duration"] != nil {
                self.slideDuration = Int((xml["duration"].element?.text)!)!
                //print("slideDuration is ",self.slideDuration )
            }
            if xml["p"] != nil {
                self.paragraph = CMSText(xml: xml["p"])
                //print("paragraph is ",self.paragraph )
            }
            
            if xml["h1"] != nil {
                self.title = CMSText(xml: xml["h1"])
                //print("title is ",self.title )
            }
            
            if xml["h2"] != nil {
                self.title2 = CMSText(xml: xml["h2"])
                //print("title2 is ",self.title2 )
            }

            //student_notes
            if xml["student_notes"] != nil {
                self.studentNotes = (xml["student_notes"].element?.text)!
                //print("studentNotes is ",self.studentNotes )
            }
            
            //teacher notes
            if xml["teacher_notes"] != nil {
                self.teacherNotes = (xml["teacher_notes"].element?.text)!
                //print("teacherNotes is ",self.teacherNotes )
            }
        
        
        } catch let error as IndexingError {
        // error is an IndexingError instance that you can deal with
            print("error -> \(error)")
            
        }

    }
    
    
}
