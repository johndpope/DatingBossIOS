//
//  UserReportButton.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 18/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class UserReportButton: UIButton {
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            
            self.layer.borderColor = isSelected ? #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1) : #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
            self.layer.borderWidth = 1
        }
    }
    
    @available(*, deprecated)
    override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {}
    
    @available(*, deprecated)
    override func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {}
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        
        super.setTitleColor(#colorLiteral(red: 0.4156862745, green: 0.4117647059, blue: 0.4156862745, alpha: 1), for: .normal)
        super.setTitleColor(#colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), for: .selected)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
