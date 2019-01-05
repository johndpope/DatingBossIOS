//
//  QUtils.swift
//  QKit
//
//  Created by Jun-kyu Jeon on 1/1/16.
//  Copyright © 2016 - present Jun-kyu Jeon. All rights reserved.
//

import UIKit
import Photos

class QUtils: NSObject {
    class func contentAttributedString(with content: String, attributes normalAttr: [NSAttributedString.Key:Any], highlighted highlightedAttr: [NSAttributedString.Key:Any]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: content, attributes: normalAttr)
        
        if content.count < 1 {
            return attributedString
        }
        
        var startIdx = -1
        var length = 0
        
        for i in 0 ..< content.count {
            let char = Array(content)[i]
            
            if startIdx != -1 {
                length += 1
                if i == content.count - 1 || char == " " || char == "@" || char == "#" {
                    if length > 1 {
                        attributedString.addAttributes(highlightedAttr, range: NSMakeRange(startIdx, length))
                    }
                    
                    startIdx = -1
                    length = 0
                }
            }
            
            if startIdx == -1 {
                if char == "@" || char == "#" {
                    startIdx = i
                    length = 1
                }
            }
        }
        
        return attributedString
    }
    
    class func pointOnCircle(radius:Float, center:CGPoint, angle: Float) -> CGPoint {
        let x = CGFloat(radius * cos(angle))
        let y = CGFloat(radius * sin(angle))
        return CGPoint(x: x + center.x, y: y + center.y)
    }
    
//    class func getQuadrant(of point: CGPoint, in rect: CGRect) -> Quadrant {
//        let actualX = point.x - rect.origin.x
//        let actualY = point.y - rect.origin.y
//
//        if actualX < 0 || actualY < 0 || actualX > rect.size.width || actualY > rect.size.height {
//            return .outOfRange
//        }
//
//        if actualX > rect.size.width / 2 {
//            if actualY < rect.size.height / 2 {return .first}
//            return .second
//        }
//
//        if actualY < rect.size.height / 2 {return .fourth}
//        return .third
//    }
    
    class func recognizedString(from recognizer: UIGestureRecognizer, seperatedBy seperator: String? = nil, target label: UILabel? = nil) -> String? {
        guard let textLabel = label ?? recognizer.view as? UILabel else {return nil}
        let tapLocation = recognizer.location(in: textLabel)
        
        let textStorage: NSTextStorage = NSTextStorage(attributedString: textLabel.attributedText!)
        let layoutManager: NSLayoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer: NSTextContainer = NSTextContainer(size: CGSize(width: textLabel.frame.size.width, height: textLabel.frame.size.height + 100))
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = textLabel.numberOfLines
        textContainer.lineBreakMode = textLabel.lineBreakMode
        
        layoutManager.addTextContainer(textContainer)
        
        let charIdx = layoutManager.characterIndex(for: tapLocation, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        var selectedString: String? = nil
        
        let theString = textLabel.attributedText!.string
        if seperator != nil {
            let strArr = theString.components(separatedBy: seperator!)
            
            var followingIndex: Int = 0
            
            for i in 0 ..< strArr.count {
                followingIndex += strArr[i].count
                
                if charIdx > followingIndex {
                    followingIndex += 1
                    continue
                }
                
                selectedString = strArr[i]
                break
            }
        } else {
            let charecters = Array(theString)
            
            if charecters.count <= charIdx {return nil}
            
            if charecters[charIdx] != " " {
                var start = -1
                var prefix: String?
                
                let theChar = charecters[charIdx]
                
                if theChar == "@" || theChar == "#"{
                    start = charIdx
                } else {
                    for i in 0 ..< charIdx + 1 {
                        let aChar = charecters[i]
                        
                        if aChar == " " || aChar == "@" || aChar == "#" {
                            start = i
                            
                            prefix = String(theChar)
                            
                            if prefix == " " {
                                prefix = nil
                            }
                        }
                    }
                }
                
                if start != -1 && prefix != " " {
                    var length = 1
                    
                    for i in start + 1 ..< theString.count {
                        let aChar = charecters[i]
                        
                        if aChar == " " || aChar == "@" || aChar == "#" || aChar == "\n" {
                            break
                        }
                        
                        length += 1
                    }
                    
                    let startIdx = theString.index(theString.startIndex, offsetBy: start)
                    let endIdx = theString.index(theString.startIndex, offsetBy: start + length)
                    
                    selectedString = String(theString[startIdx ..< endIdx])
                }
            }
        }
        
        return selectedString
    }
    
    class func labelWith(text: String, font: UIFont, width: CGFloat) -> UILabel {
        return QUtils.labelWith(text: text, font: font, width: width, numberOfLines: 0)
    }
    
    class func labelWith(text: String, font: UIFont, width: CGFloat, numberOfLines: Int) -> UILabel {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        
        return label
    }
    
    class func labelWith(attributedString: NSAttributedString, width: CGFloat) -> UILabel {
        return labelWith(attributedString: attributedString, width: width, numberOfLines: 0)
    }
    
    class func labelWith(attributedString: NSAttributedString, width: CGFloat, numberOfLines: Int) -> UILabel {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.attributedText = attributedString
        
        label.sizeToFit()
        
        return label
    }
    
    class func getNumberOfLinesNeeded(_ label: UILabel) -> Int {
        var cntLines: Int = 0
        
        label.numberOfLines = 0
        
        let rHeight = QUtils.heightForView(text: label.text!, font: label.font, width: label.frame.size.width)
        let charSize = label.font.lineHeight
        
        cntLines = Int(rHeight / charSize)
        
        return cntLines
    }
    
    class func widthForView(text: String, font: UIFont) -> CGFloat {
        let label: UILabel = UILabel()
        label.text = text
        label.font = font
        
        label.sizeToFit()
        
        return label.frame.size.width
    }
    
    class func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label: UILabel = QUtils.labelWith(text: text, font: font, width: width)
        return label.frame.height
    }
    
    class func wrappedString(_ string: String?) -> String! {
        if string == nil {
            return ""
        }
        
        return string!
    }
    
    class func heightForTextView(text: String?, textContainerInsets: UIEdgeInsets?, width: CGFloat, font: UIFont) -> CGFloat {
        if text == nil {return 0}
        
        return QUtils.heightForTextView(attributedText: NSAttributedString(string: text!, attributes: [NSAttributedString.Key.font:font]), textContainerInsets: textContainerInsets, width: width)
    }
    
    class func heightForTextView(attributedText: NSAttributedString, textContainerInsets: UIEdgeInsets?, width: CGFloat) -> CGFloat {
        let textView = UITextView()
        textView.attributedText = attributedText
        let size = textView.sizeThatFits(CGSize(width: width, height: CGFloat(Float.greatestFiniteMagnitude)))
        return size.height
    }
    
    class func objectToString(_ object: AnyObject?) -> String? {
        if object == nil {
            return nil
        }
        
        var returnString: String? = object as? String
        
        if returnString != nil {
            return returnString
        }
        
        if (object as? NSNumber) != nil {
            returnString = String(format: "%i", (object as! NSNumber).intValue)
        }
        
        return returnString
    }
    
    class func objectToWrappedString(_ object: AnyObject?) -> String! {
        let string = QUtils.objectToString(object)
        
        return QUtils.wrappedString(string)
    }
    
//    class func ratio(with type: ImageRatioType) -> Double {
//        var ratio: Double = 0
//
//        switch type {
//        case .square:
//            ratio = 1
//            break
//
//        case .portrait:
//            ratio = 1.33
//            break
//
//        case .landscape:
//            ratio = 0.75
//            break
//
//        default:
//            break
//        }
//
//        return ratio
//    }
    
    class func isKorean() -> Bool {
        var korean: Bool = false
        
        if Locale.preferredLanguages.first!.range(of: "ko") != nil {
            korean = true
        }
        
        return korean
    }
    
//    class func errorOnEmail(_ email: String?) -> String? {
//        var errMessage: String? = nil
//        
//        if email == nil || (email ?? "").count < 1 {
//            errMessage = kStringErrorNoEmail
//        } else if email!.isValidEmail() == false {
//            errMessage = kStringErrorUnavailableEmail
//        }
//        
//        return errMessage
//    }
//    
//    class func errorOnPassword(_ password: String?) -> String? {
//        var errMessage: String? = nil
//        
//        if password == nil || (password ?? "").count < 1 {
//            errMessage = kStringErrorNoPassword
//        } else if password!.count < 8 {
//            errMessage = kStringErrorPasswordNotAllowedFormat
//        } else {
//            var hasAlphabet: Bool = false
//            var hasNumber: Bool = false
//            
//            for char in Array(password!) {
//                if char.isAlphabet() {
//                    hasAlphabet = true
//                } else if char.isDigit() {
//                    hasNumber = true
//                } else {
//                    errMessage = kStringErrorPasswordNotAllowedFormat
//                    break
//                }
//            }
//            
//            if hasAlphabet != true || hasNumber != true {
//                errMessage = kStringErrorPasswordNotAllowedFormat
//            }
//        }
//        
//        return errMessage
//    }
    
    class func getAssetThumbnail(_ asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.resizeMode = .exact
        option.deliveryMode = .fastFormat
        option.isSynchronous = false
        option.isNetworkAccessAllowed = true
        
        manager.requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
    
    class func getImageDataFromAsset(_ asset: PHAsset) -> Data? {
        let manager = PHImageManager.default()
        
        let option = PHImageRequestOptions()
//        option.resizeMode = .Exact
        option.deliveryMode = .fastFormat
        option.isSynchronous = false
        option.isNetworkAccessAllowed = true
        
        var imageData: Data?
        
        manager.requestImageData(for: asset, options: option, resultHandler: {(data, dataUTI, orientation, info) -> Void in
            imageData = data
        })
        
        return imageData
    }
    
    class func highlightedAttributedString(string: String, normalColour: UIColor, normalFont: UIFont, highlightedColour: UIColor, highlightedFont: UIFont, divString: String) -> NSAttributedString {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString()
        
        let words = string.components(separatedBy: divString)
        
        for i in 0 ..< words.count {
            var colour: UIColor = normalColour
            var font: UIFont = normalFont
            
            if i % 2 == 1 {
                colour = highlightedColour
                font = highlightedFont
            }
            
            attributedString.append(NSAttributedString(string: "\(words[i])", attributes: [NSAttributedString.Key.foregroundColor:colour, NSAttributedString.Key.font:font]))
        }
        
        return attributedString
    }
    
    class func optimizeRatio() -> CGFloat {
        return UIScreen.main.bounds.size.width / 414
    }
    
//        var refWidth: CGFloat = 414
//        if kReferenceiPhone == ReferenceType.iPhone4 || kReferenceiPhone == ReferenceType.iPhone3_5 {
//            refWidth = 320
//        } else if kReferenceiPhone == ReferenceType.iPhone4_7 {
//            refWidth = 375
//        }
//        
//        if UIScreen.main.bounds.size.width > refWidth {
//            return 1
//        }
//        
//        let ratio: CGFloat = UIScreen.main.bounds.size.width / refWidth
//        
//        return ratio
//    }
}
