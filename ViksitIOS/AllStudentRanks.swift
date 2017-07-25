

import Foundation

public class AllStudentRanks {
    
	public var id : Int?
	public var name : String?
	public var imageURL : String?
	public var batchRank : Int?
	public var points : Int?
	public var coins : Int?

    init (json: [String: Any]) {
        
        if json["id"] != nil {
            self.id = json["id"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["name"] != nil {
            self.name = json["name"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["imageURL"] != nil {
            self.imageURL = json["imageURL"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["batchRank"] != nil {
            self.batchRank = json["batchRank"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["points"] != nil {
            self.points = json["points"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["coins"] != nil {
            self.coins = json["coins"] as? Int
            //print("skill id is ",self.id! )
        }
		
	}

}
