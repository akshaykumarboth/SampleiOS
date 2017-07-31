//
//  pagerViewController.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/28/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class pagerViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    //var tasks: Array<Tasks> = []
    
    //var vcList: [UIViewController] = []
    /*var viewControllerList: [UIViewController] = [
     UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(withIdentifier: "redVC"), UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(withIdentifier: "blueVC")]*/
    
    var viewControllerList:[UIViewController] = {
        let storyboard = UIStoryboard(name: "Tab", bundle: nil)
        /*var tasks: Array<Tasks> = []
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            tasks = ComplexObject(JSONString: complexCache).tasks!
        }
        
        var vcList:[UIViewController] = []
        
        for task in tasks {
            if task.itemType == "LESSON_INTERACTIVE" {
                //var temp = storyboard as! RedVC
                let vc1 = storyboard.instantiateViewController(withIdentifier: "redVC")
                vcList.append(vc1)
                
            } else if task.itemType == "LESSON_PRESENTATION" {
                //var temp = storyboard as! GreenVC
                let vc1 = storyboard.instantiateViewController(withIdentifier: "blueVC")
                vcList.append(vc1)
            }
        }*/
        let vc1 = storyboard.instantiateViewController(withIdentifier: "redVC")
        let vc2 = storyboard.instantiateViewController(withIdentifier: "blueVC")
        let vc3 = storyboard.instantiateViewController(withIdentifier: "greenVC")
        let vc4 = storyboard.instantiateViewController(withIdentifier: "redVC")
        
        return [vc1, vc2,vc3, vc4]
        //return vcList
    }()
    
    /*func VCInstance(name: String)-> UIViewController {
        var sb = UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(withIdentifier: name)
        if name == "redVC" {
            var temp = sb as! RedVC
        } else if name == "redVC" {
            var temp = sb as! RedVC
        }

    }*/

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        
        /*for task in tasks {
            if task.itemType == "LESSON_PRESENTATION" {
                let vc1 = storyboard?.instantiateViewController(withIdentifier: "redVC")
                vcList.append(vc1!)
            } else if task.itemType == "LESSON_INTERACTIVE" {
                let vc1 = storyboard?.instantiateViewController(withIdentifier: "greenVC")
                vcList.append(vc1!)
            }
        }*/
        //
        self.dataSource = self
        if let firstVC = viewControllerList.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
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
