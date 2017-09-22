//
//  AssessmentVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/6/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class AssessmentVC: UIViewController {
    
    var backTag: String = ""
    
    var quesList: [Response] = []
    var assessment: Assessment!
    var questions: [Question] = []
    var timeLeft = 5
    var timer: Timer! = Timer()
    var timer1: Timer! = Timer()
    var taskID: Int! = -1
    var userID: Int! = -1
    var visibleCellIndex: IndexPath!
    var totalQuesAnswered: Int = 0
    
    @IBOutlet var submitViewBtn: UIButton!
    @IBOutlet var submitUnansweredLabel: UILabel!
    @IBOutlet var quesAnsweredLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var submitTimerLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var quesTableList: UITableView!
    @IBOutlet var centerYconstraint: NSLayoutConstraint!
    @IBOutlet var tableViewContainer: UIView!
    @IBOutlet var viewAllBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var prevBtn: UIButton!
    @IBOutlet var submitView: UIView!
    
    @IBOutlet var submitViewYConstraint: NSLayoutConstraint!
    @IBOutlet var hiddenCoverView: UIView!
    
    @IBAction func closePressed(_ sender: UIButton) {
        //createAlert()
        submitViewYConstraint.constant = 0
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })

    }
    
    @IBAction func hidingSubmitView(_ sender: UIButton) {
        submitViewYConstraint.constant = -1000
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })

    }
    
    @IBAction func showPrev(_ sender: UIButton) {
        getVisibleCellIndexPath()
        
        if visibleCellIndex.row != 0 {
            collectionView.scrollToItem(at:IndexPath(item: visibleCellIndex.row - 1 , section: 0), at: .left, animated: false)
            self.visibleCellIndex.row = self.visibleCellIndex.row - 1
            
            if visibleCellIndex.row == 0 {
                print("first")
                prevBtn.setTitle("", for: .normal)
            } else {
                prevBtn.setTitle("PREV", for: .normal)
            }
            
            if visibleCellIndex.row == questions.count-1 {
                print("last")
                nextBtn.setTitle("FINISH", for: .normal)
            } else {
                nextBtn.setTitle("NEXT", for: .normal)
            }
            
            if visibleCellIndex.row == questions.count {
                hiddenCoverView.isHidden = false
                nextBtn.setTitle("", for: .normal)
            } else {
                hiddenCoverView.isHidden = true
            }
            
        }
        checkAnsweredQuestion()
        
    }
    
    @IBAction func showNext(_ sender: UIButton) {
        getVisibleCellIndexPath()
        checkAnsweredQuestion()
        print(" lll  \(visibleCellIndex.row)")
        if visibleCellIndex.row != (questions.count) { // 4 has to be changed
            collectionView.scrollToItem(at:IndexPath(item: visibleCellIndex.row + 1 , section: 0), at: .right, animated: false)
            visibleCellIndex.row = visibleCellIndex.row + 1
            
            /*
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
 */
            /*
            if visibleCellIndex.row == questions.count {
                createAlert()
            }*/
            
            if visibleCellIndex.row == 0 {
                print("first")
                prevBtn.setTitle("", for: .normal)
            } else {
                prevBtn.setTitle("PREV", for: .normal)
            }
            
            if visibleCellIndex.row == questions.count-1 {
                print("last")
                nextBtn.setTitle("FINISH", for: .normal)
                //goto(storyBoardName: "assessment", storyBoardID: "TimeUpVC")
            } else {
                nextBtn.setTitle("NEXT", for: .normal)
            }
            
            
            if visibleCellIndex.row == questions.count {
                hiddenCoverView.isHidden = false
                nextBtn.setTitle("", for: .normal)
            } else {
                hiddenCoverView.isHidden = true
            }
        }
        checkAnsweredQuestion()
        
    }
    
    @IBAction func closeTable(_ sender: UIButton) {
        centerYconstraint.constant = 1000
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func showTable(_ sender: UIButton) {
        centerYconstraint.constant = 0
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func timerRunning() {
        
        timeLeft -= 1
        timerLabel.text = "\(timeLeft/60):\(timeLeft%60)"
        submitTimerLabel.text = "\(timeLeft/60):\(timeLeft%60)"
        
        //let cell = collectionView.cellForItem(at: IndexPath(row: questions.count, section: 0  )) as! SubmitCVCell
        //cell.timerLabel.text = "\(timeLeft/60):\(timeLeft%60)"
        if timeLeft == 0 {
            timer.invalidate()
            timerLabel.text = "Time is up"
            submitTimerLabel.text = "Time is up"
            //sendSubmitRequest()
            //goto(storyBoardName: "assessment", storyBoardID: "TimeUpVC")
        }
    }
    
    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func writeToFile() {
        let fileName = "Test"
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        print("File Path is: \(fileURL.path)")
        
        let writeString = "Write this text in the file in swift"
        do {
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed to write URL")
            print(error)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkAnsweredQuestion()
        quesAnsweredLabel.text = "\(totalQuesAnswered) OF \(questions.count) ANSWERED"
        //timer
        print(assessment.durationInMinutes)
        if assessment.durationInMinutes != nil {
            timeLeft = assessment.durationInMinutes! * 60
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(AssessmentVC.timerRunning), userInfo: nil, repeats: true)
            
        }
        print("userid \(userID!) -- tasskid \(taskID!)")
        prevBtn.setTitle("", for: .normal)
        
        //timeLeft = 5
        
    }
    
    //not used yet
    func getAssessment(taskID: Int, userID: Int){
        //var response: String = Helper.makeHttpCall (url : "http://elt.talentify.in/t2c/get_lesson_details?taskId=277274&userId=4972", method: "GET", param: [:])
        
        let response: String = Helper.makeHttpCall (url : "http://elt.talentify.in/t2c/get_lesson_details?taskId=\(taskID)&userId=\(userID)", method: "GET", param: [:])
        self.assessment = Assessment(JSONString: response) //AssessmentVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let taskid = taskID {
            if let userid = userID {
                print("userid \(userid) -- tasskid \(taskid)")
                //let response: String = Helper.makeHttpCall (url : "http://elt.talentify.in/t2c/get_lesson_details?taskId=\(taskid)&userId=\(userid)", method: "GET", param: [:])
                let response: String = Helper.makeHttpCall (url : "http://192.168.1.4:8080/t2c/get_lesson_details?taskId=\(taskid)&userId=\(userid)", method: "GET", param: [:])
                self.assessment = Assessment(JSONString: response)
                print(assessment.id)
                //assessmentResponse.id = self.assessment.id //
            }
        }
        setData()
 
        /*
        if let assessmentCache = DataCache.sharedInstance.cache["assessment"] {
            self.assessment = Assessment(JSONString: assessmentCache)
            //
        }*/
        self.submitViewBtn.addTarget(self, action: #selector(submitAssessment), for: UIControlEvents.touchUpInside)
        self.submitUnansweredLabel.text = "\(questions.count)"
        visibleCellIndex = IndexPath(row: 0, section: 0)
        quesTableList.tag = -1000 // so, scrollview delegate methods adoesnt affect the table view scroll
        quesTableList.rowHeight = UITableViewAutomaticDimension
        quesTableList.estimatedRowHeight = 140
        setViewAllImageToRight(viewAllBtn: viewAllBtn)
        
    }
    
    func loadAssessmentAsync() {
        DispatchQueue.global(qos: .background).async {
            //print("This is run on the background queue")
            var response: String = Helper.makeHttpCall (url : "http://elt.talentify.in/t2c/get_lesson_details?taskId=277274&userId=4972", method: "GET", param: [:])
            //var ass = Assessment(JSONString: response)
            DispatchQueue.main.async {
                //print("This is run on the main queue, after the previous code in outer block")
                self.assessment = Assessment(JSONString: response)
                print(self.assessment.id)
                self.setData()
            }
        }
    }
    
    func setData() {
        questions = assessment.questions
        
    }
    
    func createAlert(){
        let actionSheet = UIAlertController(title: "Do you wish to submit the Assessment ?", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            action in
            self.submitAssessment()
        }))
        
        /*
        actionSheet.addAction(UIAlertAction(title: "No", style: .default, handler: {
            action in
            //self.showAlbum()
        }))*/
        
        actionSheet.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)

    }
    
    func sendSubmitRequest() {
         //QuestionResponse.listToJSON(list: quesList)
        print(Response.listToJSON(list: quesList))
        let params: [String: String] = ["response": Response.listToJSON(list: quesList)]
        
        var response = Helper.makeHttpCall(url: "http://elt.talentify.in/t2c/assessments/user/\(userID)/\(assessment.id)/\(taskID)", method: "POST", param: params)
    }
    
    func submitAssessment() {
        print(Reach().connectionStatus())
        
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            //for the case when internet connection is not present
            print("Not connected")
        case .online(.wwan):
            //for the case when internet connection is present via 4g/3g
            //sendSubmitRequest()
            print("Connected via WWAN")
            //to send data to server
            
        case .online(.wiFi):
            //for the case when internet connection is present via wifi
            //sendSubmitRequest()
            print("Connected via WiFi")
        }
        
        
        goto(storyBoardName: "Tab", storyBoardID: "TabBarController")
    }

    func setViewAllImageToRight(viewAllBtn: UIButton) {
        
        let titleWidth: CGFloat = viewAllBtn.titleLabel!.frame.size.width
        let imageWidth: CGFloat = viewAllBtn.imageView!.frame.size.width
        let gapWidth: CGFloat = viewAllBtn.frame.size.width - titleWidth - imageWidth
        let sidePadding: CGFloat = 10
        
        viewAllBtn.titleEdgeInsets = UIEdgeInsetsMake(viewAllBtn.titleEdgeInsets.top,
                                                      -imageWidth + viewAllBtn.titleEdgeInsets.left + sidePadding,
                                                      viewAllBtn.titleEdgeInsets.bottom,
                                                      imageWidth - viewAllBtn.titleEdgeInsets.right )
        
        viewAllBtn.imageEdgeInsets = UIEdgeInsetsMake(viewAllBtn.imageEdgeInsets.top,
                                                      titleWidth + viewAllBtn.imageEdgeInsets.left + gapWidth - sidePadding,
                                                      viewAllBtn.imageEdgeInsets.bottom,
                                                      -titleWidth + viewAllBtn.imageEdgeInsets.right - gapWidth )
    }
    
    func setHTMLString(testString: String) -> NSAttributedString {
        //let str = ThemeUtil.wrapInHtml(body: testString, fontsize: fontsize)
        // if the string is not wrapped in html tags then wrap it and uncomment above line
        let str = "<span>\(testString)</span>"
        let attrStr = try! NSAttributedString(
            data: str.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        return attrStr
    }
    
}

extension AssessmentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (questions.count + 1)
    }
    
    
    @objc func timer1Running() {
        //timeLeft -= 1
        if timeLeft > 0 {
            var label = timer1.userInfo as! UILabel
            label.text = "\(timeLeft/60):\(timeLeft%60)"
        }
        
        if timeLeft == 0 {
            timer1.invalidate()
            //label.text = "Time is up"
            goto(storyBoardName: "assessment", storyBoardID: "TimeUpVC")
        }
    }
    
    @IBAction func startBtnTapped(_ sender: UIButton) -> Void {
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //paramsToSend[questions[visibleCellIndex.row].id] = []
        
        
        
        // case for last submit page
        if indexPath.row == questions.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubmitCVCell", for: indexPath) as! SubmitCVCell
            checkAnsweredQuestion()
            let unAnswered = questions.count - totalQuesAnswered
            cell.unansweredLabel.text = "\(unAnswered)"
            
            timer1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(AssessmentVC.timer1Running), userInfo: cell.timerLabel, repeats: true)
            cell.submitAssessment.addTarget(self, action: #selector(submitAssessment), for: UIControlEvents.touchUpInside)
            //cell.unansweredLabel
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuesOptionCell", for: indexPath) as! QuesOptionCell
        cell.optionStack.subviews.forEach { $0.removeFromSuperview() } // removing all subviews
        cell.quesNumber.text = "QUESTION \(indexPath.row + 1) OF \(questions.count)"
        cell.scrollView.scrollToTop()
        //cell.quesView.attributedText = setHTMLString(testString: questions[indexPath.row].text!)
        cell.quesView.setHTMLFromString(htmlText: questions[indexPath.row].text!)
        
        var option: OptionView
        if let count = questions[indexPath.row].options?.count {
            for i in 0..<count {
                option = OptionView()
                option.tag = i
                if (questions[indexPath.row].options?[i].isSelected)! {
                    option.setBorderColor(color: UIColor(red: 35/255, green: 182/255, blue: 249/255, alpha: 1.00))
                    option.optionText.textColor = UIColor(red: 35/255, green: 182/255, blue: 249/255, alpha: 1.00)
                    
                } else {
                    option.setBorderColor(color: UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.00))
                    option.optionText.textColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.00)
                }
                //option.optionText.font = UIFont().withSize(15)
                option.addGestureRecognizer(setTapGestureRecognizer())
                option.optionText.isScrollEnabled = false
                option.optionText.setHTMLFromString(htmlText: (questions[indexPath.row].options?[i].text)!)
                
                cell.optionStack.addArrangedSubview(option)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width * 1, height: collectionView.frame.height) //use height whatever you wants.
    }
    
    
    // Called before the cell is displayed
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
     
        
        //print("starting display of cell: \(indexPath.row)")
        
        
    }
    
    // Called when the cell is displayed
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //print(collectionView.indexPathsForVisibleItems.first)
        //print("ending display of cell: \(indexPath.row)")
        
        
    }
 

}

extension AssessmentVC: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView.tag == -1000 { //so hidden table view scrolling doesnt get effected by the scrollview delegate methods
            return
        }
        
        //let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = collectionView.frame.width//layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left)/cellWidthIncludingSpacing
        
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
        //
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView.tag == -1000 { //so hidden table view scrolling doesnt get effected by the scrollview delegate methods
            return
        }
        getVisibleCellIndexPath()
        if visibleCellIndex.row == 0 {
            print("first")
            prevBtn.setTitle("", for: .normal)
        } else {
            prevBtn.setTitle("PREV", for: .normal)
        }
        
        if visibleCellIndex.row == questions.count-1 {
            print("last")
            nextBtn.setTitle("", for: .normal)
        } else {
            nextBtn.setTitle("NEXT", for: .normal)
        }
        
    }
    
    func getVisibleCellIndexPath () {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
        
        print(visibleIndexPath.row)
        self.visibleCellIndex = visibleIndexPath
    }
    
}

extension AssessmentVC: UIGestureRecognizerDelegate {
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        print("\(gestureRecognizer.view?.tag)")
        getVisibleCellIndexPath()
        if let option: OptionView = gestureRecognizer.view as! OptionView {
            if !((questions[visibleCellIndex.row].options?[option.tag].isSelected)!) {
                option.optionContainer.backgroundColor = UIColor(red: 35/255, green: 182/255, blue: 249/255, alpha: 1.00) //selectedcolor
                option.optionText.textColor = UIColor(red: 35/255, green: 182/255, blue: 249/255, alpha: 1.00) //selectedcolor
                self.questions[visibleCellIndex.row].options?[(option.tag)].isSelected = true
                checkAnsweredQuestion()
                print("question \(visibleCellIndex.row) -> option \(option.tag) is selected")
                
                
            } else {
                option.optionContainer.backgroundColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.00)//unselected color
                option.optionText.textColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.00)//unselected color
                self.questions[visibleCellIndex.row].options?[(option.tag)].isSelected = false
                checkAnsweredQuestion()
                print("question \(visibleCellIndex.row) -> option \(option.tag) is unselected")
            }
            
        }
    }
    
    func checkAnsweredQuestion() {
        quesList = []
        var count = 0
        for question in questions {
            var q = Response()
            q.questionId = question.id
            q.duration = question.durationInSec
            for option in question.options! {
                if option.isSelected {
                    q.options.append(option.id!)
                }
            }
            if q.options.count != 0 {
                count += 1
            }
            quesList.append(q)
        }
        self.totalQuesAnswered = count
        self.quesAnsweredLabel.text = "\(totalQuesAnswered) OF \(questions.count) ANSWERED"
        self.submitUnansweredLabel.text = "\(questions.count - totalQuesAnswered)"
        
    }
    
    func setTapGestureRecognizer() -> UITapGestureRecognizer {
        
        var gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(handleTap(gestureRecognizer:)))
        
        return gestureRecognizer
    }

}

extension AssessmentVC: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        let cell = tableView.dequeueReusableCell(withIdentifier: "HiddenTableCell", for: indexPath) as! HiddenTableCell
        
        cell.questionText.setAttributedText(text: questions[indexPath.row].text!, symbolCode: String(indexPath.row + 1))
        cell.questionText.textLabel.setHTMLFromString(htmlText: questions[indexPath.row].text!)
        cell.questionText.symbolLabel.setHTMLFromString(htmlText: String(indexPath.row + 1))
        cell.questionText.setFontSize(textSize: 18)
        cell.questionText.setSpacing(spacing: 5)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if indexPath.row == 0 {
            prevBtn.setTitle("", for: .normal)
        } else {
            prevBtn.setTitle("PREV", for: .normal)
        }
        
        if indexPath.row == questions.count-1 {
            nextBtn.setTitle("FINISH", for: .normal)
        } else {
            nextBtn.setTitle("NEXT", for: .normal)
        }
        collectionView.scrollToItem(at:IndexPath(item: indexPath.row , section: 0), at: .left, animated: false)
        checkAnsweredQuestion()
        centerYconstraint.constant = 1000
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
}


