//
//  SignupProfilePictureCollectionViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 17/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class SignupProfilePictureCollectionViewCell: UICollectionViewCell {
    class var sectionInset: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8 * QUtils.optimizeRatio(), bottom: 0, right: 8 * QUtils.optimizeRatio())
    }
    
    class var minimumLineSpacing: CGFloat {
        return 0
    }
    
    class var minimumInteritemSpacing: CGFloat {
        return 0
    }
    
    class var itemSize: CGSize {
        return CGSize(width: 104 * QUtils.optimizeRatio(), height: 120 * QUtils.optimizeRatio())
    }
    
    private let imageViewPicture = UIImageView()
    
    var image: UIImage? {
        didSet {
            imageViewPicture.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8745098039, blue: 0.8666666667, alpha: 1)
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 44 * QUtils.optimizeRatio()
        imageView.image = UIImage(named: "img_plus")?.resize(withSize: CGSize(width: 32 * QUtils.optimizeRatio(), height: 32 * QUtils.optimizeRatio()))
        imageView.contentMode = .center
        self.contentView.addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageView.layer.cornerRadius * 2).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageView.layer.cornerRadius * 2).isActive = true
        
        imageViewPicture.translatesAutoresizingMaskIntoConstraints = false
        imageViewPicture.contentMode = .scaleAspectFill
        imageViewPicture.clipsToBounds = true
        imageViewPicture.layer.cornerRadius = imageView.layer.cornerRadius
        self.contentView.addSubview(imageViewPicture)
        
        imageViewPicture.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        imageViewPicture.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        imageViewPicture.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        imageViewPicture.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
