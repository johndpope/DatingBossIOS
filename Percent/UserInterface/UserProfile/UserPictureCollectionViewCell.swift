//
//  UserPictureCollectionViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 28/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

import PINRemoteImage

class UserPictureCollectionViewCell: UICollectionViewCell {
    class var itemSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
    }
    
    private let imageView = UIImageView()
    
    private var variConstraint: NSLayoutConstraint!
    var topConstraint: NSLayoutConstraint {
        return variConstraint
    }
    
    var url: URL? {
        didSet {
            imageView.image = nil
            imageView.pin_setImage(from: url)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(imageView)
        
        variConstraint = imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        variConstraint.isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
