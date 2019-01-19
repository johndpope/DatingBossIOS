//
//  RecommendsCollectionViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 24/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

import PINRemoteImage

class RecommendsCollectionViewCell: UICollectionViewCell {
    class var sectionInset: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16 * QUtils.optimizeRatio(), bottom: 0, right: 16 * QUtils.optimizeRatio())
    }
    
    class var minimumInteritemSpacing: CGFloat {
        return 20 * QUtils.optimizeRatio()
    }
    
    class var itemSize: CGSize {
        get {
            var size = CGSize.zero
            size.width = ((UIScreen.main.bounds.size.width - RecommendsCollectionViewCell.sectionInset.left - RecommendsCollectionViewCell.sectionInset.right - RecommendsCollectionViewCell.minimumInteritemSpacing) / 2).rounded(.down)
            size.height = size.width + 56 * QUtils.optimizeRatio()
            return size
        }
    }
    
    private let imageView = UIImageView()
    private let borderView = CircleIndicatorView(backgroundColour: .clear, indicatorColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), lineWidth: 2)
    
    private let labelName = UILabel()
    private let labelPercent = UILabel()
    
    private let labelRegion = UILabel()
    private let labelAge = UILabel()
    
    private var percent = 0
    
    private var timer: Timer?
    
    var data: RecommendData? {
        didSet {
            if let memberIndex = data?.mem_idx, let imageName = data?.picture_name  {
                imageView.pin_setImage(from: URL(string: RequestUrl.Image.File + "\(memberIndex)/\(imageName)"))
            } else {
                imageView.image = nil
            }
            
            labelName.text = data?.nickname
            borderView.value = 0
            percent = 0
            labelPercent.text = "0%"
            
            labelRegion.text = data?.area
            labelAge.text = data?.age != nil ? "\(data!.age)세" : nil
            
            timer?.invalidate()
            timer = nil
            
            guard let target = data?.sim_sum else { return }
            timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true, block: { (aTimer) in
                self.percent += 1
                guard self.percent <= target else {
                    self.timer?.invalidate()
                    self.timer = nil
                    return
                }
                
                self.labelPercent.text = "\(self.percent)%"
                
                self.layoutIfNeeded()
                
                self.borderView.value = CGFloat(self.percent) / 100
            })
            
            self.layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = RecommendsCollectionViewCell.itemSize.width / 2
        self.contentView.addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageView.layer.cornerRadius * 2).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        
//        let borderView = CircleIndicatorView()
//        borderView.translatesAutoresizingMaskIntoConstraints = false
//        borderView.colour = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 0.2)
//        borderView.value = 1.0
//        self.contentView.addSubview(borderView)
//        
//        borderView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
//        borderView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
//        borderView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
//        borderView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        
        borderView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(borderView)
        
        borderView.widthAnchor.constraint(equalTo: imageView.widthAnchor, constant: 2).isActive = true
        borderView.heightAnchor.constraint(equalTo: imageView.heightAnchor, constant: 2).isActive = true
        borderView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        borderView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        var containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        self.contentView.addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 17 * QUtils.optimizeRatio()).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 20 * QUtils.optimizeRatio()).isActive = true
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelName.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)
        containerView.addSubview(labelName)
        
        labelName.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        labelName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        
        labelPercent.translatesAutoresizingMaskIntoConstraints = false
        labelPercent.textColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        labelPercent.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)
        containerView.addSubview(labelPercent)
        
        labelPercent.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        labelPercent.leadingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: 6 * QUtils.optimizeRatio()).isActive = true
        labelPercent.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        let bottomAnchor = containerView.bottomAnchor
        
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        self.contentView.addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 20 * QUtils.optimizeRatio()).isActive = true
        
        labelRegion.translatesAutoresizingMaskIntoConstraints = false
        labelRegion.textColor = #colorLiteral(red: 0.4156862745, green: 0.4117647059, blue: 0.4156862745, alpha: 1)
        labelRegion.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        containerView.addSubview(labelRegion)
        
        labelRegion.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        labelRegion.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.8745098039, blue: 0.8666666667, alpha: 1)
        contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: labelRegion.topAnchor, constant: 2).isActive = true
        seperator.bottomAnchor.constraint(equalTo: labelRegion.bottomAnchor, constant: -2).isActive = true
        seperator.leadingAnchor.constraint(equalTo: labelRegion.trailingAnchor, constant: 4 * QUtils.optimizeRatio()).isActive = true
        seperator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        labelAge.translatesAutoresizingMaskIntoConstraints = false
        labelAge.textColor = #colorLiteral(red: 0.4156862745, green: 0.4117647059, blue: 0.4156862745, alpha: 1)
        labelAge.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        containerView.addSubview(labelAge)
        
        labelAge.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        labelAge.leadingAnchor.constraint(equalTo: seperator.trailingAnchor, constant: 4 * QUtils.optimizeRatio()).isActive = true
        labelAge.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
