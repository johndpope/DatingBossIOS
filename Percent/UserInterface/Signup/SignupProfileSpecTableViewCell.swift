//
//  SignupProfileSpecTableViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 12/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class SignupProfileSpecTableViewCell: UITableViewCell {
    class var height: CGFloat { return 46 * QUtils.optimizeRatio() }
    
    let labelTitle = UILabel()
    private let imageViewChecked = UIImageView()
    
    var isSelectedCell: Bool = false {
        didSet {
            labelTitle.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: isSelectedCell ? .bold : .regular)
            imageViewChecked.isHidden = !isSelectedCell
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelTitle.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .regular)
        self.contentView.addSubview(labelTitle)
        
        labelTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        labelTitle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        imageViewChecked.translatesAutoresizingMaskIntoConstraints = false
        imageViewChecked.image = UIImage(named: "img_profile_dialog_check")
        self.contentView.addSubview(imageViewChecked)
        
        imageViewChecked.widthAnchor.constraint(equalToConstant: 24 * QUtils.optimizeRatio()).isActive = true
        imageViewChecked.heightAnchor.constraint(equalToConstant: 24 * QUtils.optimizeRatio()).isActive = true
        imageViewChecked.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        imageViewChecked.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
