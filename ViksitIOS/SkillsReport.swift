
import Foundation

public class SkillsReport {
	public var id : Int?
	public var name : String?
	public var totalPoints : Int?
	public var userPoints : Int?
	public var percentage : Int?
	public var skills : Array<Skills>?
	public var accessedFirstTime : Bool?

    init (json: [String: Any]) {
        
        if json["id"] != nil {
            self.id = json["id"] as! Int
            //print("skill id is ",self.id! )
        }
        
        if json["name"] != nil {
            self.name = json["name"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["totalPoints"] != nil {
            self.totalPoints = json["totalPoints"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["userPoints"] != nil {
            self.userPoints = json["userPoints"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["percentage"] != nil {
            self.percentage = json["percentage"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["accessedFirstTime"] != nil {
            self.accessedFirstTime = json["accessedFirstTime"] as? Bool
            //print("skill id is ",self.id! )
        }
		
		if (json["skills"] != nil) {
            var list2: Array<Skills> = []
            for item in json["skills"] as! NSArray {
                list2.append(Skills(json: item as! [String:Any]))
            }
            self.skills = list2
        }
		
	}


}
