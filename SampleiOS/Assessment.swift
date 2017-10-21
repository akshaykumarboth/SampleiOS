//
//  Assessment.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/11/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation

public class Assessment {
    public var id: Int?
    public var type: String?
    public var name: String?
    public var category: String?
    public var description: String?
    public var durationInMinutes: Int?
    public var points: Int?
    public var questions: [Question] = []
    
    
    
    init (JSONString: String) {
        do{
            
            let json = try JSONSerialization.jsonObject(with: JSONString.data(using: .utf8)!, options: .allowFragments) as! [String:Any]
            if json != nil {
                
                if json["id"] != nil {
                    self.id = (json["id"] as! Int)
                }
                
                if json["type"] != nil {
                    self.type = (json["type"] as! String)
                }
                
                if json["name"] != nil {
                    self.name = (json["name"] as! String)
                }
                
                if json["category"] != nil {
                    self.category = (json["category"] as! String)
                }
                
                if json["description"] != nil {
                    self.description = (json["description"] as! String)
                }
                
                if json["durationInMinutes"] != nil {
                    self.durationInMinutes = (json["durationInMinutes"] as! Int)
                }
                
                if json["points"] != nil {
                    self.points = (json["points"] as! Int)
                }
                
                if json["questions"] != nil {
                    var list2: Array<Question> = []
                    for item in json["questions"] as! NSArray {
                        list2.append(Question(json: item as! [String:Any]))
                    }
                    self.questions = list2
                }
                
            }
            
        }catch let error as NSError {
            print(" Error \(error)")
        }
        
    }
}
