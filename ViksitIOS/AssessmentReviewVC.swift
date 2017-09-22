//
//  AssessmentReviewVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class AssessmentReviewVC: UIViewController {
    
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var questionIndexLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var continueBtn: UIButton!
    
    var visibleCellIndex: IndexPath!
    var quesList: [Response] = []
    var assessment: Assessment!
    var questions: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visibleCellIndex = IndexPath(row: 0, section: 0)
        continueBtn.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func continueTapped(){
        getVisibleCellIndexPath()
        if visibleCellIndex.row != (quesList.count-1) {
            collectionView.scrollToItem(at:IndexPath(item: visibleCellIndex.row + 1 , section: 0), at: .right, animated: false)
            visibleCellIndex.row = visibleCellIndex.row + 1
            
            self.progressView.progress = Float((visibleCellIndex.row + 1)/questions.count)
            self.questionIndexLabel.text = "\(visibleCellIndex.row + 1)/\(questions.count)"
        
        } else {
            continueBtn.isHidden = true
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

extension AssessmentReviewVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width * 1, height: collectionView.frame.height) //use height whatever you wants.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssessmentReviewCell", for: indexPath) as! AssessmentReviewCell
        
        cell.optionStack.subviews.forEach { $0.removeFromSuperview() } // removing all subviews
        cell.answerStack.subviews.forEach { $0.removeFromSuperview() }
        cell.questionView.setHTMLFromString(htmlText: questions[indexPath.row].text!)
        
        var answeredCorrectly: Bool? = nil
        var option: TickOptionView
        
        if quesList[indexPath.row].options.count == 0 {
            answeredCorrectly = false
        }
        if let options = questions[indexPath.row].options {
            for item in options {
                option = TickOptionView(frame: CGRect.zero)
                option.optionText.setHTMLFromString(htmlText: item.text!)
                
                if (quesList[indexPath.row].options.contains(item.id!)) { // for options that are marked
                    option.optionText.textColor = UIColor.white
                    if (questions[indexPath.row].answers?.contains(item.id!))! {
                        //correct answer
                        option.showImage(image: UIImage(named: "correct")!)
                        option.setbackgroundColor(color: UIColor.green)
                        if answeredCorrectly! {
                            answeredCorrectly = true
                        }
                    } else {
                        //wrong answer
                        option.showImage(image: UIImage(named: "wrong")!)
                        option.setbackgroundColor(color: UIColor.red)
                        answeredCorrectly = false
                    }
                    
                } else { //for options that are not marked
                    option.hideImage()
                    option.setBorder(color: UIColor.gray, borderWidth: 2)
                    option.optionText.textColor = UIColor.gray
                }
                
                cell.optionStack.addArrangedSubview(option)
            }
        }
        
        if ( !answeredCorrectly! ){
            cell.correctLabel.text = "That's wrong."
            let label  = UILabel(frame: CGRect.zero)
            label.text = "The answer is:"
            cell.answerStack.addArrangedSubview(label)
            if let count = questions[indexPath.row].answers?.count {
                for i in 0..<count {
                    let optionID = questions[indexPath.row].answers?[i]
                    let opt = questions[indexPath.row].options?.first { $0.id! ==  optionID}
                    let answerLabel = UILabel(frame: CGRect.zero)
                    answerLabel.setHTMLFromString(htmlText: (opt?.text)!)
                    cell.answerStack.addArrangedSubview(answerLabel)
                }
            }
            cell.correctLabel.textColor = UIColor.red
        } else {
            cell.correctLabel.text = "You are correct!"
            cell.correctLabel.textColor = UIColor.green
            
        }
        
        return cell
    }
    
    
}
