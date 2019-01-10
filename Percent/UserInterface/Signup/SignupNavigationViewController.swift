//
//  SignupNavigationViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 12/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class SignupNavigationViewController: UINavigationController {
    let navigatingView = SignupNavigationBarView()
    
    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigatingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navigatingView)
        
        navigatingView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigatingView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        navigatingView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        navigatingView.heightAnchor.constraint(equalToConstant: kHeightSignupNavigationBarView).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigatingView.updateValue(animated: false)
    }
    
    func setSignupNavigatingView(hidden: Bool) {
        self.additionalSafeAreaInsets = UIEdgeInsets(top: hidden ? 0 : kHeightSignupNavigationBarView, left: 0, bottom: 0, right: 0)
        navigatingView.isHidden = hidden
    }
}
