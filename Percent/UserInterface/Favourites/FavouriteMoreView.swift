//
//  FavouriteMoreView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class FavouriteMoreView: UICollectionReusableView {
    let button = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(#colorLiteral(red: 0.4156862745, green: 0.4117647059, blue: 0.4156862745, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12 * QUtils.optimizeRatio(), weight: .regular)
        self.addSubview(button)
        
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
