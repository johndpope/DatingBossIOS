//
//  BaseMainViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 02/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class BaseMainViewController: BaseViewController {
    internal let buttonProfile = ProfileButton()
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonProfile:
            let viewController = MyPageViewController()
            let navController = UINavigationController(rootViewController: viewController)
            self.present(navController, animated: true, completion: nil)
            break
            
        default:
            break
        }
    }
    
    override func loadNavigationItems() {
        buttonProfile.member_idx = MyData.shared.mem_idx
        buttonProfile.imageName = MyData.shared.picture_name
        buttonProfile.translatesAutoresizingMaskIntoConstraints = false
        buttonProfile.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        self.navigationView.contentView.addSubview(buttonProfile)
        
        buttonProfile.reloadData()
        
        buttonProfile.bottomAnchor.constraint(equalTo: self.navigationView.contentView.bottomAnchor).isActive = true
        buttonProfile.leadingAnchor.constraint(equalTo: self.navigationView.contentView.leadingAnchor, constant: 6 * QUtils.optimizeRatio()).isActive = true
        buttonProfile.widthAnchor.constraint(equalToConstant: 60 * QUtils.optimizeRatio()).isActive = true
        buttonProfile.heightAnchor.constraint(equalToConstant: kHeightNavigationView).isActive = true
    }
}
