import Foundation

public class Skills {
    var id : Int?
	public var name : String?
    var imageURL : String?
	public var totalPoints : Int?
	public var userPoints : Int?
	public var percentage : Int?
	public var accessedFirstTime : Bool?
    var skills : Array<Skills>?



    init (json: [String: Any]) {

        if json["id"] != nil {
            self.id = (json["id"] as! Int)
            //print("skill id is ",self.id! )
        }
        
        if json["name"] != nil {
            self.name = json["name"] as? String
            //print("skill name is ",self.name! )
        }
        
        if json["imageURL"] != nil {
            self.imageURL = json["imageURL"] as? String
            //print("skill imageURL is ",self.imageURL! )
        }
        
        if json["totalPoints"] != nil {
            self.totalPoints = json["totalPoints"] as? Int
            //print("skill totalPoints is ",self.totalPoints! )
        }

        if json["userPoints"] != nil {
            self.userPoints = json["userPoints"] as? Int
            //print("skill userPoints is ",self.userPoints! )
        }
        if json["percentage"] != nil {
            self.percentage = json["percentage"] as? Int
            //print("skill percentage is ",self.percentage! )
        }

        if json["accessedFirstTime"] != nil {
            self.accessedFirstTime = json["accessedFirstTime"] as? Bool
            //print("skill accessedFirstTime is ",self.accessedFirstTime! )
        }
        
        if json["skills"] != nil {
            self.skills = json["skills"] as? Array<Skills>
            //print("skill skills is ",self.skills! )
        }
        
	}
	
}
