//
//  SignupSelectTagCollectionViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 14/12/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class SignupSelectTagCollectionViewCell: UICollectionViewCell {
    private let labelTag = UILabel()
    
    var data: TagData? {
        didSet {
            labelTag.text = data?.code_name
        }
    }
    
    var isSelectedTag: Bool = false {
        didSet {
            labelTag.layer.borderColor = isSelectedTag ? #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1) : #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
            labelTag.textColor = isSelectedTag ? #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1) : #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        labelTag.translatesAutoresizingMaskIntoConstraints = false
        labelTag.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        labelTag.textAlignment = .center
        labelTag.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)
        labelTag.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        labelTag.layer.borderWidth = 1
        labelTag.clipsToBounds = true
        self.addSubview(labelTag)
        
        labelTag.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        labelTag.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        labelTag.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        labelTag.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
