//
//  AvoidKnownsNoDataViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class AvoidKnownsNoDataViewController: UIViewController {
    let buttonContacts = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentView)
        
        contentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "등록된 회원과 서로 추천되지 않습니다."
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18 * QUtils.optimizeRatio(), weight: .regular)
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        let bottomAnchor = label.bottomAnchor
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "※ 수집한 번호는 \'지인 만나지 않기\'기능 외에\n다른 용도로 쓰이지 않습니다."
        label.textColor = #colorLiteral(red: 0.6529199481, green: 0.2550097108, blue: 0.2336317599, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18 * QUtils.optimizeRatio(), weight: .regular)
        label.numberOfLines = 2
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: bottomAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        buttonContacts.translatesAutoresizingMaskIntoConstraints = false
        buttonContacts.clipsToBounds = true
        buttonContacts.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.6529199481, green: 0.2550097108, blue: 0.2336317599, alpha: 1)), for: .normal)
        buttonContacts.setTitle("연락처 불러오기", for: .normal)
        buttonContacts.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonContacts.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonContacts.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonContacts.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24 * QUtils.optimizeRatio(), bottom: 0, right: 24 * QUtils.optimizeRatio())
        buttonContacts.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        contentView.addSubview(buttonContacts)
        
        buttonContacts.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonContacts.heightAnchor.constraint(equalToConstant: buttonContacts.layer.cornerRadius * 2).isActive = true
        buttonContacts.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        buttonContacts.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
