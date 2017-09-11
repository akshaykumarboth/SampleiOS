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
    public var questions: [Question]!
    
    
    
    init (JSONString: String) {
        do{
            
            let json = try JSONSerialization.jsonObject(with: JSONString.data(using: .utf8)!, options: .allowFragments) as! [String:Any]
            if json != nil {
                
                if json["id"] != nil {
                    self.id = json["id"] as! Int
                }
                
                if json["tasks"] != nil {
                    var list2: Array<Tasks> = []
                    for item in json["tasks"] as! NSArray {
                        list2.append(Tasks(json: item as! [String:Any]))
                    }
                    //self.tasks = list2
                }
                
                
            }
            
        }catch let error as NSError {
            print(" Error \(error)")
        }
        
    }
}
