//
//  ComplexObject.swift
//  JsonToObject
//
//  Created by Akshay Kumar Both on 7/19/17.
//  Copyright © 2017 Akshay Kumar Both. All rights reserved.
//

import Foundation

class ComplexObject {
    
    var id : Int?
    var studentProfile : StudentProfile?
    var skills : Array<Skills>?
    var tasks : Array<Tasks>?
    var assessmentreports: Array<AssessmentReports>?
    var courses: Array<Courses>?
    var leaderboards: Array<Leaderboards>?
    var events: Array<Events>?
    var notifications: Array<Notifications>?
    
    init (JSONString: String) {
        do{
            
                let json = try JSONSerialization.jsonObject(with: JSONString.data(using: .utf8)!, options: .allowFragments) as! [String:Any]
                if json != nil {
                    
                    if json["id"] != nil {
                        self.id = json["id"] as! Int
                    }
                    
                    if json["studentProfile"] != nil {
                        self.studentProfile = StudentProfile( json: json["studentProfile"] as! [String : Any])
                    }
                    
                    if json["skills"] != nil {
                        var list2: Array<Skills> = []
                        for item in json["skills"] as! NSArray {
                            list2.append(Skills(json: item as! [String:Any]))
                        }
                        self.skills = list2
                    }
                    
                    if json["tasks"] != nil {
                        var list2: Array<Tasks> = []
                        for item in json["tasks"] as! NSArray {
                            list2.append(Tasks(json: item as! [String:Any]))
                        }
                        self.tasks = list2
                    }
                    
                    if json["assessmentReports"] != nil {
                        var list2: Array<AssessmentReports> = []
                        for item in json["assessmentReports"] as! NSArray {
                            list2.append(AssessmentReports(json: item as! [String:Any]))
                        }
                        self.assessmentreports = list2
                    }
                    
                    if json["courses"] != nil {
                        var list2: Array<Courses> = []
                        for item in json["courses"] as! NSArray {
                            list2.append(Courses(json: item as! [String:Any]))
                        }
                        self.courses = list2
                    }
                    
                    if json["leaderboards"] != nil {
                        var list2: Array<Leaderboards> = []
                        for item in json["leaderboards"] as! NSArray {
                            list2.append(Leaderboards(json: item as! [String:Any]))
                        }
                        self.leaderboards = list2
                    }
                    
                    if json["events"] != nil {
                        var list2: Array<Events> = []
                        for item in json["events"] as! NSArray {
                            list2.append(Events(json: item as! [String:Any]))
                        }
                        self.events = list2
                    }
                    
                    if json["notifications"] != nil {
                        var list2: Array<Notifications> = []
                        for item in json["notifications"] as! NSArray {
                            list2.append(Notifications(json: item as! [String:Any]))
                        }
                        self.notifications = list2
                    }

                }
            
        }catch let error as NSError {
            print(" Error \(error)")
        }
        
    }
    
}
