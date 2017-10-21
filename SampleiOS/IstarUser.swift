//
//  IstarUser.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 10/9/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation

class IstarUser {
    var id: Int?
    var email: String?
    var firstName: String?
    var lastName: String?
    var gender: String?
    var mobile: Int?
    var profileImage: String?
    var coins: Int?
    var experiencePoints: Int?
    var batchRank: Int?
    var userType:String?
    var userCategory: String?
    
    init (jsonString: String) {
        do{
            let json = try JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments) as! [String:Any]
            
            if json["id"] != nil {
                self.id = json["id"] as! Int
            }
            
            if json["email"] != nil {
                self.email = json["email"] as! String
                //print("skill id is ",self.id! )
            }
            
            if json["firstName"] != nil {
                self.firstName = json["firstName"] as! String
                //print("skill id is ",self.id! )
            }
            
            if json["lastName"] != nil {
                self.lastName = json["lastName"] as! String
                //print("skill id is ",self.id! )
            }
            
            if json["gender"] != nil {
                self.gender = json["gender"] as! String
                //print("skill id is ",self.id! )
            }
            
            if json["mobile"] != nil {
                self.mobile = json["mobile"] as! Int
            }
            
            if json["profileImage"] != nil {
                self.profileImage = json["profileImage"] as! String
                //print("skill id is ",self.id! )
            }
            
            if json["coins"] != nil {
                self.coins = json["coins"] as! Int
                //print("skill id is ",self.id! )
            }
            
            if json["experiencePoints"] != nil {
                self.experiencePoints = json["experiencePoints"] as! Int
            }
            
            if json["batchRank"] != nil {
                self.batchRank = json["batchRank"] as! Int
                //print("skill id is ",self.id! )
            }
            
            if json["userType"] != nil {
                self.userType = json["userType"] as! String
                //print("skill id is ",self.id! )
            }
            
            if json["userCategory"] != nil {
                self.userCategory = json["userCategory"] as! String
                //print("skill id is ",self.id! )
            }
            
        }catch let error as NSError {
            print(" Error -> \(error)")
        }
    }
}
