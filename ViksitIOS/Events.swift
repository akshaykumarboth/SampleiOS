

import Foundation

public class Events {
	public var id : Int?
	public var name : String?
	public var status : String?
	public var startDate : String?
	public var endDate : String?
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
            //print("skill id is ",self.id! )
        }
        
        if json["endDate"] != nil {
            self.endDate = json["endDate"] as? String
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
