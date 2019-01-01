//
//  MainViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    let recommendsViewController = RecommendsViewController()
    let choiceViewController = ChoiceViewController()
    let chatListViewController = ChatListViewController()
    let categoryViewController = CategoryViewController()
    let favouriteViewController = FavouriteViewController()
    
    let tabbarView =  MainTabbarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isHidden = true
        self.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 56, right: 0)
        
        var vcs = [UIViewController]()
        var navController = BaseNavigationController(rootViewController: recommendsViewController)
        vcs.append(navController)
        navController = BaseNavigationController(rootViewController: choiceViewController)
        vcs.append(navController)
        navController = BaseNavigationController(rootViewController: chatListViewController)
        vcs.append(navController)
        navController = BaseNavigationController(rootViewController: categoryViewController)
        vcs.append(navController)
        navController = BaseNavigationController(rootViewController: favouriteViewController)
        vcs.append(navController)
        
        self.setViewControllers(vcs, animated: false)
        
        tabbarView.delegate = self
        tabbarView.layer.zPosition = 1000
        tabbarView.translatesAutoresizingMaskIntoConstraints = false
        tabbarView.selectedIndex = 0
        self.view.addSubview(tabbarView)
        
        tabbarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tabbarView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tabbarView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tabbarView.heightAnchor.constraint(equalToConstant: 56 + (UIApplication.appDelegate().window?.safeAreaInsets.bottom ?? 0)).isActive = true
        
        self.view.layoutIfNeeded()
        
        tabbarView.selectedIndex = 0
    }
}

extension MainViewController: MainTabbarViewDelegate {
    func mainTabbarView(_ tabbarView: MainTabbarView, didSelected index: Int) {
        self.selectedIndex = index
    }
}
