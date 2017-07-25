//
//  SkillObjectives.swift
//  JsonToObject
//
//  Created by Akshay Kumar Both on 7/24/17.
//  Copyright © 2017 Akshay Kumar Both. All rights reserved.
//

import Foundation

class SkillObjectives {
    
    var id: Int?
    var name: String?
    var description: String?
    var totalPoints: Double?
    var userPoints: Int?
    var percentage: Int?
    var skills: Array<Skills>?
    var accessedFirstTime: Bool?
    
    init (json: [String: Any])  {
        
        if json["id"] != nil {
            self.id = (json["id"] as! Int)
            //print("SkillObjective id is ",self.id! )
        }
        
        if json["name"] != nil {
            self.name = (json["name"] as! String)
            //print("SkillObjective name is ",self.name! )
        }
        
        if json["description"] != nil {
            self.description = (json["description"] as! String)
            //print("SkillObjective description is ",self.description! )
        }
        if json["totalPoints"] != nil {
            self.totalPoints = (json["totalPoints"] as! Double)
            //print("SkillObjective totalPoints is ",self.totalPoints! )
        }
        
        if json["userPoints"] != nil {
            self.userPoints = (json["userPoints"] as! Int)
            //print("SkillObjective userPoints is ",self.userPoints! )
        }
        
        if json["percentage"] != nil {
            self.percentage = (json["percentage"] as! Int)
            //print("SkillObjective percentage is ",self.percentage! )
        }
        
        if json["skills"] != nil {
            var list2: Array<Skills> = []
            for item in json["skills"] as! NSArray {
                list2.append(Skills(json: item as! [String:Any]))
            }
            self.skills = list2
        }
        
        if json["accessedFirstTime"] != nil {
            self.accessedFirstTime = (json["accessedFirstTime"] as! Bool)
            //print("SkillObjective accessedFirstTime is ",self.accessedFirstTime! )
        }

    }
}
