//
//  ThemeUtil.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/26/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation
import UIKit

class ThemeUtil {
    static let bulletSymbol:String = "\u{2022} "
    
    static func setListItemTextLabelCustom(text: String, listStack: UIStackView) {
        if text != nil && text != "" {
            //let symbolTextView = SymbolTextView(text: text.trimmingCharacters(in: .whitespacesAndNewlines),listSymbol:  "")
            
            let symbolTextLabel = SymbolTextLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            symbolTextLabel.symbolLabel.text = ""
            symbolTextLabel.textLabel.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
            
            symbolTextLabel.textLabel.font.withSize(20)
            symbolTextLabel.textLabel.numberOfLines = 3
            symbolTextLabel.textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            listStack.addArrangedSubview(symbolTextLabel)
        }
        
    }
    static func setListItemTextLabel(text: String, listStack: UIStackView) {
        if text != nil && text != "" {
            let textLabel: UILabel = UILabel()
            
            let attributesDictionary = [NSFontAttributeName : textLabel.font]
            let fullAttributedString = NSMutableAttributedString(string: "", attributes: attributesDictionary)
            let formattedString: String = text
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString)
            let paragraphStyle: NSParagraphStyle = createParagraphAttribute()
            
            attributedString.addAttributes([NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            fullAttributedString.append(attributedString)
            
            textLabel.attributedText = fullAttributedString
            
            textLabel.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
            textLabel.font.withSize(18)
            textLabel.numberOfLines = 12
            textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            listStack.addArrangedSubview(textLabel)
        }
        
    }

    
    static func setParagraphTextLabel(text: String, paraStack: UIStackView) {
        if text != nil && text != "" {
            let textLabel: UILabel = UILabel()
            textLabel.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
            textLabel.font.withSize(18)
            textLabel.numberOfLines = 12
            textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            paraStack.addArrangedSubview(textLabel)
        }
        
    }
    
    static func setParaListTextLabelCustom(text: String, paraStack: UIStackView) {
        if text != nil && text != "" {
            //let textLabel: UILabel = UILabel()
            
            var symbolTextLabel = SymbolTextLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            symbolTextLabel.textLabel.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
            symbolTextLabel.symbolLabel.text = bulletSymbol
                        symbolTextLabel.textLabel.font.withSize(18)
            symbolTextLabel.textLabel.numberOfLines = 3
            symbolTextLabel.textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            symbolTextLabel.translatesAutoresizingMaskIntoConstraints = false
            
            paraStack.addArrangedSubview(symbolTextLabel)
        }
        
    }
    
    static func setParaListTextLabel(text: String, paraStack: UIStackView) {
        if text != nil && text != "" {
            let textLabel: UILabel = UILabel()
            
            let attributesDictionary = [NSFontAttributeName : textLabel.font]
            let fullAttributedString = NSMutableAttributedString(string: "", attributes: attributesDictionary)
            let formattedString: String = bulletSymbol + text
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString)
            let paragraphStyle: NSParagraphStyle = createParagraphAttribute()
            
            attributedString.addAttributes([NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            fullAttributedString.append(attributedString)
            
            textLabel.attributedText = fullAttributedString
            
            //textLabel.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
            textLabel.font.withSize(18)
            textLabel.numberOfLines = 12
            textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            paraStack.addArrangedSubview(textLabel)
        }
        
    }

    
    static func setNumberListItemTextLabelCustom(number: String, text: String, listStack: UIStackView) {
        if text != nil && text != "" {
            //let textLabel: UILabel = UILabel()
            let symbolTextLabel = SymbolTextLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            
            symbolTextLabel.symbolLabel.text = number
            symbolTextLabel.textLabel.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
            symbolTextLabel.textLabel.font.withSize(18)
            symbolTextLabel.textLabel.numberOfLines = 3
            symbolTextLabel.textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            symbolTextLabel.translatesAutoresizingMaskIntoConstraints = false
            
            listStack.addArrangedSubview(symbolTextLabel)
        }
        
    }
    
    static func setNumberListItemTextLabel(number: String, text: String, listStack: UIStackView) {
        if text != nil && text != "" {
            let textLabel: UILabel = UILabel()
            
            let attributesDictionary = [NSFontAttributeName : textLabel.font]
            let fullAttributedString = NSMutableAttributedString(string: "", attributes: attributesDictionary)
            let formattedString: String = number + text
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString)
            let paragraphStyle: NSParagraphStyle = createParagraphAttribute()
            
            attributedString.addAttributes([NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            fullAttributedString.append(attributedString)
            
            textLabel.attributedText = fullAttributedString
            
            textLabel.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
            textLabel.font.withSize(18)
            textLabel.numberOfLines = 12
            textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            listStack.addArrangedSubview(textLabel)
        }

        
    }
    
    static func createParagraphAttribute() -> NSParagraphStyle {
        var paragraphStyle: NSMutableParagraphStyle
        paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: NSDictionary() as! [String : AnyObject])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 15
        
        return paragraphStyle
    }

    static func wrapInHtml(body: String, fontsize: String) -> String {
        var htmlFontSize = "8"
        if fontsize != "" {
            htmlFontSize = fontsize
        }
        
        var html = "<html>"
        html += "<head>"
        html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
        html += "<style> body { font-size: \(htmlFontSize)px; padding: 0 !important; margin: 0 !important} </style>"
        /*html += "<script type=\"text/javascript\">"
         html += "window.onload = function() {"
         html +=  "window.location.href = \"ready://\" + document.body.offsetHeight; }"
         html += "</script>"*/
        html += "</head>"
        html += "<body>"
        html += body
        html += "</body>"
        html += "</html>"
        
        return html
    }

    
}