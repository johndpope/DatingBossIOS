//
//  SignupProfileEntryView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 09/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class SignupProfileEntryView: UIView {
    let button = UIButton(type:.custom)
    
    private let imageViewChecked = UIImageView()
    
    let labelTitle = UILabel()
    
    var checked: Bool = false {
        didSet {
            imageViewChecked.isHighlighted = checked
        }
    }
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        imageViewChecked.translatesAutoresizingMaskIntoConstraints = false
        imageViewChecked.image = UIImage(named: "img_validation_unchecked")
        imageViewChecked.highlightedImage = UIImage(named: "img_validation_checked")
        self.addSubview(imageViewChecked)
        
        imageViewChecked.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15 * QUtils.optimizeRatio()).isActive = true
        imageViewChecked.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageViewChecked.widthAnchor.constraint(equalToConstant: 16 * QUtils.optimizeRatio()).isActive = true
        imageViewChecked.heightAnchor.constraint(equalToConstant: 16 * QUtils.optimizeRatio()).isActive = true
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textColor = #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        labelTitle.font = UIFont.systemFont(ofSize: 12 * QUtils.optimizeRatio(), weight: .regular)
        self.addSubview(labelTitle)
        
        labelTitle.leadingAnchor.constraint(equalTo: imageViewChecked.trailingAnchor, constant: 5 * QUtils.optimizeRatio()).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -80 * QUtils.optimizeRatio()).isActive = true
        labelTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @objc internal func pressedButton(_ sender: UIButton) {
    }
}

class SignupProfileTextEntryView: SignupProfileEntryView {
    let buttonTextfield = UIButton(type: .custom)
    
    let textfield = UITextField()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderStyle = .none
        textfield.textAlignment = .right
        textfield.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        textfield.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        self.addSubview(textfield)
        
        textfield.leadingAnchor.constraint(equalTo: labelTitle.trailingAnchor, constant: 40 * QUtils.optimizeRatio()).isActive = true
        textfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -36 * QUtils.optimizeRatio()).isActive = true
        textfield.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        buttonTextfield.translatesAutoresizingMaskIntoConstraints = false
        buttonTextfield.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        self.addSubview(buttonTextfield)
        
        buttonTextfield.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonTextfield.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        buttonTextfield.leadingAnchor.constraint(equalTo: labelTitle.trailingAnchor, constant: 40 * QUtils.optimizeRatio()).isActive = true
        buttonTextfield.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        if sender == buttonTextfield {
            _ = textfield.becomeFirstResponder()
        }
    }
}
