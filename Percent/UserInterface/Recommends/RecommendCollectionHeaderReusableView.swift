//
//  RecommendCollectionHeaderReusableView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 23/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class RecommendCollectionHeaderReusableView: UICollectionReusableView {
    class var height: CGFloat {
        return 50  * QUtils.optimizeRatio()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "오늘의 추천"
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18 * QUtils.optimizeRatio(), weight: .bold)
        self.addSubview(label)
        
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
