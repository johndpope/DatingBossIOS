//
//  ChatListTableViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 22/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {
    class var height: CGFloat {
        return 72 * QUtils.optimizeRatio()
    }
    
    private let imageViewProfile = UIImageView()
    private let labelName = UILabel()
    private let labelAge = UILabel()
    private let labelRegion = UILabel()
    private let labelJob = UILabel()
    
    private let labelStatus = UILabel()
    private let labelLastVisit = UILabel()
    
    private let buttonClose = UIButton()
    
    var data: ChatListData? {
        didSet {
            imageViewProfile.pin_setImage(from: URL(string: data?.picture_name ?? ""))
            
            labelName.text = data?.nickname
            labelAge.text = "\(data?.age ?? 0)세"
            labelRegion.text = data?.area
            labelJob.text = data?.job
            
            if let status = data?.status {
                var statusString: String?
                var colour: UIColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
                
                switch status {
                case .InProgress:
                    statusString = "채팅중"
                    colour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
                    break
                    
                case .Refused:
                    statusString = "거절"
                    colour = #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
                    break
                    
                case .Pending:
                    statusString = "대기"
                    colour = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
                    break
                    
                case .Accepted:
                    statusString = "수락"
                    colour = #colorLiteral(red: 1, green: 0.5960784314, blue: 0.6274509804, alpha: 1)
                    break
                }
                
                labelStatus.text = statusString
                labelStatus.textColor = colour
            } else {
                labelStatus.text = nil
            }
            
            if let timeInterval = data?.last_visit_dt {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy.MM.dd"
                labelLastVisit.text = "최근방문일 " + formatter.string(from: Date(timeIntervalSince1970: timeInterval))
            } else {
                labelLastVisit.text = nil
            }
            
            self.layoutIfNeeded()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        imageViewProfile.translatesAutoresizingMaskIntoConstraints = false
        imageViewProfile.contentMode = .scaleAspectFill
        imageViewProfile.clipsToBounds = true
        imageViewProfile.layer.cornerRadius = 20 * QUtils.optimizeRatio()
        self.contentView.addSubview(imageViewProfile)
        
        imageViewProfile.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        imageViewProfile.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        imageViewProfile.widthAnchor.constraint(equalToConstant: imageViewProfile.layer.cornerRadius * 2).isActive = true
        imageViewProfile.heightAnchor.constraint(equalToConstant: imageViewProfile.layer.cornerRadius * 2).isActive = true
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelName.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        self.contentView.addSubview(labelName)
        
        labelName.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -4 * QUtils.optimizeRatio()).isActive = true
        labelName.leadingAnchor.constraint(equalTo: imageViewProfile.trailingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        
        labelAge.translatesAutoresizingMaskIntoConstraints = false
        labelAge.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelAge.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .thin)
        self.contentView.addSubview(labelAge)
        
        labelAge.bottomAnchor.constraint(equalTo: labelName.bottomAnchor).isActive = true
        labelAge.leadingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        
        labelRegion.translatesAutoresizingMaskIntoConstraints = false
        labelRegion.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelRegion.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .thin)
        self.contentView.addSubview(labelRegion)
        
        labelRegion.topAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 4 * QUtils.optimizeRatio()).isActive = true
        labelRegion.leadingAnchor.constraint(equalTo: labelName.leadingAnchor).isActive = true
        
        var seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        self.contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: labelRegion.topAnchor).isActive = true
        seperator.bottomAnchor.constraint(equalTo: labelRegion.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: labelRegion.trailingAnchor, constant: 7 * QUtils.optimizeRatio()).isActive = true
        seperator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        labelJob.translatesAutoresizingMaskIntoConstraints = false
        labelJob.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelJob.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .thin)
        self.contentView.addSubview(labelAge)
        
        labelJob.topAnchor.constraint(equalTo: labelRegion.topAnchor).isActive = true
        labelJob.leadingAnchor.constraint(equalTo: seperator.trailingAnchor, constant: 7 * QUtils.optimizeRatio()).isActive = true
        
        labelLastVisit.translatesAutoresizingMaskIntoConstraints = false
        labelLastVisit.textColor = #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        labelLastVisit.font = UIFont.systemFont(ofSize: 12 * QUtils.optimizeRatio(), weight: .thin)
        self.contentView.addSubview(labelLastVisit)
        
        labelLastVisit.bottomAnchor.constraint(equalTo: labelJob.bottomAnchor).isActive = true
        labelLastVisit.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        
        labelStatus.translatesAutoresizingMaskIntoConstraints = true
        labelStatus.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)
        self.contentView.addSubview(labelStatus)
        
        labelStatus.centerYAnchor.constraint(equalTo: labelName.centerYAnchor).isActive = true
        labelStatus.leadingAnchor.constraint(equalTo: labelLastVisit.leadingAnchor).isActive = true
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        self.contentView.addSubview(seperator)
        
        seperator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: imageViewProfile.leadingAnchor).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
