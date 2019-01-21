//
//  EditProfileViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 21/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

import AVFoundation
import Photos

import MobileCoreServices

class EditProfileViewController: BaseEditProfileViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationTintColor = #colorLiteral(red: 0.168627451, green: 0.168627451, blue: 0.168627451, alpha: 1)
        self.navigationView.contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.setNavigationViewHidden(false, animated: false)
        
        self.title = "프로필 작성"
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonConfirm:
            uploadProfile { (isSucceed) in
                guard isSucceed else { return }
                
                self.navigationController?.popViewController(animated: true)
            }
            break
            
        case buttonCancel:
            self.navigationController?.popViewController(animated: true)
            break
            
        default: break
        }
    }
}
