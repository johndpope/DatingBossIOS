//
//  SignupTermsTableViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 12/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class SignupTermsTableViewCell: UITableViewCell {
    let labelTitle = UILabel()
    let buttonConfirm = UIButton(type: .custom)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelTitle.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        self.contentView.addSubview(labelTitle)
        
        labelTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        labelTitle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        buttonConfirm.translatesAutoresizingMaskIntoConstraints = false
        buttonConfirm.setImage(UIImage(named: "img_check_nor"), for: .normal)
        buttonConfirm.setImage(UIImage(named: "img_check_sel"), for: .selected)
        self.contentView.addSubview(buttonConfirm)
        
        buttonConfirm.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        buttonConfirm.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        buttonConfirm.widthAnchor.constraint(equalToConstant: 64 * QUtils.optimizeRatio()).isActive = true
        buttonConfirm.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.contentView.addSubview(seperator)
        
        seperator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor).isActive = true
        seperator.trailingAnchor.constraint(equalTo: buttonConfirm.leadingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
