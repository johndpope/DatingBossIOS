//
//  CategoryTableViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 31/12/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    class var height: CGFloat {
        return 56 * QUtils.optimizeRatio()
    }
    
    private let labelContent = UILabel()
    
    var data: CategoryData? {
        didSet {
            labelContent.text = data?.text
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        
        self.selectionStyle = .none
        
        labelContent.translatesAutoresizingMaskIntoConstraints = false
        labelContent.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelContent.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        self.contentView.addSubview(labelContent)
        
        labelContent.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        labelContent.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.contentView.addSubview(seperator)
        
        seperator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: labelContent.leadingAnchor).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
