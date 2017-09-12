//
//  AssessmentVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/6/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit



class AssessmentVC: UIViewController {
    
    var assessment: Assessment!
    var questions: [Question] = []
    var timeLeft = 0
    var timer: Timer! = Timer()
    var taskID: Int?
    var userID: Int?
    //var testString: String = "<!DOCTYPE html><html><head><style> table, th, td {border: 1px solid black;border-collapse: collapse;padding: 0 !important; margin: 0 !important;}</style></head><body><table style=\"width:100%\"><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr></table></body></html>"
    
    var visibleCellIndex: IndexPath!
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var quesTableList: UITableView!
    @IBOutlet var centerYconstraint: NSLayoutConstraint!
    @IBOutlet var tableViewContainer: UIView!
    @IBOutlet var viewAllBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var prevBtn: UIButton!
    
    @IBAction func closePressed(_ sender: UIButton) {
        createAlert()
    }
    
    @IBAction func showPrev(_ sender: UIButton) {
        if visibleCellIndex.row != 0 {
            collectionView.scrollToItem(at:IndexPath(item: visibleCellIndex.row - 1 , section: 0), at: .left, animated: false)
            self.visibleCellIndex.row = self.visibleCellIndex.row - 1
            /*
            UIView.animate(withDuration: 0.3, animations: {
                self.visibleCellIndex.row = self.visibleCellIndex.row - 1
                self.view.layoutIfNeeded()
            })
 */
            
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
        }
        
    }
    
    @IBAction func showNext(_ sender: UIButton) {
        print(" lll  \(visibleCellIndex.row)")
        if visibleCellIndex.row != (questions.count-1) { // 4 has to be changed
            collectionView.scrollToItem(at:IndexPath(item: visibleCellIndex.row + 1 , section: 0), at: .right, animated: false)
            visibleCellIndex.row = visibleCellIndex.row + 1
            /*
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
 */
            //
            if visibleCellIndex.row == questions.count {
                createAlert()
            }
            
            //
            
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
        }
        
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
        if timeLeft == 0 {
            timer.invalidate()
            timerLabel.text = "Time is up"
            goto(storyBoardName: "assessment", storyBoardID: "TimeUpVC")
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
        //timer
        timeLeft = assessment.durationInMinutes! * 60
        //timeLeft = 5
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(AssessmentVC.timerRunning), userInfo: nil, repeats: true)
        
        print("userid \(userID!) -- tasskid \(taskID!)")
        prevBtn.setTitle("", for: .normal)
        //quesTableList.separatorStyle = .none
    }
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
                let response: String = Helper.makeHttpCall (url : "http://elt.talentify.in/t2c/get_lesson_details?taskId=\(taskid)&userId=\(userid)", method: "GET", param: [:])
                self.assessment = Assessment(JSONString: response)
            }
        }
        setData()
 
        /*
        if let assessmentCache = DataCache.sharedInstance.cache["assessment"] {
            self.assessment = Assessment(JSONString: assessmentCache)
            //
        }*/
        
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
        let actionSheet = UIAlertController(title: "Do you wish to end the Assessment ?", message: nil, preferredStyle: .actionSheet)
        
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
    
    func submitAssessment() {
        goto(storyBoardName: "Tab", storyBoardID: "TasksVC")
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
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
                } else {
                    option.setBorderColor(color: UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.00))
                }
                //option.optionText.font = UIFont().withSize(15)
                option.addGestureRecognizer(setTapGestureRecognizer())
                option.optionText.isScrollEnabled = false
                //option.optionText.attributedText = setHTMLString(testString: (questions[indexPath.row].options?[i].text!)!)
                //option.optionText.text = questions[indexPath.row].options?[i].text
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
     
        /*
        //print("starting display of cell: \(indexPath.row)")
        if indexPath.row == 0 {
            print("first")
            prevBtn.setTitle("", for: .normal)
        } else {
            prevBtn.setTitle("PREV", for: .normal)
        }
        
        if indexPath.row == questions.count-1 {
            print("last")
            nextBtn.setTitle("FINISH", for: .normal)
        } else {
            nextBtn.setTitle("NEXT", for: .normal)
        }
        */
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
            nextBtn.setTitle("FINISH", for: .normal)
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
        
        if let option: OptionView = gestureRecognizer.view as! OptionView {
            if !((questions[visibleCellIndex.row].options?[option.tag].isSelected)!) {
                option.optionContainer.backgroundColor = UIColor(red: 35/255, green: 182/255, blue: 249/255, alpha: 1.00)
                self.questions[visibleCellIndex.row].options?[(option.tag)].isSelected = true
                print("question \(visibleCellIndex.row) -> option \(option.tag) is selected")
            } else {
                option.optionContainer.backgroundColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.00)
                self.questions[visibleCellIndex.row].options?[(option.tag)].isSelected = false
                print("question \(visibleCellIndex.row) -> option \(option.tag) is unselected")
            }
            
        }
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
        //tableView.separatorStyle = .none
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
        collectionView.scrollToItem(at:IndexPath(item: indexPath.row , section: 0), at: .left, animated: false)
        centerYconstraint.constant = 1000
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
}


