//
//  AppDelegate.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 03/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var rootTransition: CATransition {
        get {
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            transition.type = CATransitionType.fade
            transition.subtype = CATransitionSubtype.fromTop
            
            return transition
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        QHttpClient.addCommonHeaderValue("application/json", for: "Content-Type")
        
        let viewController = IntroViewController()
//        let viewController = MainViewController()
        self.window?.rootViewController = viewController
        self.window!.makeKeyAndVisible()
        return true
    }
    
    func changeRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        self.window?.setRootViewController(viewController, transition: animated ? rootTransition : nil)
    }
}
