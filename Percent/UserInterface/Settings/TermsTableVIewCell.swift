//
//  TermsTableViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 21/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class TermsTableViewCell: UITableViewCell {
    class var heightCollapsed: CGFloat {
        return 56 * QUtils.optimizeRatio()
    }
    
    internal let labelTitle = UILabel()
    
    var data: TermsData! {
        didSet {
            labelTitle.text = data.terms_title
            
            self.layoutIfNeeded()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(headerView)
        
        headerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: BoardTableViewCell.heightCollapsed).isActive = true
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textColor = #colorLiteral(red: 0.2039215686, green: 0.2039215686, blue: 0.2039215686, alpha: 1)
        labelTitle.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)
        headerView.addSubview(labelTitle)
        
        labelTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        labelTitle.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.contentView.addSubview(seperator)
        
        seperator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
