
import Foundation

public class Tasks {
    
	public var id : Int?
	public var header : String?
	public var title : String?
	public var itemType : String?
	public var itemId : Int?
	public var duration : Int?
	public var imageURL : String?
	public var status : String?
	public var date : String?
	public var messageForCompletedTasks : String?
	public var messageForIncompleteTasks : String?
	public var lattitude : Double?
	public var longitude : Double?
	public var durationHours : Int?
	public var durationMinutes : Int?
	public var groupName : String?
	public var classRoomId : Int?
	public var classRoomName : String?
	public var time : String?
	public var event_address : String?
    public var description : String?
    
    init (json: [String: Any]) {
        
        if json["id"] != nil {
            self.id = (json["id"] as! Int)
            //print("skill id is ",self.id! )
        }
        
        if json["header"] != nil {
            self.header = json["header"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["title"] != nil {
            self.title = json["title"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["itemType"] != nil {
            self.itemType = json["itemType"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["itemId"] != nil {
            self.itemId = json["itemId"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["duration"] != nil {
            self.duration = json["duration"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["imageURL"] != nil {
            self.imageURL = json["imageURL"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["status"] != nil {
            self.status = json["status"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["date"] != nil {
            self.date = json["date"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["messageForCompletedTasks"] != nil {
            self.messageForCompletedTasks = json["messageForCompletedTasks"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["messageForIncompleteTasks"] != nil {
            self.messageForIncompleteTasks = json["messageForIncompleteTasks"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["lattitude"] != nil {
            self.lattitude = json["lattitude"] as? Double
            //print("skill id is ",self.id! )
        }
		
        if json["longitude"] != nil {
            self.longitude = json["longitude"] as? Double
            //print("skill id is ",self.id! )
        }
		
        if json["durationHours"] != nil {
            self.durationHours = json["durationHours"] as? Int
            //print("skill id is ",self.id! )
        }
		
        if json["durationMinutes"] != nil {
            self.durationMinutes = json["durationMinutes"] as? Int
            //print("skill id is ",self.id! )
        }
		
        if json["groupName"] != nil {
            self.groupName = json["groupName"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["classRoomId"] != nil {
            self.classRoomId = json["classRoomId"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["classRoomName"] != nil {
            self.classRoomName = json["classRoomName"] as? String
            //print("skill id is ",self.id! )
        }
		
        if json["time"] != nil {
            self.time = json["time"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["event_address"] != nil {
            self.event_address = json["event_address"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["description"] != nil {
            self.description = json["description"] as? String
            //print("skill id is ",self.id! )
        }
		
	}

}
