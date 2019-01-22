//
//  BoardTableViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 29/11/2018.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class BoardTableViewCell: UITableViewCell {
    class var heightCollapsed: CGFloat {
        return 56 * QUtils.optimizeRatio()
    }
    
    internal let labelTitle = UILabel()
    
    internal let imageViewIndicator = UIImageView()
    
    var data: BoardData! {
        didSet {
            labelTitle.text = data.title
            
            self.layoutIfNeeded()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: BoardTableViewCell.heightCollapsed))
//        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(headerView)
        
//        headerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
//        headerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
//        headerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
//        headerView.heightAnchor.constraint(equalToConstant: BoardTableViewCell.heightCollapsed).isActive = true
        
        imageViewIndicator.translatesAutoresizingMaskIntoConstraints = false
        imageViewIndicator.image = UIImage(named: "img_board_collapsed")
        imageViewIndicator.contentMode = .scaleAspectFit
        headerView.addSubview(imageViewIndicator)
        
        imageViewIndicator.widthAnchor.constraint(equalToConstant: 16).isActive = true
        imageViewIndicator.heightAnchor.constraint(equalToConstant: 16).isActive = true
        imageViewIndicator.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        imageViewIndicator.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textColor = #colorLiteral(red: 0.2039215686, green: 0.2039215686, blue: 0.2039215686, alpha: 1)
        labelTitle.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)
        headerView.addSubview(labelTitle)
        
        labelTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        labelTitle.trailingAnchor.constraint(lessThanOrEqualTo: imageViewIndicator.leadingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        
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

class BoardExpandedTableViewCell: BoardTableViewCell {
    let labelContent = UILabel()
    
    private var constraintContentHeight: NSLayoutConstraint!
    
    override var data: BoardData! {
        didSet {
            labelTitle.text = data.title
            
            let content = data.text?.replacingOccurrences(of: "<br>", with: "\n").replacingOccurrences(of: "<BR>", with: "\n").replacingOccurrences(of: "&nbsp;", with: "\t")
            labelContent.text = content
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 64 * QUtils.optimizeRatio(), height: 0))
            label.text = content
            label.font = labelContent.font
            label.numberOfLines = 0
            label.sizeToFit()
            constraintContentHeight.constant = label.frame.size.height
            
            self.layoutIfNeeded()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        labelTitle.superview?.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        
        imageViewIndicator.image = UIImage(named: "img_board_expanded")
        
        labelContent.translatesAutoresizingMaskIntoConstraints = false
        labelContent.textColor = #colorLiteral(red: 0.3529411765, green: 0.3725490196, blue: 0.3843137255, alpha: 1)
        labelContent.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        labelContent.numberOfLines = 0
        labelContent.lineBreakMode = .byWordWrapping
        self.contentView.addSubview(labelContent)
        
        labelContent.topAnchor.constraint(equalTo: labelTitle.superview!.bottomAnchor, constant: 12 * QUtils.optimizeRatio()).isActive = true
        labelContent.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 32 * QUtils.optimizeRatio()).isActive = true
        labelContent.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -32 * QUtils.optimizeRatio()).isActive = true
        constraintContentHeight = labelContent.heightAnchor.constraint(equalToConstant: 0)
        constraintContentHeight.isActive = true
        labelContent.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -24 * QUtils.optimizeRatio()).isActive = true
        
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
