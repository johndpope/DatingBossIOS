//
//  BarIndicatorView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 16/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class BarIndicatorView: UIView {
    private let backgroundView = UIView()
    private let indicatorView = UIView()
    
    private let constraintWidth: NSLayoutConstraint
    
    var value: CGFloat = 0 {
        didSet {
            constraintWidth.constant = self.frame.size.width * value
            self.layoutIfNeeded()
        }
    }
    
    init(frame: CGRect = CGRect.zero, backgroundColour: UIColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 0.2), indicatorColour: UIColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)) {
        constraintWidth = indicatorView.widthAnchor.constraint(equalToConstant: 0)
        constraintWidth.isActive = true
        
        super.init(frame: frame)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.clipsToBounds = true
        backgroundView.backgroundColor = backgroundColour
        self.addSubview(backgroundView)
        
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.clipsToBounds = true
        indicatorView.backgroundColor = indicatorColour
        self.addSubview(indicatorView)
        
        indicatorView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundView.layer.cornerRadius = self.frame.size.height / 2
        indicatorView.layer.cornerRadius = self.frame.size.height / 2
    }
}
