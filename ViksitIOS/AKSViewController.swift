//
//  AKSViewController.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/1/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class AKSViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var slideScrollView: UIScrollView!
    
    @IBOutlet var pageControl: UIPageControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideScrollView.delegate = self
        let slides: [Slide] = createSlides()
        setupSlideScrollView(slides: slides)
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        
    }

    func createSlides() -> [Slide]{
        
        
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.label.text = "Slide 1"
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.label.text = "Slide 2"
        
        return [slide1, slide2]
    }
    
    func setupSlideScrollView(slides: [Slide]) {
        //slideScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        slideScrollView.contentSize = CGSize(width: slideScrollView.frame.width * CGFloat(slides.count), height: slideScrollView.frame.height)
        slideScrollView.isPagingEnabled = true
        //slideScrollView.is
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            
            slideScrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
    }

}
