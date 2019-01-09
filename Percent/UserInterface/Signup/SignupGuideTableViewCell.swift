//
//  SignupGuideTableViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 12/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class SignupGuideTableViewCell: UITableViewCell {
    private let labelStepCount = UILabel()
    
    private let labelTitle = UILabel()
    private let labelContent = UILabel()
    
    var indexPath: IndexPath? {
        didSet {
            guard indexPath != nil else { return }
            
            let row = indexPath!.row + 1
            labelStepCount.text = row < 10 ? "0\(row)" : "\(row)"
        }
    }
    
    var data: SignupGuideData? {
        didSet {
            labelTitle.text = data?.title
            labelContent.text = data?.content
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        let labelStep = UILabel()
        labelStep.translatesAutoresizingMaskIntoConstraints = false
        labelStep.text = "STEP"
        labelStep.textColor = #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        labelStep.textAlignment = .center
        labelStep.font = UIFont.systemFont(ofSize: 12 * QUtils.optimizeRatio(), weight: .bold)
        self.contentView.addSubview(labelStep)
        
        labelStep.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 14 * QUtils.optimizeRatio()).isActive = true
        labelStep.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        labelStep.widthAnchor.constraint(equalToConstant: 63 * QUtils.optimizeRatio()).isActive = true
        
        labelStepCount.translatesAutoresizingMaskIntoConstraints = false
        labelStepCount.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelStepCount.textAlignment = .center
        labelStepCount.font = UIFont.systemFont(ofSize: 20 * QUtils.optimizeRatio(), weight: .bold)
        self.contentView.addSubview(labelStepCount)
        
        labelStepCount.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -14 * QUtils.optimizeRatio()).isActive = true
        labelStepCount.leadingAnchor.constraint(equalTo: labelStep.leadingAnchor).isActive = true
        labelStepCount.widthAnchor.constraint(equalTo: labelStep.widthAnchor).isActive = true
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelTitle.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        self.contentView.addSubview(labelTitle)
        
        labelTitle.topAnchor.constraint(equalTo: labelStep.topAnchor).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: labelStep.trailingAnchor).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        
        labelContent.translatesAutoresizingMaskIntoConstraints = false
        labelContent.textColor = #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        labelContent.font = UIFont.systemFont(ofSize: 12 * QUtils.optimizeRatio(), weight: .bold)
        self.contentView.addSubview(labelContent)
        
        labelContent.bottomAnchor.constraint(equalTo: labelStepCount.bottomAnchor).isActive = true
        labelContent.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor).isActive = true
        labelContent.trailingAnchor.constraint(equalTo: labelTitle.trailingAnchor).isActive = true
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.contentView.addSubview(seperator)
        
        seperator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
