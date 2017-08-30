
import Foundation
import UIKit

class Helper{
    
    static func postRequest() -> [String:String] {
        // do a post request and return post data
        return ["someData" : "someData"]
    }
    
    static func vinaykoBola(name : String) -> String {
        return "\(name) is this" as String
    }
    
    static func makeHttpCall (url : String, method: String, param: [String:String]) -> String {
        var success = "aa" 
        let semaphore = DispatchSemaphore(value: 0)

        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method
        //
        if (request.httpMethod  == "POST" || request.httpMethod == "PUT") {
            //let postString = "{ \"name\":\"John\", \"age\":30, \"car\":null }"
            if request.httpMethod == "PUT" {
                request.addValue("application/json", forHTTPHeaderField: "Content-Type") //Optional
            }
            var postString = ""
            if param.isEmpty == false {
                for (key, value) in param {
                 postString = postString + "\(key)" + "=" + "\(value)" + "&"
                 
                }
            }
            print("herp \(postString)")
            request.httpBody = postString.data(using: .utf8)
        }
        URLSession.shared.dataTask(with:request, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                success = String(data: data, encoding: String.Encoding.utf8)!
                semaphore.signal()
            } catch let error as NSError {
                print(" error \(error)")
            }
        }).resume()
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return success
    
    }
    
    static func setHTMLString(testString: String,fontsize: String ) -> NSAttributedString{
        let str = ThemeUtil.wrapInHtml(body: testString, fontsize: fontsize)
        let attrStr = try! NSAttributedString(
            data: str.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        //textview.attributedText = attrStr
        return attrStr
    }
    
    
    static func readFromFile(fileName: String, extnsion: String) -> String{
        var result: String = ""
        //let file = "DummyData.txt" //this is the file. we will read from it
        if let path = Bundle.main.path(forResource: fileName, ofType: extnsion) {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
                var x : String = ""
                for string in myStrings {
                    x.append(string)
                }
                print(x)
                result = x
                
            } catch {
                print(error)
                result = ""
            }
        }
        
        return result
    }
    
    
    
}
