//
//  PSwitchView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 03/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

@objc protocol PSwitchViewDelegate {
    @objc optional func switchView(canChangeValue switchView: PSwitchView) -> Bool
    @objc optional func switchView(didChangeValue switchView: PSwitchView)
}

class PSwitchView: UIView {
    private var on: Bool = false
    var isOn: Bool {
        return on
    }
    
    private let buttonView = UIView()
    private let backView = UIView()
    private let buttonSwitch = UIButton(type: .custom)
    
    private var constraintOn: NSLayoutConstraint!
    private var constraintOff: NSLayoutConstraint!
    
    var delegate: PSwitchViewDelegate?
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.clipsToBounds = true
        backView.layer.borderWidth = 1
        self.addSubview(backView)
        
        backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3).isActive = true
        backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3).isActive = true
        backView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        buttonView.clipsToBounds = true
        buttonView.layer.borderWidth = 1
        self.addSubview(buttonView)
        
        buttonView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        constraintOff = buttonView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        constraintOff.isActive = true
        constraintOn = buttonView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        constraintOn.isActive = true
        buttonView.heightAnchor.constraint(equalTo: buttonView.widthAnchor).isActive = true
        
        buttonSwitch.translatesAutoresizingMaskIntoConstraints = false
        buttonSwitch.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        self.addSubview(buttonSwitch)
        
        buttonSwitch.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonSwitch.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        buttonSwitch.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        buttonSwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.layoutIfNeeded()
        
        set(on: false, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.layer.cornerRadius = backView.frame.size.height / 2
        buttonView.layer.cornerRadius = buttonView.frame.size.height / 2
    }
    
    @objc private func pressedButton(_ sender: UIButton) {
        guard (delegate?.switchView?(canChangeValue: self) ?? true) == true else { return }
        set(on: !on, animated: true)
    }
    
    func set(on value: Bool, animated: Bool) {
        let animations = {() -> Void in
            self.backView.backgroundColor = value ? #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1) : #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
            self.backView.layer.borderColor = value ? #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1) : #colorLiteral(red: 0.8784313725, green: 0.8745098039, blue: 0.8666666667, alpha: 1)
            
            self.buttonView.layer.borderColor = value ? #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1) : #colorLiteral(red: 0.8784313725, green: 0.8745098039, blue: 0.8666666667, alpha: 1)
            
            self.constraintOn.isActive = value
            self.constraintOff.isActive = !value
            
            self.layoutIfNeeded()
        }
        
        let completion = {(complete: Bool) -> Void in
            self.delegate?.switchView?(didChangeValue: self)
        }
        
        guard animated else {
            animations()
            completion(true)
            return
        }
        
        UIView.animate(withDuration: 0.15, animations: animations, completion: completion)
    }
}
