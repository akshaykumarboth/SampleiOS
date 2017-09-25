

import Foundation

public class Events {
    
	public var id : Int?
	public var name : String?
	public var status : String?
	public var startDate : String?
    public var startingDate : Date?
	public var endDate : String?
    public var endingDate : Date?
	public var itemType : String?
	public var itemId : Int?

    init (json: [String: Any]) {
        
        if json["id"] != nil {
            self.id = json["id"] as! Int
            //print("skill id is ",self.id! )
        }

        if json["name"] != nil {
            self.name = json["name"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["status"] != nil {
            self.status = json["status"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["startDate"] != nil {
            self.startDate = json["startDate"] as? String
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            self.startingDate = dateFormatter.date(from: startDate!)
            //print("skill id is ",self.id! )
        }
        
        if json["endDate"] != nil {
            self.endDate = json["endDate"] as? String
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            self.endingDate = dateFormatter.date(from: endDate!)
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
        
	}

}
