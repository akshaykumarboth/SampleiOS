
import Foundation

public class Response {
    
	public var questionId : Int?
	public var options : Array<Int> = []
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
    
    init(){}
    
    func toJSON() -> [String : Any] {
        var dictionary: [String : Any] = [:]
        
        dictionary["questionId"] = questionId
        dictionary["duration"] = duration
        var optionsDictionary: [Int : Any] = [:]
        /*
         for index in 0...options.count - 1 {
         let option: Int = options[index]
         optionsDictionary[index] = option
         }*/
        dictionary["options"] = options
        
        //var productsDictionary: [Int : Any] = [:]
        /*
         for index in 0...self.products.count - 1 {
         let product: Product = products[index]
         productsDictionary[index] = product.toJSON()
         }*/
        
        //dictionary["product"] = productsDictionary
        
        return dictionary
    }

    
    static func listToJSON(list: [Response]) -> String{
        var result: String = ""
        var dictionary: [String : Any] = [:]
        var listDictionary: [[String: Any]] = []
        for index in 0...list.count - 1 {
            let item: Response = list[index]
            listDictionary.append(item.toJSON())
        }
        dictionary["response"] = listDictionary
        //s(dictionaryOrArray: listDictionary)
        
        
        //
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: listDictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //Convert back to string. Usually only do this for debugging
            guard let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) else {
                return "error"
            }
            result = JSONString
            print(JSONString)
        }catch {
            //print(error.description)
        }
        
        
        
        //
        return result
    }


}
