//
//  SettingsTableViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 24/11/2018.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    class var height: CGFloat {
        return 56 * QUtils.optimizeRatio()
    }
    
    private let imageViewIcon = UIImageView()
    private let labelTitle = UILabel()
    
    var indexPath: IndexPath?
    
    var data: SettingsData? {
        didSet {
            imageViewIcon.image = data?.imageName != nil ? UIImage(named: data!.imageName!) : nil
            labelTitle.text = data?.setup_name
            
            self.layoutIfNeeded()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        imageViewIcon.translatesAutoresizingMaskIntoConstraints = false
        imageViewIcon.contentMode = .scaleAspectFit
        self.contentView.addSubview(imageViewIcon)
        
        imageViewIcon.widthAnchor.constraint(equalToConstant: 32 * QUtils.optimizeRatio()).isActive = true
        imageViewIcon.heightAnchor.constraint(equalToConstant: 32 * QUtils.optimizeRatio()).isActive = true
        imageViewIcon.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 29 * QUtils.optimizeRatio()).isActive = true
        imageViewIcon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelTitle.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .regular)
        self.contentView.addSubview(labelTitle)
        
        labelTitle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: imageViewIcon.trailingAnchor, constant: 28 * QUtils.optimizeRatio()).isActive = true
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.contentView.addSubview(seperator)
        
        seperator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

class SettingsTableViewSwitchCell: SettingsTableViewCell {
    let switchView = PSwitchView()
    let button = UIButton(type: .custom)
    
    override var data: SettingsData? {
        didSet {
            super.data = data
            
            switchView.set(on: data?.value ?? false, animated: false)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        switchView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(switchView)
        
        switchView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        switchView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        switchView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        switchView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(button)
        
        button.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: switchView.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: switchView.widthAnchor, constant: 20 * QUtils.optimizeRatio()).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
