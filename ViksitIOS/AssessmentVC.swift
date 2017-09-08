//
//  AssessmentVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/6/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit



class AssessmentVC: UIViewController {
    
    
    var testString: String = "<!DOCTYPE html><html><head><style> table, th, td {border: 1px solid black;border-collapse: collapse;padding: 0 !important; margin: 0 !important;}</style></head><body><table style=\"width:100%\"><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr><tr><th>Firstname</th><th>Lastname</th><th>Age</th></tr><tr><td>Jill</td><td>Smith</td><td>50</td></tr></table></body></html>"
    
    @IBOutlet var collectionView: UICollectionView!
    var visibleCellIndex: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func setHTMLString(testString: String) -> NSAttributedString {
        //let str = ThemeUtil.wrapInHtml(body: testString, fontsize: fontsize)
        // if the string is not wrapped in html tags then wrap it and uncomment above line
        let str = testString
        let attrStr = try! NSAttributedString(
            data: str.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        //textview.attributedText = attrStr
        return attrStr
    }
    
    
}
extension AssessmentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuesOptionCell", for: indexPath) as! QuesOptionCell
        cell.optionStack.subviews.forEach { $0.removeFromSuperview() } // removing all subviews
        
        
        cell.scrollView.scrollToTop()
        cell.quesView.attributedText = setHTMLString(testString: "what is the depth of mariana trench ? akdhay")
        
        var option: OptionView
        
        for i in 0..<5 {
            option = OptionView()
            option.tag = i
            option.addGestureRecognizer(setTapGestureRecognizer())
            option.optionText.isScrollEnabled = false
            option.optionText.attributedText = setHTMLString(testString: "what is the depth of mariana trench ? akdhay")
            option.optionContainer.backgroundColor = UIColor.brown
            cell.optionStack.addArrangedSubview(option)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width * 1, height: collectionView.frame.height) //use height whatever you wants.
    }
    
    
    /*
 
    // Called before the cell is displayed
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
     
        //print("starting display of cell: \(indexPath.row)")
    }
    
    // Called when the cell is displayed
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(collectionView.indexPathsForVisibleItems.first)
        //print("ending display of cell: \(indexPath.row)")
    }
 
 */
}


extension AssessmentVC: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = collectionView.frame.width//layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left)/cellWidthIncludingSpacing
        
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
        
        print(visibleIndexPath.row)
        self.visibleCellIndex = visibleIndexPath
        //self.visibleCellIndex = collectionView.indexPathsForVisibleItems.first!
        //print(self.visibleCellIndex.row)
        
    }
    
}

extension AssessmentVC: UIGestureRecognizerDelegate {
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        print("\(gestureRecognizer.view?.tag)")
        
        if let option: OptionView = gestureRecognizer.view as! OptionView {
            if option.optionContainer.backgroundColor == UIColor.red {
                option.optionContainer.backgroundColor = UIColor.brown
            } else {
                option.optionContainer.backgroundColor = UIColor.red
            }
            
        }
    }
    
    func setTapGestureRecognizer() -> UITapGestureRecognizer {
        
        var gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(handleTap(gestureRecognizer:)))
        
        return gestureRecognizer
    }
    

}
