//
//  Image.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 23/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit
import CoreGraphics

// MARK: Custom Images
extension UIImage {
    class var navigationBackwardImage: UIImage {
        let settings = QImageSettings()
        settings.colour = #colorLiteral(red: 0.4274509804, green: 0.4274509804, blue: 0.4274509804, alpha: 1)
        settings.size = CGSize(width: 13.4 * QUtils.optimizeRatio(), height: 26.8 * QUtils.optimizeRatio())
        settings.thickness = 3
        
        var vertexes = [CGPoint]()
        vertexes.append(CGPoint(x: 0.85, y: 0.15))
        vertexes.append(CGPoint(x: 0.15, y: 0.5))
        vertexes.append(CGPoint(x: 0.85, y: 0.85))
        
        return QImageMaker.shapeButton(with: settings, vertexes: vertexes, isClosedPath: false) ?? UIImage()
    }
    
    class var navigationForwardImage: UIImage {
        let settings = QImageSettings()
        settings.colour = #colorLiteral(red: 0.4274509804, green: 0.4274509804, blue: 0.4274509804, alpha: 1)
        settings.size = CGSize(width: 13.4 * QUtils.optimizeRatio(), height: 26.8 * QUtils.optimizeRatio())
        settings.thickness = 3
        
        var vertexes = [CGPoint]()
        vertexes.append(CGPoint(x: 0.15, y: 0.15))
        vertexes.append(CGPoint(x: 0.85, y: 0.5))
        vertexes.append(CGPoint(x: 0.15, y: 0.85))
        
        return QImageMaker.shapeButton(with: settings, vertexes: vertexes, isClosedPath: false) ?? UIImage()
    }
    
    class var navigationCloseImage: UIImage {
        let settings = QImageSettings()
        settings.colour = #colorLiteral(red: 0.4274509804, green: 0.4274509804, blue: 0.4274509804, alpha: 1)
        settings.size = CGSize(width: 25 * QUtils.optimizeRatio(), height: 25 * QUtils.optimizeRatio())
        settings.thickness = 3
        
        return QImageMaker.closeButton(with: settings) ?? UIImage()
    }
}

// MARK: Functions
extension UIImage {
    func resize(withRatio ratio: CGFloat) -> UIImage {
        var newSize = self.size
        newSize.width *= ratio
        newSize.height *= ratio
        return self.resize(withSize: newSize)
    }
    
    func resize(withSize newSize: CGSize) -> UIImage {
        return self.resize(withSize: newSize, spacing: 0)
    }
    
    func resize(withSize newSize: CGSize, spacing: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        
        var origin = CGPoint.zero
        origin.x = spacing
        origin.y = spacing
        
        var size = newSize
        size.width -= spacing * 2
        size.height -= spacing * 2
        
        self.draw(in: CGRect(origin: origin, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
    
    func resize(maximumSize: CGSize) -> UIImage {
        return self.resize(maxWidth: maximumSize.width, maxHeight: maximumSize.height)
    }
    
    func resize(maxWidth: CGFloat? = nil, maxHeight: CGFloat? = nil) -> UIImage {
        var newSize = self.size
        
        let width = maxWidth ?? CGFloat.infinity
        let height = maxHeight ?? CGFloat.infinity
        
        if newSize.width > width {
            newSize.height *= width / newSize.width
            newSize.width = width
        }
        
        if newSize.height > height {
            newSize.width *= height / newSize.height
            newSize.height = height
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
    
    class func withSolid(colour: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        return UIImage.withSolid(colour: colour, rect: rect)
    }
    
    class func withSolid(colour: UIColor, rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(rect.size);
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(colour.cgColor);
        context.fill(rect);
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        
        return image
    }
    
    class func withGradient(colours: [CGColor], startPoint: CGPoint, endPoint: CGPoint, rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(rect.size);
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        let margin: CGFloat = 1.0 / CGFloat(colours.count - 1)
        var locations = [CGFloat]()
        for i in 0 ..< colours.count {
            locations.append(margin * CGFloat(i))
        }
        
        let colorspace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient: CGGradient = CGGradient(colorsSpace: colorspace, colors: colours as CFArray, locations: locations)!
        
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func recolour(with colour: UIColor) -> UIImage {
        var newSize = self.size
        newSize.width *= UIScreen.main.scale
        newSize.height *= UIScreen.main.scale
        UIGraphicsBeginImageContext(newSize)
        
        guard let ctx = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage else {return self}
        
        var backgroundRect = CGRect.zero
        backgroundRect.size = newSize
        
        ctx.setFillColor(colour.cgColor)
        ctx.fill(backgroundRect)
        
        var imageRect = CGRect.zero
        imageRect.size = newSize
        
        // Unflip the image
        ctx.translateBy(x: 0, y: backgroundRect.size.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        
        ctx.setBlendMode(.destinationIn)
        ctx.draw(cgImage, in: imageRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
    
    func scaleAndRotateImage() -> UIImage {
        let maxResolution: CGFloat = 640
        
        let imgRef: CGImage = self.cgImage!
        
        let width: CGFloat = CGFloat(imgRef.width)
        let height: CGFloat = CGFloat(imgRef.height)
        
        var transform = CGAffineTransform.identity
        var bounds: CGRect = CGRect(x: 0, y: 0, width: width, height: height)
        
        if (width > maxResolution || height > maxResolution) {
            let ratio: CGFloat = width/height;
            if (ratio > 1) {
                bounds.size.width = maxResolution;
                bounds.size.height = CGFloat(roundf(Float(bounds.size.width / ratio)))
            }
            else {
                bounds.size.height = maxResolution;
                bounds.size.width = CGFloat(roundf(Float(bounds.size.height / ratio)))
            }
        }
        
        let scaleRatio: CGFloat = bounds.size.width / width;
        let imageSize: CGSize = CGSize(width: CGFloat(imgRef.width), height: CGFloat(imgRef.height))
        var boundHeight: CGFloat
        let orient: UIImage.Orientation = self.imageOrientation
        
        switch(orient) {
        case UIImage.Orientation.up: //EXIF = 1
            transform = CGAffineTransform.identity
            break
            
        case UIImage.Orientation.upMirrored: //EXIF = 2
            transform = CGAffineTransform(translationX: imageSize.width, y: 0.0)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
            break
            
        case UIImage.Orientation.down: //EXIF = 3
            transform = CGAffineTransform(translationX: imageSize.width, y: imageSize.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
            break
            
        case UIImage.Orientation.downMirrored: //EXIF = 4
            transform = CGAffineTransform(translationX: 0.0, y: imageSize.height);
            transform = transform.scaledBy(x: 1.0, y: -1.0);
            break;
            
        case UIImage.Orientation.leftMirrored: //EXIF = 5
            boundHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = boundHeight
            transform = CGAffineTransform(translationX: imageSize.height, y: imageSize.width)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
            transform = transform.rotated(by: 3.0 * CGFloat(Double.pi) / 2.0)
            break;
            
        case UIImage.Orientation.left: //EXIF = 6
            boundHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = boundHeight
            transform = CGAffineTransform(translationX: 0.0, y: imageSize.width)
            transform = transform.rotated(by: 3.0 * CGFloat(Double.pi) / 2.0)
            break;
            
        case UIImage.Orientation.rightMirrored: //EXIF = 7
            boundHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = boundHeight
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            transform = transform.rotated(by: CGFloat(Double.pi) / 2.0)
            break;
            
        case UIImage.Orientation.right: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width
            bounds.size.width = boundHeight
            transform = CGAffineTransform(translationX: imageSize.height, y: 0.0)
            transform = transform.rotated(by: CGFloat(Double.pi) / 2.0)
            break
        }
        
        UIGraphicsBeginImageContext(bounds.size);
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        if (orient == UIImage.Orientation.right || orient == UIImage.Orientation.left) {
            context.scaleBy(x: -scaleRatio, y: scaleRatio)
            context.translateBy(x: -height, y: 0)
        }
        else {
            context.scaleBy(x: scaleRatio, y: -scaleRatio)
            context.translateBy(x: 0, y: -height)
        }
        
        context.concatenate(transform);
        
        UIGraphicsGetCurrentContext()?.draw(imgRef, in: CGRect(x: 0, y: 0, width: width, height: height))
        let imageCopy: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return imageCopy
    }
    
    var isHightQuality: Bool {
        return (self.size.width < 480 || self.size.height < 480) ? false : true
    }
    
    func setOpacity(opacity: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        
        guard let cgImage = self.cgImage, let context = UIGraphicsGetCurrentContext() else {return self}
        
        let area = CGRect(origin: CGPoint.zero, size: self.size)
        
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -area.size.height)
        context.setBlendMode(CGBlendMode.multiply)
        context.setAlpha(opacity)
        context.draw(cgImage, in: area)
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {return self}
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

