//
//  AvoidKnownsContactsTableViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 23/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

import JSPhoneFormat

class AvoidKnownsContactsTableViewCell: UITableViewCell {
    class var height: CGFloat {
        return 48 * QUtils.optimizeRatio()
    }
    
    private let labelName = UILabel()
    private let labelPhone = UILabel()
    
    private let imageViewSelection = UIImageView()
    
    var data: LocalContact? {
        didSet {
            labelName.text = data?.name
            
            if let phone = data?.phone {
                let phoneFormat = JSPhoneFormat(appenCharacter: "-")
                labelPhone.text = phoneFormat.addCharacter(at: phone)
            } else {
                labelPhone.text = nil
            }
            
            self.layoutIfNeeded()
        }
    }
    
    var isSelectedCell = false {
        didSet {
            imageViewSelection.isHighlighted = isSelectedCell
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        imageViewSelection.translatesAutoresizingMaskIntoConstraints = false
        imageViewSelection.image = UIImage(named: "img_validation_unchecked")
        imageViewSelection.highlightedImage = UIImage(named: "img_validation_checked")
        self.contentView.addSubview(imageViewSelection)

        imageViewSelection.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        imageViewSelection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        imageViewSelection.widthAnchor.constraint(equalToConstant: 20 * QUtils.optimizeRatio()).isActive = true
        imageViewSelection.heightAnchor.constraint(equalToConstant: 20 * QUtils.optimizeRatio()).isActive = true
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelName.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .regular)
        self.contentView.addSubview(labelName)
        
        labelName.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        labelName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        
        labelPhone.translatesAutoresizingMaskIntoConstraints = false
        labelPhone.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelPhone.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .regular)
        self.contentView.addSubview(labelPhone)
        
        labelPhone.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        labelPhone.leadingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.contentView.addSubview(seperator)
        
        seperator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
