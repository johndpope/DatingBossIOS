//
//  CircleIndicatorView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 16/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class CircleIndicatorView: UIView {
    class CircleView: UIView {
        var value: CGFloat = 0 {
            didSet {
                self.setNeedsDisplay()
            }
        }
        var colour: UIColor = .black
        var lineWidth: CGFloat = 4.0
        
        override init(frame: CGRect = CGRect.zero) {
            super.init(frame: frame)
            
            self.isOpaque = false
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError()
        }
        
        override func draw(_ rect: CGRect) {
            super.draw(rect)
            
            if let context = UIGraphicsGetCurrentContext() {
                context.setLineWidth(self.lineWidth)
                context.setStrokeColor(self.colour.cgColor)
                context.setLineJoin(.round)
                context.setLineCap(.round)
                
                let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
                let radius = (frame.size.width - lineWidth) / 2
                context.addArc(center: center, radius: radius, startAngle: .pi * -0.5, endAngle: .pi * (2.0 * value - 0.5), clockwise: false)
                context.strokePath()
            }
        }
    }
    
    private let backgroundView = CircleView()
    private let foregroundView = CircleView()
    
    var value: CGFloat {
        get {
            return foregroundView.value
        }
        set {
            var target = newValue
            if target > 1 {
                target = 1
            } else if target < 0 {
                target = 0
            }
            
            foregroundView.value = target
            
            foregroundView.setNeedsDisplay()
        }
    }
    
    init(frame: CGRect = CGRect.zero, backgroundColour: UIColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 0.2), indicatorColour: UIColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), lineWidth: CGFloat = 4.0) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.lineWidth = lineWidth
        backgroundView.colour = backgroundColour
        backgroundView.value = 1.0
        self.addSubview(backgroundView)
        
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        foregroundView.translatesAutoresizingMaskIntoConstraints = false
        foregroundView.lineWidth = lineWidth
        foregroundView.colour = indicatorColour
        foregroundView.value = 0.0
        self.addSubview(foregroundView)
        
        foregroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        foregroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        foregroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        foregroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
