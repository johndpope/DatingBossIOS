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
        labelTitle.textColor = #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        labelTitle.font = UIFont.systemFont(ofSize: 12 * QUtils.optimizeRatio(), weight: .regular)
        self.addSubview(labelTitle)
        
        labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -80 * QUtils.optimizeRatio()).isActive = true
        labelTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @objc internal func pressedButton(_ sender: UIButton) {
    }
}

protocol SearchPopupEntryViewDelegate {
    func searchPopupEntryView(didClearValue entryView: SearchPopupEntryView)
}

class SearchPopupEntryView: SearchEntryView {
    private let labelValue = UILabel()
    private let buttonClear = UIButton(type: .custom)

    var delegate: SearchPopupEntryViewDelegate?
    
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
        
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
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
        buttonClear.leadingAnchor.constraint(equalTo: labelValue.trailingAnchor).isActive = true
        buttonClear.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func pressedButton(_ sender: UIButton) {
        switch sender {
        case buttonClear:
            labelValue.text = nil
            buttonClear.isHidden = true
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
    
    var delegate: SearchPopupEntryViewDelegate?
    
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
        label.text = "~"
        
        
        buttonClear.translatesAutoresizingMaskIntoConstraints = false
        buttonClear.setImage(UIImage(named: "img_close_small"), for: .normal)
        buttonClear.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        self.addSubview(buttonClear)
        
        buttonClear.isHidden = true
        
        buttonClear.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonClear.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        buttonClear.leadingAnchor.constraint(equalTo: labelValue2.trailingAnchor).isActive = true
        buttonClear.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func pressedButton(_ sender: UIButton) {
        switch sender {
        case buttonClear:
//            labelValue.text = nil
            buttonClear.isHidden = true
            break
            
        default: break
        }
    }
}

