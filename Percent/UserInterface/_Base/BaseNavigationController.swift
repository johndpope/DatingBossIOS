//
//  BaseNavigationController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 05/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: false)
        
        self.interactivePopGestureRecognizer?.isEnabled = true
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    //    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    //        super.pushViewController(viewController, animated: animated)
    //        self.interactivePopGestureRecognizer?.isEnabled = false
    //    }
}

extension BaseNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
