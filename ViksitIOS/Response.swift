
import Foundation

public class Response {
    
	public var questionId : Int?
	public var options : Array<Int>?
	public var duration : Int?

    init (json: [String: Any]) {
        
        if json["questionId"] != nil {
            self.questionId = json["questionId"] as? Int
            //print("skill id is ",self.id! )
        }
		
		if (json["options"] != nil) {
            //options = Options.modelsFromDictionaryArray(dictionary["options"] as! NSArray)
            var list2: Array<Int> = []
            for item in json["options"] as! NSArray {
                list2.append(item as! Int)
            }
            self.options = list2
        }
        
        if json["duration"] != nil {
            self.duration = json["duration"] as? Int
            //print("skill id is ",self.id! )
        }
		
	}

}
