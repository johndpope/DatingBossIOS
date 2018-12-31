//
//  ChatTableViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 22/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    private let labelMessage = UILabel()
    private let labelTime = UILabel()
    
    private let labelCount = UILabel()
    
    var data: MessageData? {
        didSet {
            guard data != nil else {
                labelMessage.text = nil
                labelTime.text = nil
                
                self.layoutIfNeeded()
                return
            }
            
            labelMessage.text = data?.content
            
            let formatter = DateFormatter()
            formatter.dateFormat = "a hh:mm"
            labelTime.text = formatter.string(from: Date(timeIntervalSince1970: data!.timeInterval))
            
            self.layoutIfNeeded()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        let isMine = reuseIdentifier == "ChatSentTableViewCell"
        
        //        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.clipsToBounds = true
        backView.backgroundColor = isMine ? #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        backView.layer.cornerRadius = 8 * QUtils.optimizeRatio()
        self.contentView.addSubview(backView)
        
        labelMessage.translatesAutoresizingMaskIntoConstraints = false
        labelMessage.textColor  = isMine ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        labelMessage.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        labelMessage.numberOfLines = 0
        backView.addSubview(labelMessage)
        
        labelMessage.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.7, constant: -36 * QUtils.optimizeRatio()).isActive = true
        labelMessage.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
        labelMessage.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        
        backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18 * QUtils.optimizeRatio()).isActive = !isMine
        backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18 * QUtils.optimizeRatio()).isActive = isMine
        backView.widthAnchor.constraint(equalTo: labelMessage.widthAnchor, multiplier: 1.0, constant: 16 * QUtils.optimizeRatio()).isActive = true
        backView.heightAnchor.constraint(equalTo: labelMessage.heightAnchor, multiplier: 1.0, constant: 16 * QUtils.optimizeRatio()).isActive = true
        backView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        labelTime.textColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        labelTime.font = UIFont.systemFont(ofSize: 10 * QUtils.optimizeRatio(), weight: .regular)
        self.contentView.addSubview(labelTime)
        
        labelTime.leadingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = !isMine
        labelTime.trailingAnchor.constraint(equalTo: backView.leadingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = isMine
        labelTime.bottomAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        
        self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.contentView.heightAnchor.constraint(equalTo: backView.heightAnchor, multiplier: 1.0, constant: 8 * QUtils.optimizeRatio()).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

