//
//  QTextAttributes.swift
//  QKit
//
//  Created by Jun-kyu Jeon on 12/04/2018.
//  Copyright © 2018 - present Jun-kyu Jeon. All rights reserved.
//

import UIKit

class QTextAttributes: NSObject {
    var foregroundColour = #colorLiteral(red: 0.337254902, green: 0.3529411765, blue: 0.3607843137, alpha: 1)
    var font = UIFont.systemFont(ofSize: 14)
    var link: Any?
    var alignment: NSTextAlignment?
    var lineHeight: CGFloat?
    
    var attributes: [NSAttributedString.Key:Any] {
        get {
            var output = [NSAttributedString.Key:Any]()
            output[.foregroundColor] = foregroundColour
            output[.font] = font
            
            if link != nil {
                output[.link] = link!
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            if alignment != nil {
                paragraphStyle.alignment = alignment!
            }
            
            if lineHeight != nil {
                paragraphStyle.minimumLineHeight = lineHeight!
            }
            
            output[.paragraphStyle] = paragraphStyle
            output[.underlineColor] = UIColor.clear
            
            return output
        }
    }
    
    var typeAttributes: [String:Any] {
        get {
            var output = [String:Any]()
            output[NSAttributedString.Key.foregroundColor.rawValue] = foregroundColour
            output[NSAttributedString.Key.font.rawValue] = font
            
            if link != nil {
                output[NSAttributedString.Key.link.rawValue] = link!
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            if alignment != nil {
                paragraphStyle.alignment = alignment!
            }
            
            if lineHeight != nil {
                paragraphStyle.minimumLineHeight = lineHeight!
            }
            
            output[NSAttributedString.Key.paragraphStyle.rawValue] = paragraphStyle
            output[NSAttributedString.Key.underlineColor.rawValue] = UIColor.clear
            
            return output
        }
    }
    
    convenience override init() {
        self.init(withForegroundColour: nil, font: nil)
    }
    
    convenience init(withForegroundColour colour: UIColor?, font aFont: UIFont?) {
        self.init(withForegroundColour: colour, font: aFont, link: nil)
    }
    
    convenience init(withForegroundColour colour: UIColor?, font aFont: UIFont?, link aLink: Any?) {
        self.init(withForegroundColour: colour, font: aFont, link: aLink, alignment: nil, lineHeight: nil)
    }
    
    convenience init(withForegroundColour colour: UIColor? = nil, font aFont: UIFont? = nil, lineHeight lHeight: CGFloat? = nil) {
        self.init(withForegroundColour: colour, font: aFont, link: nil, alignment: nil, lineHeight: lHeight)
    }
    
    init(withForegroundColour colour: UIColor? = nil, font aFont: UIFont? = nil, link aLink: Any? = nil, alignment anAlignment: NSTextAlignment? = nil, lineHeight lHeight: CGFloat? = nil) {
        super.init()
        
        foregroundColour = colour ?? #colorLiteral(red: 0.337254902, green: 0.3529411765, blue: 0.3607843137, alpha: 1)
        font = aFont ?? UIFont.systemFont(ofSize: 14)
        link = aLink
        alignment = anAlignment
        lineHeight = lHeight
    }
    
    class func attributes(from typingAttributes: [String:Any]) -> QTextAttributes {
        let foregroundColour = typingAttributes[NSAttributedString.Key.foregroundColor.rawValue] as? UIColor
        let font = typingAttributes[NSAttributedString.Key.font.rawValue] as? UIFont
        let link = typingAttributes[NSAttributedString.Key.link.rawValue]
        let paragraphStyle = typingAttributes[NSAttributedString.Key.paragraphStyle.rawValue] as? NSParagraphStyle
        
        return QTextAttributes(withForegroundColour: foregroundColour, font: font, link: link, alignment: paragraphStyle?.alignment)
    }
    
    class func attributes(from attributes: [NSAttributedString.Key:Any]) -> QTextAttributes {
        let foregroundColour = attributes[.foregroundColor] as? UIColor
        let font = attributes[.font] as? UIFont
        let link = attributes[.link]
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        
        return QTextAttributes(withForegroundColour: foregroundColour, font: font, link: link, alignment: paragraphStyle?.alignment)
    }
}
