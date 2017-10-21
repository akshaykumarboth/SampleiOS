//
//  LessonVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/18/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class LessonVC: UIViewController {
    
    var course: Courses?
    var lessons: Array<Lessons> = []
    var toolbarTitleText: String = ""
    let cellWidthScaling: CGFloat = 0.9
    let cellHeightScaling: CGFloat = 0.4
    
    @IBOutlet var topActionBar: UIView!
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Modules", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ModulesVC") as! ModulesVC
        nextViewController.course = course
        
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBOutlet var lessonCollectionView: UICollectionView!
    @IBOutlet var toolbarTitle: UILabel!
    
    func setCollectionCellSize(){
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellWidthScaling)
        let cellHeight = floor(screenSize.height * cellHeightScaling)
        
        let insetX = (view.bounds.width - cellWidth)/2.0
        let insetY = (view.bounds.height - cellHeight)/2.0
        
        let layout = AnimatedCollectionViewLayout()
        layout.animator = LinearCardAttributesAnimator( minAlpha: 0, itemSpacing: 0, scaleRate: 1.0)
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        lessonCollectionView.collectionViewLayout = layout
        lessonCollectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        self.lessonCollectionView.delegate = self
        self.lessonCollectionView.dataSource = self
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        topActionBar.backgroundColor = UIColor.Custom.themeColor
        setCollectionCellSize()
        
        toolbarTitle.text = toolbarTitleText

    }

}

extension LessonVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LessonCVCell", for: indexPath) as! LessonCVCell
        cell.progress.progress = Float(lessons[indexPath.row].progress!)
        cell.progress.progressTintColor = UIColor.Custom.themeColor
        //progressTintColor = UIColor.yellowColor()
        cell.lessonTitle.text = lessons[indexPath.row].lesson?.title
        cell.lessonDescription.text = lessons[indexPath.row].lesson?.description
        cell.completionImg.isHidden = true
        cell.beginSkillBtn.tag = indexPath.row
        cell.beginSkillBtn.backgroundColor = UIColor.Custom.themeColor
        cell.beginSkillBtn.addTarget(self, action: #selector(beginLessonTapped), for: UIControlEvents.touchUpInside)
        
        return cell
    }
    
    @IBAction func beginLessonTapped(_ sender: UIButton) -> Void {
        print(lessons[sender.tag].id)
        
        let lesson = lessons[sender.tag]
        
        if lesson.type == "LESSON_PRESENTATION" {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Lesson", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LessonsPageVC") as! LessonsPageVC
            nextViewController.lessonID = lesson.id
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    
}

extension LessonVC: UICollectionViewDelegate, UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = lessonCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.height + layout.minimumInteritemSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.y + scrollView.contentInset.top)/cellWidthIncludingSpacing
        
        let roundedIndex = round(index)
        
        //offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        offset = CGPoint(x: -scrollView.contentInset.left, y: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.top)

        targetContentOffset.pointee = offset
        
    }
    
    
}
