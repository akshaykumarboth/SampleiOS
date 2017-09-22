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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visibleCellIndex = IndexPath(row: 0, section: 0)

        // Do any additional setup after loading the view.
    }
    
    
    func s() {
        continueBtn.addTarget(self, action: #selector(x), for: .touchUpInside)
    }
    
    func x(){
        //collectionView.scrollToItem(at: <#T##IndexPath#>, at: <#T##UICollectionViewScrollPosition#>, animated: <#T##Bool#>)
    }


}

extension AssessmentReviewVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func getVisibleCellIndexPath () {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
        
        print(visibleIndexPath.row)
        self.visibleCellIndex = visibleIndexPath
    }
    
    /*func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }*/
    
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }*/
}
