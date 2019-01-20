//
//  FavouriteHeaderView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class FavouriteHeaderView: UICollectionReusableView {
    let labelTitle = UILabel()
    let buttonDelete = UIButton(type: .custom)
    let buttonCancel = UIButton(type: .custom)
    let buttonConfirm = UIButton(type: .custom)
    
    var isEditMode: Bool? {
        didSet {
            buttonDelete.isHidden = isEditMode ?? true
            buttonCancel.isHidden = !(isEditMode ?? false)
            buttonConfirm.isHidden = !(isEditMode ?? false)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelTitle.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.addSubview(labelTitle)
        
        labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        labelTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        buttonDelete.translatesAutoresizingMaskIntoConstraints = false
        buttonDelete.setTitle("삭제하기", for: .normal)
        buttonDelete.setTitleColor(#colorLiteral(red: 0.7018831372, green: 0.7020055652, blue: 0.7018753886, alpha: 1), for: .normal)
        buttonDelete.titleLabel?.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        buttonDelete.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16 * QUtils.optimizeRatio(), bottom: 0, right: 16 * QUtils.optimizeRatio())
        self.addSubview(buttonDelete)
        
        buttonDelete.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonDelete.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        buttonDelete.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        buttonConfirm.translatesAutoresizingMaskIntoConstraints = false
        buttonConfirm.setTitle("삭제", for: .normal)
        buttonConfirm.setTitleColor(#colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), for: .normal)
        buttonConfirm.titleLabel?.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        buttonConfirm.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8 * QUtils.optimizeRatio(), bottom: 0, right: 16 * QUtils.optimizeRatio())
        self.addSubview(buttonConfirm)
        
        buttonConfirm.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonConfirm.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        buttonConfirm.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitle("취소", for: .normal)
        buttonCancel.setTitleColor(#colorLiteral(red: 0.7018831372, green: 0.7020055652, blue: 0.7018753886, alpha: 1), for: .normal)
        buttonCancel.titleLabel?.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        buttonCancel.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16 * QUtils.optimizeRatio(), bottom: 0, right: 8 * QUtils.optimizeRatio())
        self.addSubview(buttonCancel)
        
        buttonCancel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonCancel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        buttonCancel.trailingAnchor.constraint(equalTo: buttonConfirm.leadingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
