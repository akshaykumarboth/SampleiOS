

import Foundation

public class Courses {
    
	public var id : Int?
	public var name : String?
	public var description : String?
	public var category : String?
	public var imageURL : String?
	public var status : String?
	public var rank : Int?
	public var userPoints : Int?
	public var totalPoints : Int?
	public var progress : Double?
	public var message : String?
	public var modules : Array<Modules>?
    var skillObjectives : Array<Skills>?

    init (json: [String: Any])  {
        
        if json["id"] != nil {
            self.id = (json["id"] as! Int)
            //print("Course id is ",self.id! )
        }
        
        if json["name"] != nil {
            self.name = json["name"] as? String
            //print("Course name is ",self.name! )
        }
        
        if json["description"] != nil {
            self.description = json["description"] as? String
            //print("Course description is ",self.description! )
        }
        
        if json["category"] != nil {
            self.category = json["category"] as? String
            //print("Course category is ",self.category! )
        }
        
        if json["imageURL"] != nil {
            self.imageURL = json["imageURL"] as? String
            //print("Course imageURL is ",self.imageURL! )
        }
        
        if json["status"] != nil {
            self.status = json["status"] as? String
            //print("Course status is ",self.status! )
        }
		
        if json["rank"] != nil {
            self.rank = json["rank"] as? Int
            //print("Course rank is ",self.rank! )
        }
		
        if json["userPoints"] != nil {
            self.userPoints = json["userPoints"] as? Int
            //print("Course userPoints is ",self.userPoints! )
        }
		
        if json["totalPoints"] != nil {
            self.totalPoints = json["totalPoints"] as? Int
            //print("Course totalPoints is ",self.totalPoints! )
        }
		
        if json["progress"] != nil {
            self.progress = json["progress"] as? Double
            //print("Course progress is ",self.progress! )
        }
		
        if json["message"] != nil {
            self.message = json["message"] as? String
            //print("Course message is ",self.message! )
        }
		
		if (json["modules"] != nil) {
            var list2: Array<Modules> = []
            for item in json["modules"] as! NSArray {
                list2.append(Modules(json: item as! [String:Any]))
            }
            self.modules = list2
        }
        
		if (json["skillObjectives"] != nil) {
            var list2: Array<Skills> = []
            for item in json["skillObjectives"] as! NSArray {
                list2.append(Skills(json: item as! [String:Any]))
            }
            self.skillObjectives = list2
        }
        
	}

}
