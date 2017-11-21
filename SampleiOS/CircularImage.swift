//
//  CircularImage.swift
import UIKit

class CircularImage: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius: CGFloat = self.bounds.size.width / 2.0
        clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    

}
