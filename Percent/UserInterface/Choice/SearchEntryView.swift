//
//  SearchEntryView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 21/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class SearchEntryView: UIView {
    let button = UIButton(type:.custom)
    let labelTitle = UILabel()

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelTitle.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        self.addSubview(labelTitle)
        
        labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32 * QUtils.optimizeRatio()).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -80 * QUtils.optimizeRatio()).isActive = true
        labelTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @objc internal func pressedButton(_ sender: UIButton) {
    }
}

protocol SearchEntryViewDelegate {
    func searchEntryView(didClearValue entryView: SearchEntryView)
}

class SearchPopupEntryView: SearchEntryView {
    private let labelValue = UILabel()
    private let buttonClear = UIButton(type: .custom)

    var delegate: SearchEntryViewDelegate?
    
    var value: String? {
        didSet {
            buttonClear.isHidden = (value ?? "").count == 0
            labelValue.text = value
        }
    }
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "img_profile_expand")
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32 * QUtils.optimizeRatio()).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 15 * QUtils.optimizeRatio()).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 15 * QUtils.optimizeRatio()).isActive = true
        
        labelValue.translatesAutoresizingMaskIntoConstraints = false
        labelValue.textAlignment = .right
        labelValue.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelValue.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        self.addSubview(labelValue)
        
        labelValue.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        labelValue.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        buttonClear.translatesAutoresizingMaskIntoConstraints = false
        buttonClear.setImage(UIImage(named: "img_close_small"), for: .normal)
        buttonClear.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        self.addSubview(buttonClear)
        
        buttonClear.isHidden = true
        
        buttonClear.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonClear.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        buttonClear.leadingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        buttonClear.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func pressedButton(_ sender: UIButton) {
        switch sender {
        case buttonClear:
            value = nil
            buttonClear.isHidden = true
            
            delegate?.searchEntryView(didClearValue: self)
            break
            
        default: break
        }
    }
}

class SearchPopupRangeEntryView: SearchEntryView {
    private let labelValue1 = UILabel()
    private let labelValue2 = UILabel()
    
    let button1 = UIButton(type:.custom)
    let button2 = UIButton(type:.custom)
    
    private let buttonClear = UIButton(type: .custom)
    
    var delegate: SearchEntryViewDelegate?
    
    var value1: String? {
        didSet {
            buttonClear.isHidden = ((value1 ?? "").count == 0) && ((value2 ?? "").count == 0)
            labelValue1.text = value1
        }
    }
    
    var value2: String? {
        didSet {
            buttonClear.isHidden = ((value1 ?? "").count == 0) && ((value2 ?? "").count == 0)
            labelValue2.text = value2
        }
    }
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "img_profile_expand")
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
        imageView.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 15 * QUtils.optimizeRatio()).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 15 * QUtils.optimizeRatio()).isActive = true
        
        labelValue1.translatesAutoresizingMaskIntoConstraints = false
        labelValue1.textAlignment = .right
        labelValue1.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelValue1.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        self.addSubview(labelValue1)
        
        labelValue1.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        labelValue1.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        button1.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button1)
        
        button1.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button1.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        button1.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        button1.trailingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "~"
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        self.addSubview(label)
        
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "img_profile_expand")
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32 * QUtils.optimizeRatio()).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 15 * QUtils.optimizeRatio()).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 15 * QUtils.optimizeRatio()).isActive = true
        
        labelValue2.translatesAutoresizingMaskIntoConstraints = false
        labelValue2.textAlignment = .right
        labelValue2.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelValue2.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        self.addSubview(labelValue2)
        
        labelValue2.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        labelValue2.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        button2.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button2)
        
        button2.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button2.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        button2.leadingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button2.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        buttonClear.translatesAutoresizingMaskIntoConstraints = false
        buttonClear.setImage(UIImage(named: "img_close_small"), for: .normal)
        buttonClear.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        self.addSubview(buttonClear)
        
        buttonClear.isHidden = true
        
        buttonClear.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonClear.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        buttonClear.leadingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        buttonClear.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func pressedButton(_ sender: UIButton) {
        switch sender {
        case buttonClear:
            value1 = nil
            value2 = nil
            
            buttonClear.isHidden = true
            
            delegate?.searchEntryView(didClearValue: self)
            break
            
        default: break
        }
    }
}

