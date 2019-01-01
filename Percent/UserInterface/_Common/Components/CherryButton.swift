//
//  CherryButton.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 14/11/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class CherryButton: UIButton {
    var amount: Int = 0 {
        didSet {
            super.setTitle("  \(amount)", for: .normal)
        }
    }
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        let image = UIImage(named: "img_cherry")?.resize(maxWidth: 18)
        super.setImage(image, for: .normal)
        super.setImage(image, for: .highlighted)
        super.setTitleColor(#colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), for: .normal)
        super.setTitleColor(#colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), for: .highlighted)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @available(*, unavailable, message: "Cannot set an image for a Cherry button")
    override func setImage(_ image: UIImage?, for state: UIControl.State) {}
    
    @available(*, unavailable, message: "Cannot set a title for a Cherry button")
    override func setTitle(_ title: String?, for state: UIControl.State) {}
    
    @available(*, unavailable, message: "Cannot set a title color for a Cherry button")
    override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {}
}
