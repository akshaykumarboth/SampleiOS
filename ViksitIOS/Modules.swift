
import Foundation

public class Modules {
    
	public var id : Int?
	public var name : String?
	public var description : String?
	public var status : String?
	public var imageURL : String?
	public var orderId : Int?
	public var lessons : Array<Lessons>?
    var skillObjectives : Array<SkillObjectives>?


	init (json: [String: Any])  {

        if json["id"] != nil {
            self.id = json["id"] as? Int
        }
        if json["name"] != nil {
            self.name = json["name"] as? String
            print("Module name is \(self.name!)")
        }
        if json["description"] != nil {
            self.description = json["description"] as? String
            //print("Module description is \(self.description!)")
        }
        
        if json["status"] != nil {
            self.status = json["status"] as? String
        }
        
        if json["imageURL"] != nil {
            self.imageURL = json["imageURL"] as? String
        }
        
        if json["orderId"] != nil {
            self.orderId = json["orderId"] as? Int
        }
        
        if json["lessons"] != nil {
            var list2: Array<Lessons> = []
            for item in json["lessons"] as! NSArray {
                list2.append(Lessons(json: item as! [String:Any]))
            }
            self.lessons = list2
        }
        
        if json["skillObjectives"] != nil {
            var list2: Array<SkillObjectives> = []
            for item in json["skillObjectives"] as! NSArray {
                //list2.append(SkillObjectives(json: item as! [String : Any]))
            }
            self.skillObjectives = list2
        }
		
	}

}
