//
//  BaseViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 05/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

let kHeightNavigationView = CGFloat(56)
let kTagNavigationBottomLine = 90001

class BaseViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    let navigationView: UIVisualEffectView
    
    var leftNavigationItemView: UIButton?
    var cherriesButton = CherryButton()
    
    internal var navigationTintColor = #colorLiteral(red: 0.168627451, green: 0.168627451, blue: 0.168627451, alpha: 1)
    private var navigationViewHidden = false
    var isNavigationViewHidden: Bool {
        return navigationViewHidden
    }
    
    internal var navigationViewBottmAnchor: NSLayoutConstraint!
    
    private var viewAppeared = false
    var initialized: Bool {
        return viewAppeared
    }
    
    internal var showCherriesOnNavigation: Bool = false {
        didSet {
            cherriesButton.isHidden = !showCherriesOnNavigation
        }
    }
    
    init(navigationViewEffect effect: UIVisualEffect? = nil) {
        navigationView = UIVisualEffectView(effect: effect)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.receiveCherryNotification(_:)), name: NotificationName.Cherry.Increased, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.receiveCherryNotification(_:)), name: NotificationName.Cherry.Decreased, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.receiveCherryNotification(_:)), name: NotificationName.Cherry.Changed, object: nil)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: kHeightNavigationView, right: 0)
        
        navigationView.contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navigationView)
        
        navigationViewBottmAnchor = navigationView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        navigationViewBottmAnchor.isActive = true
        navigationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: kHeightNavigationView + UIApplication.shared.statusBarFrame.size.height).isActive = true
        
        let seperator = UIView()
        seperator.tag = kTagNavigationBottomLine
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        navigationView.contentView.addSubview(seperator)
        
        seperator.leadingAnchor.constraint(equalTo: navigationView.contentView.leadingAnchor).isActive = true
        seperator.trailingAnchor.constraint(equalTo: navigationView.contentView.trailingAnchor).isActive = true
        seperator.bottomAnchor.constraint(equalTo: navigationView.contentView.bottomAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.additionalSafeAreaInsets = UIEdgeInsets(top: kHeightNavigationView, left: 0, bottom: 0, right: 0)
        
        navigationView.layer.zPosition = 10000
        
        cherriesButton.translatesAutoresizingMaskIntoConstraints = false
        cherriesButton.isHidden = !showCherriesOnNavigation
        navigationView.contentView.addSubview(cherriesButton)
        
        cherriesButton.bottomAnchor.constraint(equalTo: navigationView.contentView.bottomAnchor).isActive = true
        cherriesButton.trailingAnchor.constraint(equalTo: navigationView.contentView.trailingAnchor, constant: -6).isActive = true
        cherriesButton.heightAnchor.constraint(equalToConstant: kHeightNavigationView).isActive = true
        
        cherriesButton.amount = MyData.shared.cherry_quantity
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigationView.frame.insetBy(dx: 0, dy: UIApplication.shared.statusBarFrame.size.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(MyData.shared.cherry_quantity)
        cherriesButton.amount = MyData.shared.cherry_quantity
        
        if leftNavigationItemView == nil {
            let viewControllers = self.navigationController?.viewControllers ?? []
            
            var image: UIImage?
            
            if viewControllers.count > 1 {
                image = UIImage.navigationBackwardImage
            } else if self.navigationController?.presentingViewController != nil {
                image = UIImage.navigationCloseImage
            }
            
            if image != nil {
                leftNavigationItemView = UIButton()
                leftNavigationItemView?.setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
                leftNavigationItemView?.tintColor = navigationTintColor
                leftNavigationItemView?.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
                leftNavigationItemView?.translatesAutoresizingMaskIntoConstraints = false
                navigationView.contentView.addSubview(leftNavigationItemView!)
                
                leftNavigationItemView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
                leftNavigationItemView?.heightAnchor.constraint(equalToConstant: kHeightNavigationView).isActive = true
                leftNavigationItemView?.bottomAnchor.constraint(equalTo: navigationView.contentView.bottomAnchor).isActive = true
                leftNavigationItemView?.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor, constant: 20 * QUtils.optimizeRatio()).isActive = true
                
                self.view.bringSubviewToFront(navigationView)
            }
        }
        
        loadNavigationItems()
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = self.title
        titleLabel.textColor = navigationTintColor
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        navigationView.contentView.addSubview(titleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: navigationView.contentView.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: navigationView.contentView.bottomAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: kHeightNavigationView).isActive = true
        
        navigationView.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewAppeared = true
    }
    
    @objc internal func pressedButton(_ sender: UIButton) {
        if sender == leftNavigationItemView {
            let viewControllers = self.navigationController?.viewControllers ?? []
            
            if viewControllers.count > 1 {
                self.navigationController?.popViewController(animated: true)
            } else if self.navigationController?.presentingViewController != nil {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    internal func loadNavigationItems() {
        
    }
    
    func setNavigationViewHidden(_ hidden: Bool, animated: Bool) {
        navigationViewHidden = hidden
        
        let animations = {() -> Void in
            self.additionalSafeAreaInsets = UIEdgeInsets(top: hidden ? 0 : kHeightNavigationView, left: 0, bottom: 0, right: 0)
            self.view.layoutIfNeeded()
            
            self.navigationView.alpha = hidden ? 0 : 1
        }
        
        guard animated else {
            animations()
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: animations)
    }
    
    internal func pressedTabButton() {}
    
    func scrollToTop(animated: Bool = true) {}
    
    @objc func receiveReloadNotification(_ notification: Notification) {}
    
    @objc private func receiveCherryNotification(_ notification: Notification) {
        guard let value = notification.object as? Int else { return }
        
        switch notification.name {
        case NotificationName.Cherry.Increased:
            cherriesButton.amount += value
            break
            
        case NotificationName.Cherry.Decreased:
            cherriesButton.amount -= value
            break
            
        case NotificationName.Cherry.Changed:
            cherriesButton.amount = value
            break
            
        default: break
        }
        
        navigationView.layoutIfNeeded()
    }
}
