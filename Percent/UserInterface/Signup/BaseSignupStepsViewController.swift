//
//  BaseSignupStepsViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 10/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class BaseSignupStepsViewController: BaseViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    internal let headerView = UIView()
    internal let labelTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationViewHidden(true, animated: false)
        
        (self.navigationController as? SignupNavigationViewController)?.setSignupNavigatingView(hidden: false)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        self.view.addSubview(headerView)
        
        headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelTitle.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        headerView.addSubview(labelTitle)
        
        labelTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        labelTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
    }
    
}
