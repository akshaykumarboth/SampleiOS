
import Foundation

public class AssessmentResponse {
	public var id : Int?
	public var response : Array<Response>?

    init (json: [String: Any]) {
        
        if json["id"] != nil {
            self.id = (json["id"] as! Int)
            //print("skill id is ",self.id! )
        }
		if (json["response"] != nil) {
            //response = Response.modelsFromDictionaryArray(json["response"] as! NSArray)
            var list2: Array<Response> = []
            for item in json["response"] as! NSArray {
                list2.append(Response(json: item as! [String:Any]))
            }
            self.response = list2
        }
	}


}
