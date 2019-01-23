//
//  IntroViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 08/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

private let IMAGE_RESIZE_RATIO = CGFloat(0.7)

class IntroViewController: BaseViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let imageViewTitle = UIImageView()
    private let imageViewIcon = UIImageView()
    private let imageViewHeart = UIImageView()
    private let circleView = CircleIndicatorView(backgroundColour: .clear, indicatorColour: .white, lineWidth: 6)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationViewHidden(true, animated: false)
        
        self.view.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentView)
        
        contentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        var image = UIImage(named: "img_intro_text")
        imageViewTitle.translatesAutoresizingMaskIntoConstraints = false
        imageViewTitle.image = image
        contentView.addSubview(imageViewTitle)
        
        imageViewTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageViewTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageViewTitle.widthAnchor.constraint(equalToConstant: (image?.size.width ?? 0) * IMAGE_RESIZE_RATIO).isActive = true
        imageViewTitle.heightAnchor.constraint(equalToConstant: (image?.size.height ?? 0) * IMAGE_RESIZE_RATIO).isActive = true
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.value = 0.0
        contentView.addSubview(circleView)
        
        circleView.leadingAnchor.constraint(equalTo: imageViewTitle.trailingAnchor, constant: 18 * QUtils.optimizeRatio()).isActive = true
        circleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        circleView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        circleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: 96 * QUtils.optimizeRatio() * IMAGE_RESIZE_RATIO).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: 96 * QUtils.optimizeRatio() * IMAGE_RESIZE_RATIO).isActive = true
        
        image = UIImage(named: "img_intro_percent")
        imageViewIcon.translatesAutoresizingMaskIntoConstraints = false
        imageViewIcon.image  = image
        contentView.addSubview(imageViewIcon)
        
        imageViewIcon.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        imageViewIcon.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        imageViewIcon.widthAnchor.constraint(equalToConstant: (image?.size.width ?? 0) * IMAGE_RESIZE_RATIO).isActive = true
        imageViewIcon.heightAnchor.constraint(equalToConstant: (image?.size.height ?? 0) * IMAGE_RESIZE_RATIO).isActive = true
        
        image = UIImage(named: "img_intro_heart")
        imageViewHeart.translatesAutoresizingMaskIntoConstraints = false
        imageViewHeart.image  = image
        imageViewHeart.alpha = 0
        contentView.addSubview(imageViewHeart)
        
        imageViewHeart.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        imageViewHeart.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        imageViewHeart.widthAnchor.constraint(equalToConstant: (image?.size.width ?? 0) * IMAGE_RESIZE_RATIO).isActive = true
        imageViewHeart.heightAnchor.constraint(equalToConstant: (image?.size.height ?? 0) * IMAGE_RESIZE_RATIO).isActive = true
        
        self.view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var animated = false
        var value = CGFloat(0.0)
        _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            value += 0.01
            self.circleView.value = value
            
            if value >= 1.0 {
                timer.invalidate()
            }
            
            guard animated == false, value >= 0.9 else { return }
            animated = true
            
            self.imageViewHeart.alpha = 1.0
            self.imageViewIcon.alpha = 0.0
            
            UIView.animate(withDuration: 0.2, animations: {
                self.imageViewHeart.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: { (complete) in
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.8, options: [], animations: {
                    self.imageViewHeart.transform = CGAffineTransform.identity
                }, completion: { (complete) in
                    let gotoLogin = {() -> Void in
                        let viewController = LoginViewController()
                        UIApplication.appDelegate().changeRootViewController(viewController)
                    }
                    
                    guard let userId = QDataManager.shared.userId, let password = QDataManager.shared.password else {
                        gotoLogin()
                        return
                    }
                    
                    var params = [String:Any]()
                    params["id"] = userId
                    params["pw"] = password
                    params["app_version"] = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
                    params["os"] = "ios"
                    params["device_info"] = UIDevice.modelName
                    
                    let httpClient = QHttpClient()
                    httpClient.request(to: RequestUrl.Account.Login, params: params) { (isSucceed, errMessage, response) in
                        LoadingIndicatorManager.shared.hideIndicatorView()
                        guard isSucceed, let responseData = response as? [String:Any], responseData["mem_idx"] as? Int != nil else {
                            QDataManager.shared.password = nil
                            QDataManager.shared.commit()
                            
                            gotoLogin()
                            return
                        }
                        
                        MyData.shared.setMyInfo(with: responseData)

                        AppDataManager.shared.reloadData()
                        
                        guard ApplicationOptions.Build.Level.rawValue > BuildLevel.DEVELOP.rawValue else {
                            let viewController = SignupProfileViewController()
                            let navController = SignupNavigationViewController(rootViewController: viewController)
                            UIApplication.appDelegate().changeRootViewController(navController, animated: true)
                            return
                        }

                        switch MyData.shared.signupStatus {
                        case .complete:
                            let viewController = MainViewController()
                            UIApplication.appDelegate().changeRootViewController(viewController, animated: true)
                            break

                        case .denied:
                            gotoLogin()
                            break

                        case .profile:
                            UserPayload.shared.loadFromDatabase()
                        
                            let viewController = SignupProfileSpecsViewController()
                            viewController.showCurrentStep = true
                            let navController = SignupNavigationViewController(rootViewController: viewController)
                            UIApplication.appDelegate().changeRootViewController(navController, animated: true)
                            break

                        case .survey:
                            UserPayload.shared.loadFromDatabase()

                            let viewController = SignupSurveyViewController()
                            viewController.showCurrentStep = true
                            let navController = SignupNavigationViewController(rootViewController: viewController)
                            UIApplication.appDelegate().changeRootViewController(navController, animated: true)
                            break

                        case .looks:
                            UserPayload.shared.loadFromDatabase()

                            let viewController = SignupSelectFavorLooksViewController()
                            viewController.showCurrentStep = true
                            let navController = SignupNavigationViewController(rootViewController: viewController)
                            UIApplication.appDelegate().changeRootViewController(navController, animated: true)
                            break

                        case .pending:
                            UserPayload.shared.loadFromDatabase()

                            let viewController = SignupFinalizeViewController()
                            UIApplication.appDelegate().changeRootViewController(viewController, animated: true)
                            break

                        default: break
                        }
                    }
                })
            })
            
        })
    }
}
