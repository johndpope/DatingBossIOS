//
//  MainTabbarView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

protocol MainTabbarViewDelegate {
    func mainTabbarView(_ tabbarView: MainTabbarView, didSelected index: Int)
}

class MainTabbarView: UIVisualEffectView {
    var unreadChatCount: Int = 0
    
    private var buttons = [UIButton]()
    var items: [UIButton] {
        return buttons
    }
    
    var delegate: MainTabbarViewDelegate?
    
    var selectedIndex: Int {
        get {
            var selectedButton: UIButton?
            for button in buttons {
                guard button.isSelected else { continue }
                selectedButton = button
                break
            }
            
            return selectedButton?.tag ?? -1
        } set {
            for button in buttons {
                button.isSelected = button.tag == newValue
            }
            
            self.delegate?.mainTabbarView(self, didSelected: newValue)
        }
    }
    
    init() {
        super.init(effect: UIBlurEffect(style: .extraLight))
        
        var trailingAnchor: NSLayoutXAxisAnchor?
        
        for i in 0 ..< 5 {
            let button = UIButton(type: .custom)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = i
            button.setImage(UIImage(named: "img_tab_\(i + 1)_nor")?.resize(maxWidth: 24 * QUtils.optimizeRatio()), for: .normal)
            button.setImage(UIImage(named: "img_tab_\(i + 1)_sel")?.resize(maxWidth: 24 * QUtils.optimizeRatio()), for: .selected)
            button.addTarget(self, action: #selector(self.pressedTab(_:)), for: .touchUpInside)
            self.contentView.addSubview(button)
            
            buttons.append(button)
            
            button.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
            button.heightAnchor.constraint(equalToConstant: 56).isActive = true
            if trailingAnchor == nil {
                button.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
            } else {
                button.leadingAnchor.constraint(equalTo: trailingAnchor!).isActive = true
            }
            button.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.20).isActive = true
            
            trailingAnchor = button.trailingAnchor
        }
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @objc func pressedTab(_ sender: UIButton) {
        selectedIndex = sender.tag
    }
}
