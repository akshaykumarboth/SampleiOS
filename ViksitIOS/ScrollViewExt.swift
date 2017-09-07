//
//  ScrollViewExt.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/7/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}
