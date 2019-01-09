//
//  BaseSignupViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 09/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class BaseSignupViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationView.contentView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
