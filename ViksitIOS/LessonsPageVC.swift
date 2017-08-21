//
//  LessonsPageVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class LessonsPageVC: UIPageViewController {
    
    var vCList : [UIViewController] = {
        let sb = UIStoryboard(name: "Lesson", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "NO_CONTENT")
        let vc2 = sb.instantiateViewController(withIdentifier: "ONLY_2BOX")
        let vc3 = sb.instantiateViewController(withIdentifier: "ONLY_2TITLE")
        let vc4 = sb.instantiateViewController(withIdentifier: "NO_CONTENT")
        
        return [vc1, vc2, vc3, vc4]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        if let firstVC = vCList.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }

   
}

extension LessonsPageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = vCList.index(of: viewController) else { return nil }
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        guard vCList.count > previousIndex else { return nil }
        return vCList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = vCList.index(of: viewController) else { return nil }
        let nextIndex = vcIndex + 1

        guard vCList.count != nextIndex else { return nil }
        guard vCList.count > nextIndex else { return nil }
        return vCList[nextIndex]
    }
    
}
