/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

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
