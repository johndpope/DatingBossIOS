//
//  ProfileButton.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 10/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

import PINRemoteImage

class ProfileButton: UIButton {
    private let imageViewProfile = UIImageView()
    
    var member_idx: Int?
    var imageName: String?
    
    init(frame: CGRect = CGRect.zero, cornerRadius: CGFloat = 18) {
        super.init(frame: frame)
        
        imageViewProfile.translatesAutoresizingMaskIntoConstraints = false
        imageViewProfile.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        imageViewProfile.contentMode = .scaleAspectFill
        imageViewProfile.layer.cornerRadius = cornerRadius
        imageViewProfile.clipsToBounds = true
        self.addSubview(imageViewProfile)
        
        imageViewProfile.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageViewProfile.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageViewProfile.widthAnchor.constraint(equalToConstant: cornerRadius * 2).isActive = true
        imageViewProfile.heightAnchor.constraint(equalToConstant: cornerRadius * 2).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func reloadData() {
        guard member_idx != nil, imageName != nil else { return }
        let imageUrl = RequestUrl.Image.File + "\(member_idx!)/\(imageName!)"
        
        guard let url = URL(string: imageUrl) else {
            self.imageViewProfile.image = nil
            return
        }
        
        PINRemoteImageManager.shared().downloadImage(with: url) { (result) in
            DispatchQueue.main.async {
                self.imageViewProfile.image = result.image
            }
        }
    }
}
