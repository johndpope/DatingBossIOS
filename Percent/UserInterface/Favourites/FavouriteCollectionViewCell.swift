//
//  FavouriteCollectionViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 31/12/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class FavouriteCollectionViewCell: UICollectionViewCell {
    class var minimumLineSpacing: CGFloat {
        return 0
    }
    
    class var minimumInteritemSpacing: CGFloat {
        return 0
    }
    
    class var sectionInset: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12 * QUtils.optimizeRatio(), bottom: 0, right: 12 * QUtils.optimizeRatio())
    }
    
    class var itemSize: CGSize {
        get {
            var size = CGSize.zero
            size.width = ((UIScreen.main.bounds.size.width - FavouriteCollectionViewCell.sectionInset.left - FavouriteCollectionViewCell.sectionInset.right) / 3).rounded(.down)
            size.height = 156 * QUtils.optimizeRatio()
            return size
        }
    }
    
    private let imageViewProfile = UIImageView()
    private let borderView = CircleIndicatorView(backgroundColour: .clear, indicatorColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), lineWidth: 2)
    
    private let labelName = UILabel()
    private let labelAge = UILabel()
    private let labelRegion = UILabel()
    
    private let imageViewSelection = UIImageView()
    let buttonSelection = UIButton(type: .custom)
    
    var indexPath: IndexPath?
    
    var isEditMode = false {
        didSet {
            imageViewSelection.isHidden = !isEditMode
        }
    }
    
    private var selectedCell: Bool = false
    
    var data: GatherData? {
        didSet {
            imageViewProfile.image = nil
            
            if let memberIndex = data?.mem_idx, let imageName = data?.picture_name  {
                imageViewProfile.pin_setImage(from: URL(string: RequestUrl.Image.File + "\(memberIndex)/\(imageName)"))
            } else {
                imageViewProfile.image = nil
            }
            
            borderView.value = CGFloat(data?.sim_sum ?? 0) /  100
            
            labelName.text = data?.nickname
            labelRegion.text = data?.area
            labelAge.text = data?.age != nil ? "\(data!.age)세" : nil
            
            self.layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageViewProfile.translatesAutoresizingMaskIntoConstraints = false
        imageViewProfile.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        imageViewProfile.clipsToBounds = true
        imageViewProfile.layer.cornerRadius = 44 * QUtils.optimizeRatio()
        self.contentView.addSubview(imageViewProfile)
        
        imageViewProfile.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        imageViewProfile.widthAnchor.constraint(equalToConstant: imageViewProfile.layer.cornerRadius * 2).isActive = true
        imageViewProfile.heightAnchor.constraint(equalToConstant: imageViewProfile.layer.cornerRadius * 2).isActive = true
        imageViewProfile.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
        borderView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(borderView)
        
        borderView.widthAnchor.constraint(equalTo: imageViewProfile.widthAnchor, constant: 4).isActive = true
        borderView.heightAnchor.constraint(equalTo: imageViewProfile.heightAnchor, constant: 4).isActive = true
        borderView.centerXAnchor.constraint(equalTo: imageViewProfile.centerXAnchor).isActive = true
        borderView.centerYAnchor.constraint(equalTo: imageViewProfile.centerYAnchor).isActive = true
        
        imageViewSelection.translatesAutoresizingMaskIntoConstraints = false
        imageViewSelection.layer.cornerRadius = 46 * QUtils.optimizeRatio()
        imageViewSelection.contentMode = .center
        imageViewSelection.image = UIImage(named: "img_done_nor")
        imageViewSelection.highlightedImage = UIImage(named: "img_done_high")
        self.contentView.addSubview(imageViewSelection)
        
        imageViewSelection.widthAnchor.constraint(equalTo: borderView.widthAnchor).isActive = true
        imageViewSelection.heightAnchor.constraint(equalTo: borderView.heightAnchor).isActive = true
        imageViewSelection.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
        imageViewSelection.centerYAnchor.constraint(equalTo: borderView.centerYAnchor).isActive = true
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelName.textAlignment = .center
        labelName.lineBreakMode = .byWordWrapping
        labelName.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)
        self.contentView.addSubview(labelName)
        
        labelName.topAnchor.constraint(equalTo: imageViewProfile.bottomAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        labelName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 4 * QUtils.optimizeRatio()).isActive = true
        labelName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -4 * QUtils.optimizeRatio()).isActive = true
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        self.contentView.addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: labelName.bottomAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 22 * QUtils.optimizeRatio()).isActive = true
        
        labelAge.translatesAutoresizingMaskIntoConstraints = false
        labelAge.textColor = #colorLiteral(red: 0.4156862745, green: 0.4117647059, blue: 0.4156862745, alpha: 1)
        labelAge.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        containerView.addSubview(labelAge)
        
        labelAge.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        labelAge.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.8745098039, blue: 0.8666666667, alpha: 1)
        contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: labelAge.topAnchor, constant: 2).isActive = true
        seperator.bottomAnchor.constraint(equalTo: labelAge.bottomAnchor, constant: -2).isActive = true
        seperator.leadingAnchor.constraint(equalTo: labelAge.trailingAnchor, constant: 4 * QUtils.optimizeRatio()).isActive = true
        seperator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        labelRegion.translatesAutoresizingMaskIntoConstraints = false
        labelRegion.textColor = #colorLiteral(red: 0.4156862745, green: 0.4117647059, blue: 0.4156862745, alpha: 1)
        labelRegion.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        containerView.addSubview(labelRegion)
        
        labelRegion.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        labelRegion.leadingAnchor.constraint(equalTo: seperator.trailingAnchor, constant: 4 * QUtils.optimizeRatio()).isActive = true
        labelRegion.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        buttonSelection.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(buttonSelection)
        
        buttonSelection.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        buttonSelection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        buttonSelection.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        buttonSelection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setSelected(_ select: Bool, animated: Bool) {
        imageViewSelection.layer.removeAllAnimations()
        selectedCell = select
        
        imageViewSelection.isHighlighted = select
        
        let animations = {() -> Void in
            self.imageViewSelection.backgroundColor = self.selectedCell ? #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 0.4) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        }
        
        guard animated else {
            animations()
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: animations)
    }
}
