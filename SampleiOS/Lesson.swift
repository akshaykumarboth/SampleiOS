

import Foundation

public class Lesson {
    
	public var id : Int?
	public var playlistId : Int?
	public var type : String?
	public var title : String?
	public var description : String?
	public var subject : String?
	public var orderId : Int?
	public var duration : Int?
	public var status : String?
	public var lessonUrl : String?
	public var currentSlideId : Int?
	public var imageUrl : String?

    init (json: [String: Any]) {
        
        if json["id"] != nil {
            self.id = json["id"] as! Int
            //print("skill id is ",self.id! )
        }
        
        if json["playlistId"] != nil {
            self.playlistId = json["playlistId"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["type"] != nil {
            self.type = json["type"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["title"] != nil {
            self.title = json["title"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["description"] != nil {
            self.description = json["description"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["subject"] != nil {
            self.subject = json["subject"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["orderId"] != nil {
            self.orderId = json["orderId"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["duration"] != nil {
            self.duration = json["duration"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["status"] != nil {
            self.status = json["status"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["lessonUrl"] != nil {
            self.lessonUrl = json["lessonUrl"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["currentSlideId"] != nil {
            self.currentSlideId = json["currentSlideId"] as? Int
            //print("skill id is ",self.id! )
        }

        if json["imageUrl"] != nil {
            self.imageUrl = json["imageUrl"] as? String
            //print("skill id is ",self.id! )
        }
		
	}


}
