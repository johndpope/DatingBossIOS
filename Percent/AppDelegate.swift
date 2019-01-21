//
//  AppDelegate.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 03/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

import Firebase

import  UserNotifications

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
        
//        SurveyManager.shared.clearSurveyAnswer()
        
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        }
        
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        
        
        let viewController = IntroViewController()
        self.window?.rootViewController = viewController
        self.window!.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        
        QDataManager.shared.deviceToken = deviceToken
        QDataManager.shared.commit()
    }
    
    func changeRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        self.window?.setRootViewController(viewController, transition: animated ? rootTransition : nil)
    }
    
    func updateFCMToken() {
        guard MyData.shared.auth_key != nil, let fcmToken = QDataManager.shared.fcmToken else { return }
        
        var params = [String:Any]()
        params["fcm_key"] = fcmToken
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Notification.UpdateToken + "\(MyData.shared.mem_idx)", method: .patch, headerValues: nil, params: params, completion: nil)
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        QDataManager.shared.fcmToken = fcmToken
        QDataManager.shared.commit()
        
        updateFCMToken()
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([])
    }
}
