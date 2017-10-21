//
//  Item.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 10/18/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation

public class Item {
    
    public var id: Int?
    public var courseId: Int?
    public var taskId: Int?
    public var cmsessionId: Int?
    public var moduleId: Int?
    
    init (json: [String: Any]) {
        
        if json["id"] != nil {
            self.id = json["id"] as? Int
            print("item - id is ",self.id! )
        }
        
        if json["courseId"] != nil {
            self.courseId = json["courseId"] as? Int
            print("item - courseId is ",self.courseId! )
        }
        
        if json["taskId"] != nil {
            self.taskId = json["taskId"] as? Int
            print("item - taskId is ",self.taskId! )
        }
        
        if json["cmsessionId"] != nil {
            self.cmsessionId = json["cmsessionId"] as? Int
            print("item - cmsessionId is ",self.cmsessionId! )
        }
        
        if json["moduleId"] != nil {
            self.moduleId = json["moduleId"] as? Int
            print("item - moduleId is ",self.moduleId! )
        }
        
    }
}
