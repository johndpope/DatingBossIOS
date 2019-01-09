//
//  AlertPopupViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 09/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class AlertPopupViewController: BasePopupViewController {
    private let titleString: String?
    private let messageString: String?
    
    private var actions = [AlertPopupAction]()
    
    var messageColour = #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
    
    init(withTitle tString: String?, message mString: String?) {
        titleString = tString
        messageString = mString
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = titleString
        
        var labelMessage: UILabel?
        
        if messageString != nil {
            labelMessage = UILabel()
            labelMessage?.translatesAutoresizingMaskIntoConstraints = false
            labelMessage?.text = messageString
            labelMessage?.textColor = messageColour
            labelMessage?.textAlignment = .center
            labelMessage?.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .medium)
            labelMessage?.numberOfLines = 0
            contentView.addSubview(labelMessage!)
            
            if titleString == nil {
                labelMessage?.topAnchor.constraint(equalTo: labelTitle.topAnchor).isActive = true
            } else {
                labelMessage?.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 40 * QUtils.optimizeRatio()).isActive = true
            }
            
            labelMessage?.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15 * QUtils.optimizeRatio()).isActive = true
            labelMessage?.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15 * QUtils.optimizeRatio()).isActive = true
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
                
                button.topAnchor.constraint(equalTo: (labelMessage ?? labelTitle).bottomAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
                button.leadingAnchor.constraint(equalTo: leadingAnchor ?? contentView.leadingAnchor).isActive = true
                button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1 / CGFloat(actions.count)).isActive = true
                button.heightAnchor.constraint(equalToConstant: 50 * QUtils.optimizeRatio()).isActive = true
                
                if i == 0 {
                    button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
                }
                
                leadingAnchor = button.trailingAnchor
            }
        } else {
            (labelMessage ?? labelTitle).bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24 * QUtils.optimizeRatio()).isActive = true
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

class AlertPopupAction: NSObject {
    let backgroundColour: UIColor
    let title: String
    let titleColour: UIColor
    let font: UIFont
    let completion: ((_ action: AlertPopupAction) -> Void)?
    
    init(backgroundColour bgColour: UIColor, title titleString: String, colour: UIColor, font titleFont: UIFont, completion comp: ((_ action: AlertPopupAction) -> Void)?) {
        backgroundColour = bgColour
        title = titleString
        titleColour = colour
        font = titleFont
        completion = comp
        
        super.init()
    }
}

