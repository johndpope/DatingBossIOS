//
//  UserProfileHeaderView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 23/12/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class UserProfileHeaderView: UIView {
    private let imageView = UIImageView()
    
    private let labelName = UILabel()
    private let labelAge = UILabel()
    private let labelRegion = UILabel()
    private let labelJobTitle = UILabel()
    
    let buttonFavourite = UIButton(type: .custom)
    let buttonLike = UIButton(type: .custom)
    
    let data: UserData
    
    var showProfile: Bool = true
    
    private var constraintShowImage = [NSLayoutConstraint]()
    private var constraintHideImage = [NSLayoutConstraint]()
    
    init(frame: CGRect = CGRect.zero, data uData: UserData) {
        data = uData
        super.init(frame: frame)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20 * QUtils.optimizeRatio()
        self.addSubview(imageView)
        
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        var constraint = imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16 * QUtils.optimizeRatio())
        constraintShowImage.append(constraint)
        constraint = imageView.trailingAnchor.constraint(equalTo: self.leadingAnchor)
        constraintHideImage.append(constraint)
        imageView.widthAnchor.constraint(equalToConstant: imageView.layer.cornerRadius * 2).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageView.layer.cornerRadius * 2).isActive = true
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.text = data.nickname
        labelName.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelName.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
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
        
        buttonLike.translatesAutoresizingMaskIntoConstraints = false
        buttonLike.setImage(UIImage(named: "img_heart")?.recolour(with: #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)).resize(maxWidth: 24 * QUtils.optimizeRatio()), for: .normal)
        buttonLike.setImage(UIImage(named: "img_heart")?.recolour(with: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)).resize(maxWidth: 24 * QUtils.optimizeRatio()), for: .selected)
        self.addSubview(buttonLike)
        
        buttonLike.widthAnchor.constraint(equalToConstant: 40 * QUtils.optimizeRatio()).isActive = true
        buttonLike.heightAnchor.constraint(equalToConstant: 40 * QUtils.optimizeRatio()).isActive = true
        buttonLike.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        constraint = buttonLike.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8 * QUtils.optimizeRatio())
        constraintShowImage.append(constraint)
        constraint = buttonLike.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8 * QUtils.optimizeRatio())
        constraintHideImage.append(constraint)
        
        buttonFavourite.translatesAutoresizingMaskIntoConstraints = false
        buttonFavourite.setImage(UIImage(named: "img_star")?.recolour(with: #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)).resize(maxWidth: 24 * QUtils.optimizeRatio()), for: .normal)
        buttonFavourite.setImage(UIImage(named: "img_star")?.recolour(with: #colorLiteral(red: 0.9978266358, green: 0.768635273, blue: 0.2078177631, alpha: 1)).resize(maxWidth: 24 * QUtils.optimizeRatio()), for: .selected)
        self.addSubview(buttonFavourite)
        
        buttonFavourite.widthAnchor.constraint(equalToConstant: 40 * QUtils.optimizeRatio()).isActive = true
        buttonFavourite.heightAnchor.constraint(equalToConstant: 40 * QUtils.optimizeRatio()).isActive = true
        buttonFavourite.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        buttonFavourite.trailingAnchor.constraint(equalTo: buttonLike.leadingAnchor).isActive = true
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.addSubview(seperator)
        
        seperator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        showProfile(true, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func showProfile(_ show: Bool, animated: Bool) {
        guard showProfile != show else { return }
        
        showProfile = show
        
        self.layer.removeAllAnimations()
        
        self.imageView.isHidden = false
        self.buttonLike.isHidden = false
        
        let animations = {() -> Void in
            for constraint in self.constraintShowImage {
                constraint.isActive = show
            }
            
            for constraint in self.constraintHideImage {
                constraint.isActive = !show
            }
            
            self.imageView.alpha = show ? 1 : 0
            self.buttonLike.alpha = show ? 1 : 0
            
            self.layoutIfNeeded()
        }
        
        let completion = {(complete: Bool) -> Void in
            self.imageView.isHidden = !show
            self.buttonLike.isHidden = !show
        }
        
        guard animated else {
            animations()
            completion(true)
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: animations, completion: completion)
    }
}
