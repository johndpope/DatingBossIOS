//
//  SearchViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 21/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class SearchViewController: BaseMainViewController {
    private let theScrollView = UIScrollView()
    
    private let entryViewRegion = SearchPopupEntryView()
    
    override init(navigationViewEffect effect: UIVisualEffect? = nil) {
        super.init(navigationViewEffect: effect)
        
        showCherriesOnNavigation = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "검색"
        
        theScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(theScrollView)
        
        theScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        theScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        theScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        theScrollView.addSubview(contentView)
        
        contentView.widthAnchor.constraint(equalTo: theScrollView.widthAnchor).isActive = true
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "검색 조건을 설정해주세요."
        label.textColor = #colorLiteral(red: 0.168627451, green: 0.168627451, blue: 0.168627451, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        
        var bottomAnchor = label.bottomAnchor
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "*조건은 최소 3개에서 최대 7개까지 선택 가능합니다."
        label.textColor = #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12 * QUtils.optimizeRatio(), weight: .regular)
        label.numberOfLines = 0
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: bottomAnchor, constant: 11 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = label.bottomAnchor
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "*조건에 맞는 이성이 나타날 때 까지 검색은 무제한 가능합니다."
        label.textColor = #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12 * QUtils.optimizeRatio(), weight: .regular)
        label.numberOfLines = 0
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: bottomAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = label.bottomAnchor
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "*검색된 이성중에 매칭률이 가장 높은 한명의 이성을 소개합니다."
        label.textColor = #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12 * QUtils.optimizeRatio(), weight: .regular)
        label.numberOfLines = 0
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: bottomAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = label.bottomAnchor
        
        var seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
