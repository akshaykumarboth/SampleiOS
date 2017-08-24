//
//  LessonsPageVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/21/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit
import SWXMLHash

class LessonsPageVC: UIPageViewController {
    var slideList: [CMSlide] = []
    var vCList : [UIViewController] = []
    var tasks: [Tasks] = []
    /*
    lazy var vCList : [UIViewController] = {
        let sb = UIStoryboard(name: "Lesson", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "NO_CONTENT")
        let vc2 = sb.instantiateViewController(withIdentifier: "ONLY_2BOX")
        let vc3 = sb.instantiateViewController(withIdentifier: "ONLY_2TITLE")
        let vc4 = sb.instantiateViewController(withIdentifier: "NO_CONTENT")
        
        return [vc1, vc2, vc3, vc4]
    }()
    */
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //xmlParsing()
        //setPages()
        //
        
        
        self.xmlParsing { () -> () in
            self.setPages()
        }
        
        //
                // Do any additional setup after loading the view.
        
    }
    
    func xmlParsing(handleComplete:(()->())){
        // do something
        do {
            //let lessonResponse: String = Helper.makeHttpCall (url : "http://cdn.talentify.in:9999/lessonXMLs/163/163/163.xml", method: "GET", param: [:])
            //let xml = try! SWXMLHash.parse(lessonResponse)
            
            //from cache memory
            let xmlCahe = DataCache.sharedInstance.cache["lesson"]
            let xml = try! SWXMLHash.parse(xmlCahe!)
            
            if xml["lesson"] != nil {
                var list2: Array<CMSlide> = []
                print("children are \(xml["lesson"].children.count)")
                for i in 0..<xml["lesson"].children.count {
                    if xml["lesson"].children[i].element?.name == "slide" {
                        list2.append(CMSlide(xml: xml["lesson"].children[i] ))
                    }
                    print("\n")
                }
                self.slideList = list2
            }
        } catch let error as IndexingError {
            // error is an IndexingError instance that you can deal with
            print("error is -> \(error)")
        }
        
        handleComplete() // call it when finished something what you want
    }
    func setPages(){
        // do something
        
        let sb = UIStoryboard(name: "Lesson", bundle: nil)
        print("list count is \(slideList.count)")
        var ii: Int = 0
        for slide in slideList {
            print("slide type is \(slide.templateName)")
            if slide.templateName == "ONLY_TITLE" {
                
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_TITLE") as! ONLY_TITLE
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } /*else if slide.slide_type == "NO_CONTENT"{
                let vc1 = sb.instantiateViewController(withIdentifier: "NO_CONTENT")
                vCList.append(vc1)
            }else if slide.slide_type == "ONLY_TITLE_LIST"{
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_TITLE_LIST")
                vCList.append(vc1)
            }else if slide.slide_type == "ONLY_2TITLE"{
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_2TITLE")
                vCList.append(vc1)
            }else if slide.slide_type == "ONLY_TITLE_PARAGRAPH_IMAGE_LIST"{
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_TITLE_PARAGRAPH_IMAGE_LIST")
                vCList.append(vc1)
            }else if slide.slide_type == "ONLY_2TITLE"{
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_2TITLE")
                vCList.append(vc1)
            }*/
        ii += 1
        }
 
        print("ii: \(ii)")
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = vCList.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
   
}

extension LessonsPageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
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
