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
    var lessonID: Int!
    var lessonResponse: String = ""
    
    var pageIsAnimating = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.xmlParsing { () -> () in
            self.setPages()
        }
        
        //
        // Do any additional setup after loading the view.
        
    }
    
    func xmlParsing(handleComplete:(()->())){
        // do something
        do {
            //lessonResponse = Helper.makeHttpCall (url : "http://cdn.talentify.in:9999/lessonXMLs/163/163/163.xml", method: "GET", param: [:])
            print(lessonID)
            if let lessonid = lessonID {
                lessonResponse = Helper.makeHttpCall (url : "http://cdn.talentify.in:9999/lessonXMLs/\(lessonid)/\(lessonid)/\(lessonid).xml", method: "GET", param: [:])
            }
            
            print(lessonResponse)
            let xml = try! SWXMLHash.parse(lessonResponse)
            
            //from cache memory
            //let xmlCahe = DataCache.sharedInstance.cache["lesson"]
            //let xml = try! SWXMLHash.parse(xmlCahe!)
            
            if xml["lesson"] != nil {
                var list2: Array<CMSlide> = []
                //print("children are \(xml["lesson"].children.count)")
                for i in 0..<xml["lesson"].children.count {
                    if xml["lesson"].children[i].element?.name == "slide" {
                        list2.append(CMSlide(xml: xml["lesson"].children[i] ))
                    }
                    //print("\n")
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
        //print("list count is \(slideList.count)")
        var ii: Int = 0
        for slide in slideList { //NO_CONTENT
            print("slide template name is \(slide.templateName)")
            if slide.templateName == "NO_CONTENT" {
                let vc1 = sb.instantiateViewController(withIdentifier: "NO_CONTENT") as! NO_CONTENT
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_2BOX" {
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_2BOX") as! ONLY_2BOX
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_2TITLE" {
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_2TITLE") as! ONLY_2TITLE
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_2TITLE_IMAGE" {
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_2TITLE_IMAGE") as! ONLY_2TITLE_IMAGE
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_LIST" {
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_LIST") as! ONLY_LIST
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_LIST_NUMBERED" {
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_LIST_NUMBERED") as! ONLY_LIST_NUMBERED
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_PARAGRAPH" {
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_PARAGRAPH") as! ONLY_PARAGRAPH
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_PARAGRAPH_IMAGE_LIST" {
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_PARAGRAPH_IMAGE_LIST") as! ONLY_PARAGRAPH_IMAGE_LIST
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_PARAGRAPH_TITLE" {
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_PARAGRAPH_TITLE") as! ONLY_PARAGRAPH_TITLE
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_PARAGRAPH_TITLE_LIST" {
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_PARAGRAPH_TITLE_LIST") as! ONLY_PARAGRAPH_TITLE_LIST
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_PARAGRAPH_IMAGE" {
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_PARAGRAPH_IMAGE") as! ONLY_PARAGRAPH_IMAGE
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_TITLE" {
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_TITLE") as! ONLY_TITLE
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_TITLE_LIST_NUMBERED" {
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_TITLE_LIST_NUMBERED") as! ONLY_TITLE_LIST_NUMBERED
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_TITLE_PARAGRAPH" {
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_TITLE_PARAGRAPH") as! ONLY_TITLE_PARAGRAPH
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_TITLE_PARAGRAPH_cells_fragemented" {
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_TITLE_PARAGRAPH_cells_fragemented") as! ONLY_TITLE_PARAGRAPH_cells_fragemented
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_TITLE_PARAGRAPH_IMAGE"{
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_TITLE_PARAGRAPH_IMAGE") as! ONLY_TITLE_PARAGRAPH_IMAGE
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_TITLE_PARAGRAPH_IMAGE_LIST"{
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_TITLE_PARAGRAPH_IMAGE_LIST") as! ONLY_TITLE_PARAGRAPH_IMAGE_LIST
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            } else if slide.templateName == "ONLY_TITLE_IMAGE"{
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_TITLE_IMAGE") as! ONLY_TITLE_IMAGE
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            }else if slide.templateName == "ONLY_TITLE_LIST"{
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_TITLE_LIST") as! ONLY_TITLE_LIST
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            }else if slide.templateName == "ONLY_TITLE_TREE"{
                
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_TITLE_TREE") as! ONLY_TITLE_TREE
                vc1.slide = slideList[ii]
                //vCList.append(vc1)
 
            }else if slide.templateName == "ONLY_VIDEO"{
                let vc1 = sb.instantiateViewController(withIdentifier: "ONLY_VIDEO") as! ONLY_VIDEO
                vc1.slide = slideList[ii]
                vCList.append(vc1)
            }
        ii += 1
        }
 
        //print("ii: \(ii)")
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = vCList.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
   
}

extension LessonsPageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if self.pageIsAnimating {
            return nil
        }
        guard let vcIndex = vCList.index(of: viewController) else { return nil }
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        guard vCList.count > previousIndex else { return nil }
        
        return vCList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if self.pageIsAnimating {
            return nil
        }
        guard let vcIndex = vCList.index(of: viewController) else { return nil }
        let nextIndex = vcIndex + 1

        guard vCList.count != nextIndex else { return nil }
        guard vCList.count > nextIndex else { return nil }
        
        return vCList[nextIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        self.pageIsAnimating = true
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished || completed {
            self.pageIsAnimating = false
        }
    }
    
}
