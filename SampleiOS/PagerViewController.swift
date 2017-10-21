//
//  PagerViewController.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/24/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class PagerViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var tasks: Array<Tasks> = []
    var viewControllerList: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setPages()
        // Do any additional setup after loading the view.
    }
    
    func setPages() {
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            tasks = ComplexObject(JSONString: complexCache as! String).tasks!
        }
        
        let storyboard = UIStoryboard(name: "Lesson", bundle: nil)
        for task in tasks {
            if task.itemType == "LESSON_PRESENTATION" {
                let vc1 = storyboard.instantiateViewController(withIdentifier: "RedVC")
                viewControllerList.append(vc1)
            } else if task.itemType == "LESSON_INTERACTIVE" {
                let vc1 = storyboard.instantiateViewController(withIdentifier: "GreenVC")
                viewControllerList.append(vc1)
            }
        }
        
        self.dataSource = self
        self.delegate = self
        if let firstVC = viewControllerList.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else { return nil }
        let prevIndex = vcIndex-1
        
        guard prevIndex >= 0 else { return nil }
        guard viewControllerList.count > prevIndex else { return nil}
        
        return viewControllerList[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else { return nil }
        let nextIndex = vcIndex + 1
        
        guard viewControllerList.count != nextIndex else { return nil}
        guard viewControllerList.count > nextIndex else { return nil}
        
        return viewControllerList[nextIndex]
    }
    
    
}
