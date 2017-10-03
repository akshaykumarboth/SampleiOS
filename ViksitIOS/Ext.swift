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

extension UILabel {
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(self.font!.pointSize)\">%@</span>" as NSString, htmlText) as String
    
        //process collection values
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        self.attributedText = attrStr
    }
    
    func wrapInHtml(body: String) -> String {
        
        var html = "<html>"
        html += "<head>"
        html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
        html += "<style> body { padding: 0 !important; margin: 0 !important } </style>"
        /*html += "<script type=\"text/javascript\">"
         html += "window.onload = function() {"
         html +=  "window.location.href = \"ready://\" + document.body.offsetHeight; }"
         html += "</script>"*/
        html += "</head>"
        html += "<body><span>"
        html += body.trimmingCharacters(in: .whitespacesAndNewlines)
        html += "</span></body>"
        html += "</html>"
        
        return html
    }
}

extension UITextView {
    func setHTMLFromString(htmlText: String) {
        
        let modifiedFont = NSString(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(self.font!.pointSize)\">%@</span>" as NSString, htmlText) as String
        
        //process collection values
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        self.attributedText = attrStr
    }
    
    func wrapInHtml(body: String) -> String {
        
        var html = "<html>"
        html += "<head>"
        html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
        html += "<style> body { padding: 0 !important; margin: 0 !important } </style>"
        /*html += "<script type=\"text/javascript\">"
         html += "window.onload = function() {"
         html +=  "window.location.href = \"ready://\" + document.body.offsetHeight; }"
         html += "</script>"*/
        html += "</head>"
        html += "<body><span>"
        html += body.trimmingCharacters(in: .whitespacesAndNewlines)
        html += "</span></body>"
        html += "</html>"
        
        return html
    }

}

 extension UIColor {
    
     struct Custom {
        static let themeColor = UIColor(red:0.92, green:0.22, blue:0.31, alpha:1.0)
        static let skyBlueColor = UIColor(red:0.14, green:0.71, blue:0.98, alpha:1.0)
    }
    
}

extension UIFont {
        struct Custom {
            static let headerSize = UIFont.boldSystemFont(ofSize: 14)
    }
    
}

extension CGFloat {
    struct Custom {
         static let topActionBarHeight: CGFloat = 50
    }
}

extension UIButton {
    func makeButtonRound(borderWidth: CGFloat, borderColor: UIColor){
        self.layer.cornerRadius = self.frame.width/2
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
    }
}

extension UIImageView {
    func makeImageRound(){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        
    }
}

struct Constant {
    static let localUrlString: String = "http://192.168.1.4:8080/"
    static let prodUrlString: String = "http://elt.talentify.in/"
}
