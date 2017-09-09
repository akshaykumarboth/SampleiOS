//
//  HIddenTableVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/8/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class HIddenTableVC: UIViewController {
    
    
    @IBOutlet var hitMeBtn: UIButton!
    @IBOutlet var quesTableList: UITableView!
    @IBOutlet var centerYconstraint: NSLayoutConstraint!
    
    @IBAction func showTable(_ sender: UIButton) {
        centerYconstraint.constant = 0
        
        UIView.animate(withDuration: 0.7, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func closeTable(_ sender: UIButton) {
        centerYconstraint.constant = 1000
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @IBOutlet var tableViewContainer: UIView!
    @IBOutlet var viewAllBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quesTableList.rowHeight = UITableViewAutomaticDimension
        quesTableList.estimatedRowHeight = 140
        setViewAllImageToRight(viewAllBtn: viewAllBtn)
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
    
    func s() {
        var screen = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        screen.direction = UISwipeGestureRecognizerDirection.up
        hitMeBtn.addGestureRecognizer(screen)
    }
    
    func swipeAction(swipe: UISwipeGestureRecognizer) {
        if let swipeGesture = swipe as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                centerYconstraint.constant = 0
                
                UIView.animate(withDuration: 0.7, animations: {
                    self.view.layoutIfNeeded()
                })

                print("Swiped up")
            default:
                break
            }
        }
    }
    

}

extension HIddenTableVC: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        let cell = tableView.dequeueReusableCell(withIdentifier: "HiddenTableCell", for: indexPath) as! HiddenTableCell
        
        cell.questionText.setText(text: "What is the deepest point of the world ?", symbolCode: String(indexPath.row + 1))
        cell.questionText.setFontSize(textSize: 100)
        cell.questionText.setSpacing(spacing: 5)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(roles[indexPath.row].id as Any)
        
    }
    
}
