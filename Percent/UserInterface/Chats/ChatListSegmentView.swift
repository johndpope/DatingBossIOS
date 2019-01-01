//
//  ChatListSegmentView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 22/11/2018.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

enum ChatListType {
    case Requesting
    case Requested
}

protocol ChatListSegmentViewDelegate {
    func chatListSegmentView(_ segmentView: ChatListSegmentView, didSelect type: ChatListType)
}

class ChatListSegmentView: UIView {
    private let buttonRequestingChats = UIButton()
    private let buttonRequestedChats = UIButton()
    
    private let labelRequestingCount = UILabel()
    private let labelRequestedCount = UILabel()
    
    private let indicatorView = UIView()
    
    private var constraintIndicatorLeading: NSLayoutConstraint!
    
    private var constraintRequestingWidth: NSLayoutConstraint!
    private var constraintRequestedWidth: NSLayoutConstraint!
    
    var delegate: ChatListSegmentViewDelegate?
    
    var badgeCountRequesting: Int = 0 {
        didSet {
            labelRequestingCount.text = "\(badgeCountRequesting)"
            labelRequestingCount.sizeToFit()
            constraintRequestingWidth.constant = labelRequestingCount.frame.size.width
            
            self.layoutIfNeeded()
            
            labelRequestingCount.superview?.isHidden = badgeCountRequesting == 0
        }
    }
    
    var badgeCountRequested: Int = 0 {
        didSet {
            labelRequestedCount.text = "\(badgeCountRequested)"
            labelRequestedCount.sizeToFit()
            constraintRequestedWidth.constant = labelRequestedCount.frame.size.width
            
            self.layoutIfNeeded()
            
            labelRequestedCount.superview?.isHidden = badgeCountRequested == 0
        }
    }
    
    private var type: ChatListType = .Requesting
    var selectedType: ChatListType {
        return type
    }
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        self.addSubview(bottomView)
        
        bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        bottomView.addSubview(indicatorView)
        
        indicatorView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        constraintIndicatorLeading = indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        constraintIndicatorLeading.isActive = true
        indicatorView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        
        buttonRequestingChats.translatesAutoresizingMaskIntoConstraints = false
        buttonRequestingChats.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        self.addSubview(buttonRequestingChats)
        
        buttonRequestingChats.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonRequestingChats.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        buttonRequestingChats.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        buttonRequestingChats.trailingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "요청한 채팅"
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .regular)
        self.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: buttonRequestingChats.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: buttonRequestingChats.centerYAnchor).isActive = true
        
        var backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 8
        backView.isHidden = true
        self.addSubview(backView)
        
        labelRequestingCount.translatesAutoresizingMaskIntoConstraints = false
        labelRequestingCount.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        labelRequestingCount.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        backView.addSubview(labelRequestingCount)
        
        backView.heightAnchor.constraint(equalToConstant: backView.layer.cornerRadius * 2).isActive = true
        backView.widthAnchor.constraint(equalTo: labelRequestingCount.widthAnchor, constant: 8).isActive = true
        backView.centerYAnchor.constraint(equalTo: label.topAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 3).isActive = true
        
        labelRequestingCount.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 4).isActive = true
        labelRequestingCount.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 4).isActive = true
        labelRequestingCount.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        constraintRequestingWidth = labelRequestingCount.widthAnchor.constraint(equalToConstant: 0)
        constraintRequestingWidth.isActive = true
        
        buttonRequestedChats.translatesAutoresizingMaskIntoConstraints = false
        buttonRequestedChats.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        self.addSubview(buttonRequestedChats)
        
        buttonRequestedChats.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonRequestedChats.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        buttonRequestedChats.leadingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        buttonRequestedChats.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "요청 받은 채팅"
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .regular)
        self.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: buttonRequestedChats.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: buttonRequestedChats.centerYAnchor).isActive = true
       
        backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 8
        backView.isHidden = true
        self.addSubview(backView)
        
        labelRequestedCount.translatesAutoresizingMaskIntoConstraints = false
        labelRequestedCount.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        labelRequestedCount.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        backView.addSubview(labelRequestedCount)
        
        backView.heightAnchor.constraint(equalToConstant: backView.layer.cornerRadius * 2).isActive = true
        backView.widthAnchor.constraint(equalTo: labelRequestedCount.widthAnchor, constant: 8).isActive = true
        backView.centerYAnchor.constraint(equalTo: label.topAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 3).isActive = true
        
        labelRequestedCount.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 4).isActive = true
        labelRequestedCount.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 4).isActive = true
        labelRequestedCount.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        constraintRequestedWidth = labelRequestedCount.widthAnchor.constraint(equalToConstant: 0)
        constraintRequestedWidth.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @objc private func pressedButton(_ sender: UIButton) {
        let newValue = sender == buttonRequestingChats ? ChatListType.Requesting : ChatListType.Requested
        delegate?.chatListSegmentView(self, didSelect: newValue)
        
        guard type != newValue else { return }
        type = newValue
        
        UIView.animate(withDuration: 0.3) {
            self.constraintIndicatorLeading.constant = self.type == .Requesting ? 0 : self.frame.size.width / 2
            self.layoutIfNeeded()
        }
    }
}
