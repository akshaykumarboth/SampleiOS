
import Foundation

public class Lessons {
    
	public var id : Int?
	public var type : String?
	public var lesson : Lesson?
	public var status : String?
	public var orderId : Int?
	public var taskId : Int?
	public var progress : Int?

    init (json: [String: Any])  {
        
        if json["id"] != nil {
            self.id = json["id"] as? Int
        }
        
        
        if json["type"] != nil {
            self.type = json["type"] as? String
        }
        
        if json["status"] != nil {
            self.status = json["status"] as? String
        }
        
        
        if json["orderId"] != nil {
            self.orderId = json["orderId"] as? Int
        }
        
        
        if json["taskId"] != nil {
            self.taskId = json["taskId"] as? Int
        }
        
        if json["progress"] != nil {
            self.progress = json["progress"] as? Int
        }
        
		
		if (json["lesson"] != nil) {
            //lesson = Lesson(dictionary: json["lesson"] as! NSDictionary)
            self.lesson = Lesson( json: json["lesson"] as! [String : Any])
        }
		
		
		
		
	}

		


}
