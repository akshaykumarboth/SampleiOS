/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation

public class StudentProfile {
    var id : Int?
	public var authenticationToken : String?
	public var isVerified : String?
	public var email : String?
	public var firstName : String?
	public var lastName : String?
	public var dateOfBirth : String?
	public var gender : String?
	public var mobile : Int?
	public var location : String?
	public var profileImage : String?
	public var coins : Int?
	public var experiencePoints : Int?
	public var batchRank : Int?
	public var underGraduationSpecializationName : String?
	public var underGraduationDegree : String?
	public var underGraduationCollege : String?
	public var postGraduationDegree : String?
	public var userType : String?
	public var userCategory : String?
    
    init (json: [String: Any]) {
        
        if json["id"] != nil {
            self.id = json["id"] as! Int
            //print("skill id is ",self.id! )
        }

        if json["authenticationToken"] != nil {
            self.authenticationToken = json["authenticationToken"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["isVerified"] != nil {
            self.isVerified = json["isVerified"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["email"] != nil {
            self.email = json["email"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["firstName"] != nil {
            self.firstName = json["firstName"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["lastName"] != nil {
            self.lastName = json["lastName"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["dateOfBirth"] != nil {
            self.dateOfBirth = json["dateOfBirth"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["gender"] != nil {
            self.gender = json["gender"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["mobile"] != nil {
            self.mobile = json["mobile"] as? Int
            //print("skill id is ",self.id! )
        }
		
        if json["location"] != nil {
            self.location = json["location"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["profileImage"] != nil {
            self.profileImage = json["profileImage"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["coins"] != nil {
            self.coins = json["coins"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["experiencePoints"] != nil {
            self.experiencePoints = json["experiencePoints"] as? Int
            //print("skill id is ",self.id! )
        }
		
        if json["batchRank"] != nil {
            self.batchRank = json["batchRank"] as? Int
            //print("skill id is ",self.id! )
        }
		
        if json["underGraduationSpecializationName"] != nil {
            self.underGraduationSpecializationName = json["underGraduationSpecializationName"] as? String
            //print("skill id is ",self.id! )
        }
		
        if json["coins"] != nil {
            self.underGraduationDegree = json["underGraduationDegree"] as? String
            //print("skill id is ",self.id! )
        }
		
        if json["underGraduationCollege"] != nil {
            self.underGraduationCollege = json["underGraduationCollege"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["postGraduationDegree"] != nil {
            self.postGraduationDegree = json["postGraduationDegree"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["userType"] != nil {
            self.userType = json["userType"] as? String
            //print("skill id is ",self.id! )
        }
		
        if json["userCategory"] != nil {
            self.userCategory = json["userCategory"] as? String
            //print("skill id is ",self.id! )
        }
		
	}
}
