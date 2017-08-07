
import Foundation

public class Leaderboards {
    
	public var id : Int?
	public var name : String?
	public var description : String?
	public var allStudentRanks : Array<AllStudentRanks>?

    init (json: [String: Any]) {
       
            if json["id"] != nil {
                self.id = json["id"] as! Int
                //print("skill id is ",self.id! )
            }
        
            if json["name"] != nil {
                self.name = json["name"] as? String
                //print("skill id is ",self.id! )
            }
        
            if json["description"] != nil {
                self.description = json["description"] as? String
                //print("skill id is ",self.id! )
            }
		
		
            if (json["allStudentRanks"] != nil) {
                var list2: Array<AllStudentRanks> = []
                for item in json["allStudentRanks"] as! NSArray {
                    list2.append(AllStudentRanks(json: item as! [String:Any]))
                }
                self.allStudentRanks = list2
            }
        }
   


}
