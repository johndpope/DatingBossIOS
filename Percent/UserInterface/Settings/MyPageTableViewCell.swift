//
//  MyPageTableViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 02/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class MyPageTableViewCell: UITableViewCell {
    class var height: CGFloat {
        return 56 * QUtils.optimizeRatio()
    }
    
    private let imageViewIcon = UIImageView()
    private let labelTitle = UILabel()
    
    var data: MyPageData? {
        didSet {
            imageViewIcon.image = data?.type != nil ? UIImage(named: data!.type.rawValue) : nil
            labelTitle.text = data?.title
            
            self.layoutIfNeeded()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.accessoryType = .disclosureIndicator
        
        imageViewIcon.translatesAutoresizingMaskIntoConstraints = false
        imageViewIcon.contentMode = .scaleAspectFit
        self.contentView.addSubview(imageViewIcon)
        
        imageViewIcon.widthAnchor.constraint(equalToConstant: 32 * QUtils.optimizeRatio()).isActive = true
        imageViewIcon.heightAnchor.constraint(equalToConstant: 32 * QUtils.optimizeRatio()).isActive = true
        imageViewIcon.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        imageViewIcon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelTitle.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .regular)
        self.contentView.addSubview(labelTitle)
        
        labelTitle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: imageViewIcon.trailingAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.contentView.addSubview(seperator)
        
        seperator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
