//
//  UserProfileSectionHeaderCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 19/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class UserProfileSectionHeaderCell: UITableViewCell {
    class var height: CGFloat {
        return 46 * QUtils.optimizeRatio()
    }
    
    let labelTitle = UILabel()
    let buttonExpander = UIButton(type: .custom)
    
    var showExpander = false {
        didSet {
            self.contentView.viewWithTag(1001)?.isHidden = !showExpander
            self.buttonExpander.isHidden = !showExpander
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        self.contentView.addSubview(containerView)
        
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: UserProfileSectionHeaderCell.height).isActive = true
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelTitle.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        containerView.addSubview(labelTitle)
        
        labelTitle.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        
        let seperator = UIView()
        seperator.tag = 1001
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        containerView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        seperator.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let image = UIImage(named: "img_profile_expand_bg")!
        
        buttonExpander.translatesAutoresizingMaskIntoConstraints = false
        buttonExpander.setBackgroundImage(image, for: .normal)
        buttonExpander.setImage(UIImage(named: "img_profile_expand")?.recolour(with: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)).resize(maxWidth: 24), for: .normal)
        buttonExpander.setImage(UIImage(named: "img_profile_collapsed")?.recolour(with: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)).resize(maxWidth: 24), for: .selected)
        containerView.addSubview(buttonExpander)
        
        buttonExpander.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        buttonExpander.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        buttonExpander.widthAnchor.constraint(equalToConstant: image.size.width).isActive = true
        buttonExpander.heightAnchor.constraint(equalToConstant: image.size.height).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
