//
//  UserProfileTableViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 31/12/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {
    private let imageViewIcon = UIImageView()
    private let labelContent = UILabel()
    private let labelApproved = UILabel()
    
    var data: UserProfileTableData! {
        didSet {
            imageViewIcon.image = UIImage(named: data.iconName)
            labelContent.attributedText = data.content
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        imageViewIcon.translatesAutoresizingMaskIntoConstraints = false
        imageViewIcon.contentMode = .scaleAspectFit
        self.addSubview(imageViewIcon)
        
        imageViewIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageViewIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        imageViewIcon.widthAnchor.constraint(equalToConstant: 24 * QUtils.optimizeRatio()).isActive = true
        imageViewIcon.heightAnchor.constraint(equalToConstant: 24 * QUtils.optimizeRatio()).isActive = true
        
        labelContent.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelContent)
        
        labelContent.leadingAnchor.constraint(equalTo: imageViewIcon.trailingAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        labelContent.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.addSubview(seperator)
        
        seperator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: labelContent.leadingAnchor).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
