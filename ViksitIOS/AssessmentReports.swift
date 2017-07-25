
import Foundation

public class AssessmentReports {
    
	public var id : Int?
	public var name : String?
	public var userScore : Int?
	public var totalScore : Int?
	public var accuracy : Int?
	public var batchAverage : Int?
	public var usersAttemptedCount : Int?
	public var totalNumberOfUsersInBatch : Int?
	public var totalNumberOfQuestions : Int?
	public var totalNumberOfCorrectlyAnsweredQuestions : Int?
	public var message : String?
	public var messageDescription : String?
	public var skillsReport : Array<SkillsReport>?
	public var assessmentResponse : AssessmentResponse?
	public var retryable : Bool?

    init (json: [String: Any]) {
        
        if json["id"] != nil {
            self.id = json["id"] as! Int
            //print("skill id is ",self.id! )
        }
        
        if json["name"] != nil {
            self.name = json["name"] as? String
            //print("skill id is ",self.id! )
        }

        if json["userScore"] != nil {
            self.userScore = json["userScore"] as? Int
            //print("skill id is ",self.id! )
        }

        if json["totalScore"] != nil {
            self.totalScore = json["totalScore"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["accuracy"] != nil {
            self.accuracy = json["accuracy"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["batchAverage"] != nil {
            self.batchAverage = json["batchAverage"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["usersAttemptedCount"] != nil {
            self.usersAttemptedCount = json["usersAttemptedCount"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["totalNumberOfUsersInBatch"] != nil {
            self.totalNumberOfUsersInBatch = json["totalNumberOfUsersInBatch"] as? Int
            //print("skill id is ",self.id! )
        }

        if json["totalNumberOfQuestions"] != nil {
            self.totalNumberOfQuestions = json["totalNumberOfQuestions"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["totalNumberOfCorrectlyAnsweredQuestions"] != nil {
            self.totalNumberOfCorrectlyAnsweredQuestions = json["totalNumberOfCorrectlyAnsweredQuestions"] as? Int
            //print("skill id is ",self.id! )
        }
        
        if json["message"] != nil {
            self.message = json["message"] as? String
            //print("skill id is ",self.id! )
        }
        
        if json["messageDescription"] != nil {
            self.messageDescription = json["messageDescription"] as? String
            //print("skill id is ",self.id! )
        }
        
		if (json["skillsReport"] != nil) {
            var list2: Array<SkillsReport> = []
            for item in json["skillsReport"] as! NSArray {
                list2.append(SkillsReport(json: item as! [String:Any]))
            }
            self.skillsReport = list2
        }
		if (json["assessmentResponse"] != nil) {
            self.assessmentResponse = AssessmentResponse(json: json["assessmentResponse"] as! [String : Any])
            
        }
        if (json["retryable"] != nil) {
            self.retryable = json["retryable"] as? Bool
        }
	}

}
