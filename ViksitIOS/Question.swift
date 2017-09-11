//
//  Question.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/11/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation

public class Question {
    public var id: Int!
    public var orderId: Int!
    public var text: String!
    public var type: Int!
    public var difficultyLevel: Int!
    public var durationInSec: Int!
    public var explanation: String!
    public var comprehensivePassageText: String!
    public var points: Int!
    public var options: [Option]!
    public var answers: [Int]!
    
    init(json: [String: Any]) {
        if json["id"] != nil {
            self.id = (json["id"] as! Int)
            //print("skill id is ",self.id! )
        }
        
        if json["orderId"] != nil {
            self.orderId = (json["orderId"] as! Int)
            //print("skill id is ",self.id! )
        }
        
        if json["text"] != nil {
            self.text = (json["text"] as! String)
            //print("skill id is ",self.id! )
        }
        
        if json["type"] != nil {
            self.type = (json["type"] as! Int)
            //print("skill id is ",self.id! )
        }
        
        if json["difficultyLevel"] != nil {
            self.difficultyLevel = (json["difficultyLevel"] as! Int)
            //print("skill id is ",self.id! )
        }
        
        if json["durationInSec"] != nil {
            self.durationInSec = (json["durationInSec"] as! Int)
            //print("skill id is ",self.id! )
        }
        
        if json["explanation"] != nil {
            self.explanation = (json["explanation"] as! String)
            //print("skill id is ",self.id! )
        }
        
        if json["comprehensivePassageText"] != nil {
            self.comprehensivePassageText = (json["comprehensivePassageText"] as! String)
            //print("skill id is ",self.id! )
        }
        
        if json["points"] != nil {
            self.points = (json["points"] as! Int)
            //print("skill id is ",self.id! )
        }
        
        if json["options"] != nil {
            var list2: Array<Option> = []
            for item in json["options"] as! NSArray {
                list2.append(Option(json: item as! [String:Any]))
            }
            self.options = list2
        }
        
        if json["answers"] != nil {
            var list2: Array<Int> = []
            for item in json["options"] as! NSArray {
                list2.append(item as! Int)
            }
            self.answers = list2
        }
    }
    
}
