//
//  UserProfileHeaderView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 23/12/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class UserProfileHeaderView: UIView {
    let imageView = UIImageView()
    
    private let labelName = UILabel()
    private let labelAge = UILabel()
    private let labelRegion = UILabel()
    private let labelJobTitle = UILabel()
    
//    let buttonFavourite = UIButton(type: .custom)
    let buttonLike = UIButton(type: .custom)
    let buttonEdit = UIButton(type: .custom)
    
    let data: UserData
    
    var showProfile: Bool = true
    
    var constraintValue: CGFloat = 0 {
        didSet {
            constraintLeft.constant = 56 * QUtils.optimizeRatio() * constraintValue
            constraintRight.constant = -56 * QUtils.optimizeRatio() * constraintValue
            
            self.layoutIfNeeded()
        }
    }
    
    private var constraintLeft: NSLayoutConstraint!
    private var constraintRight: NSLayoutConstraint!
    
    init(frame: CGRect = CGRect.zero, data uData: UserData) {
        data = uData
        super.init(frame: frame)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20 * QUtils.optimizeRatio()
        self.addSubview(imageView)
        
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        constraintLeft = imageView.trailingAnchor.constraint(equalTo: self.leadingAnchor)
        constraintLeft.isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageView.layer.cornerRadius * 2).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageView.layer.cornerRadius * 2).isActive = true
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.text = data.nickname
        labelName.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelName.font = UIFont.systemFont(ofSize: 18 * QUtils.optimizeRatio(), weight: .heavy)
        self.addSubview(labelName)
        
        labelName.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -4 * QUtils.optimizeRatio()).isActive = true
        labelName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        
        labelAge.translatesAutoresizingMaskIntoConstraints = false
        labelAge.text =  "\(data.age)세"
        labelAge.textColor = #colorLiteral(red: 0.4156862745, green: 0.4117647059, blue: 0.4156862745, alpha: 1)
        labelAge.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)
        self.addSubview(labelAge)
        
        labelAge.bottomAnchor.constraint(equalTo: labelName.bottomAnchor).isActive = true
        labelAge.leadingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        
        labelRegion.translatesAutoresizingMaskIntoConstraints = false
        labelRegion.text = data.area
        labelRegion.textColor = #colorLiteral(red: 0.4156862745, green: 0.4117647059, blue: 0.4156862745, alpha: 1)
        labelRegion.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)
        self.addSubview(labelRegion)
        
        labelRegion.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        labelRegion.leadingAnchor.constraint(equalTo: labelName.leadingAnchor).isActive = true
        
        var seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        self.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: labelRegion.topAnchor, constant: 2 * QUtils.optimizeRatio()).isActive = true
        seperator.bottomAnchor.constraint(equalTo: labelRegion.bottomAnchor, constant: -2 * QUtils.optimizeRatio()).isActive = true
        seperator.leadingAnchor.constraint(equalTo: labelRegion.trailingAnchor, constant: 7 * QUtils.optimizeRatio()).isActive = true
        seperator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        labelJobTitle.translatesAutoresizingMaskIntoConstraints = false
        labelJobTitle.text = data.job
        labelJobTitle.textColor = #colorLiteral(red: 0.4156862745, green: 0.4117647059, blue: 0.4156862745, alpha: 1)
        labelJobTitle.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)
        self.addSubview(labelJobTitle)
        
        labelJobTitle.topAnchor.constraint(equalTo: labelRegion.topAnchor).isActive = true
        labelJobTitle.leadingAnchor.constraint(equalTo: seperator.trailingAnchor, constant: 7 * QUtils.optimizeRatio()).isActive = true
        
        if data.mem_idx == MyData.shared.mem_idx {
            buttonEdit.translatesAutoresizingMaskIntoConstraints = false
            buttonEdit.setImage(UIImage(named: "img_profile_edit_nor"), for: .normal)
            buttonEdit.setImage(UIImage(named: "img_profile_edit_high"), for: .highlighted)
            self.addSubview(buttonEdit)
            
            buttonEdit.widthAnchor.constraint(equalToConstant: 40 * QUtils.optimizeRatio()).isActive = true
            buttonEdit.heightAnchor.constraint(equalToConstant: 40 * QUtils.optimizeRatio()).isActive = true
            buttonEdit.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            constraintRight = buttonEdit.leadingAnchor.constraint(equalTo: self.trailingAnchor)
            constraintRight.isActive = true
        } else {
            buttonLike.translatesAutoresizingMaskIntoConstraints = false
            buttonLike.setImage(UIImage(named: "img_heart")?.recolour(with: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)).resize(maxWidth: 32 * QUtils.optimizeRatio()), for: .normal)
            self.addSubview(buttonLike)
            
            buttonLike.widthAnchor.constraint(equalToConstant: 40 * QUtils.optimizeRatio()).isActive = true
            buttonLike.heightAnchor.constraint(equalToConstant: 40 * QUtils.optimizeRatio()).isActive = true
            buttonLike.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            constraintRight = buttonLike.leadingAnchor.constraint(equalTo: self.trailingAnchor)
            constraintRight.isActive = true
        }
        
//        buttonFavourite.translatesAutoresizingMaskIntoConstraints = false
//        buttonFavourite.setImage(UIImage(named: "img_star")?.recolour(with: #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)).resize(maxWidth: 24 * QUtils.optimizeRatio()), for: .normal)
//        buttonFavourite.setImage(UIImage(named: "img_star")?.recolour(with: #colorLiteral(red: 0.9978266358, green: 0.768635273, blue: 0.2078177631, alpha: 1)).resize(maxWidth: 24 * QUtils.optimizeRatio()), for: .selected)
//        self.addSubview(buttonFavourite)
//
//        buttonFavourite.widthAnchor.constraint(equalToConstant: 40 * QUtils.optimizeRatio()).isActive = true
//        buttonFavourite.heightAnchor.constraint(equalToConstant: 40 * QUtils.optimizeRatio()).isActive = true
//        buttonFavourite.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        buttonFavourite.trailingAnchor.constraint(equalTo: buttonLike.leadingAnchor).isActive = true
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.addSubview(seperator)
        
        seperator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        constraintValue = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
