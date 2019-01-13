//
//  BasePopupViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 18/12/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

let kWidthPopupContentView = CGFloat(280)

@objc protocol BasePopupViewControllerDelegate {
    @objc optional func popupViewController(dismissed viewController: BasePopupViewController)
}

class BasePopupViewController: UIViewController {
    internal let buttonDismiss = UIButton(type: .custom)
    
    internal let contentView = UIView()
    let labelTitle = UILabel()
    
    var titleColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
    
    var delegate: BasePopupViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        
        buttonDismiss.translatesAutoresizingMaskIntoConstraints = false
        buttonDismiss.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        self.view.addSubview(buttonDismiss)
        
        buttonDismiss.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        buttonDismiss.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        buttonDismiss.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        buttonDismiss.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16 * QUtils.optimizeRatio()
        self.view.addSubview(contentView)
        
        contentView.alpha = 0
        contentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        contentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: kWidthPopupContentView).isActive = true
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textColor = titleColour
        labelTitle.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        contentView.addSubview(labelTitle)
        
        labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        labelTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 23 * QUtils.optimizeRatio()).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    @objc internal func pressedButton(_ sender: UIButton) {
        switch sender {
        case buttonDismiss:
            self.hide { (complete) in
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
            break
        default:
            break
        }
    }
    
    func show() {
        UIView.animate(withDuration: 0.3) {
            self.contentView.alpha = 1
            self.contentView.transform = CGAffineTransform.identity
            
            self.buttonDismiss.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.66)
        }
    }
    
    func hide(_ completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.alpha = 0
            self.contentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            self.buttonDismiss.backgroundColor = .clear
        }) { (complete) in
            completion?(true)
            self.delegate?.popupViewController?(dismissed: self)
        }
    }
}

