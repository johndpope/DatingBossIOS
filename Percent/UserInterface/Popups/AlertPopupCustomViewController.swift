//
//  AlertPopupCustomViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 09/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class AlertPopupCustomViewController: BasePopupViewController {
    private let titleString: String?
    
    private var actions = [AlertPopupAction]()
    
    let customView: UIView?
    
    init(withTitle tString: String?, View cView: UIView?) {
        titleString = tString
        customView = cView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = titleString
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        if titleString == nil {
            containerView.topAnchor.constraint(equalTo: labelTitle.topAnchor).isActive = true
        } else {
            containerView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        }
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        if customView != nil {
            containerView.addSubview(customView!)
            containerView.heightAnchor.constraint(equalToConstant: customView!.frame.size.height).isActive = true
        } else {
            containerView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        
        if actions.count > 0 {
            var leadingAnchor: NSLayoutXAxisAnchor?
            
            for i in 0 ..< actions.count {
                let action = actions[i]
                
                let button = UIButton(type: .custom)
                button.setBackgroundImage(UIImage.withSolid(colour: action.backgroundColour), for: .normal)
                button.setBackgroundImage(UIImage.withSolid(colour: action.backgroundColour), for: .highlighted)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.setTitle(action.title, for: .normal)
                button.setTitleColor(action.titleColour, for: .normal)
                button.titleLabel?.font = action.font
                button.tag = i
                button.addTarget(self, action: #selector(self.pressedActionButton(_:)), for: .touchUpInside)
                contentView.addSubview(button)
                
                button.topAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
                button.leadingAnchor.constraint(equalTo: leadingAnchor ?? contentView.leadingAnchor).isActive = true
                button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1 / CGFloat(actions.count)).isActive = true
                button.heightAnchor.constraint(equalToConstant: 50 * QUtils.optimizeRatio()).isActive = true
                
                if i == 0 {
                    button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
                }
                
                leadingAnchor = button.trailingAnchor
            }
        } else {
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24 * QUtils.optimizeRatio()).isActive = true
        }
    }
    
    func addAction(action: AlertPopupAction) {
        actions.append(action)
    }
    
    @objc private func pressedActionButton(_ sender: UIButton) {
        hide { (complete) in
            self.view.removeFromSuperview()
            self.removeFromParent()
            
            let action = self.actions[sender.tag]
            action.completion?(action)
        }
    }
}
