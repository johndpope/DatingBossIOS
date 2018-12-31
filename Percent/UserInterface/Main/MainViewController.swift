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
        
        tabbarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -56).isActive = true
        tabbarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tabbarView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tabbarView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.view.layoutIfNeeded()
        
        tabbarView.selectedIndex = 0
    }
}

extension MainViewController: MainTabbarViewDelegate {
    func mainTabbarView(_ tabbarView: MainTabbarView, didSelected index: Int) {
        self.selectedIndex = index
    }
}
