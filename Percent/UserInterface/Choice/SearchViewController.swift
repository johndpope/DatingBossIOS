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
    private let entryViewAge = SearchPopupRangeEntryView()
    private let entryViewHeight = SearchPopupRangeEntryView()
    private let entryViewShape = SearchPopupEntryView()
    private let entryViewBlood = SearchPopupEntryView()
    private let entryViewReligion = SearchPopupEntryView()
    private let entryViewHobby = SearchPopupEntryView()
    private let entryViewDrinking = SearchPopupEntryView()
    private let entryViewSmoking = SearchPopupEntryView()
    
    private let buttonInitialize = UIButton(type: .custom)
    private let buttonSearch = UIButton(type: .custom)
    
    private var filterData = [String:[AppData]]()
    
    private let parameter = SearchParameters()
    
    private var pickerData = [Any]()
    private weak var activatingEntryView: SearchEntryView?
    
    private weak var showingTableView: UITableView?
    
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
        label.text = "검색 조건을 설정하세요."
        label.textColor = #colorLiteral(red: 0.168627451, green: 0.168627451, blue: 0.168627451, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        
        var bottomAnchor = label.bottomAnchor
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "*조건에 맞는 이성이 있으면 체리가 차감됩니다."
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
        label.text = "*하루에 한 명의 이성 검색은 무료로 제공됩니다."
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
        label.text = "*조건은 최소 1개에서 최대 5개까지 선택 가능합니다."
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
        
        entryViewRegion.translatesAutoresizingMaskIntoConstraints = false
        entryViewRegion.delegate = self
        entryViewRegion.labelTitle.text = "지역"
        entryViewRegion.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        contentView.addSubview(entryViewRegion)
        
        entryViewRegion.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewRegion.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        entryViewRegion.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        entryViewRegion.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewRegion.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewAge.translatesAutoresizingMaskIntoConstraints = false
        entryViewAge.delegate = self
        entryViewAge.labelTitle.text = "나이"
        entryViewAge.button1.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        entryViewAge.button2.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        contentView.addSubview(entryViewAge)
        
        entryViewAge.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewAge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        entryViewAge.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        entryViewAge.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewAge.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewHeight.translatesAutoresizingMaskIntoConstraints = false
        entryViewHeight.delegate = self
        entryViewHeight.labelTitle.text = "키"
        entryViewHeight.button1.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        entryViewHeight.button2.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        contentView.addSubview(entryViewHeight)
        
        entryViewHeight.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewHeight.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        entryViewHeight.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        entryViewHeight.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewHeight.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewShape.translatesAutoresizingMaskIntoConstraints = false
        entryViewShape.delegate = self
        entryViewShape.labelTitle.text = "체형"
        entryViewShape.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        contentView.addSubview(entryViewShape)
        
        entryViewShape.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewShape.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        entryViewShape.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        entryViewShape.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewShape.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewBlood.translatesAutoresizingMaskIntoConstraints = false
        entryViewBlood.delegate = self
        entryViewBlood.labelTitle.text = "혈액형"
        entryViewBlood.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        contentView.addSubview(entryViewBlood)
        
        entryViewBlood.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewBlood.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        entryViewBlood.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        entryViewBlood.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewBlood.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewReligion.translatesAutoresizingMaskIntoConstraints = false
        entryViewReligion.delegate = self
        entryViewReligion.labelTitle.text = "종교"
        entryViewReligion.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        contentView.addSubview(entryViewReligion)
        
        entryViewReligion.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewReligion.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        entryViewReligion.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        entryViewReligion.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewReligion.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewHobby.translatesAutoresizingMaskIntoConstraints = false
        entryViewHobby.delegate = self
        entryViewHobby.labelTitle.text = "취미"
        entryViewHobby.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        contentView.addSubview(entryViewHobby)
        
        entryViewHobby.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewHobby.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        entryViewHobby.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        entryViewHobby.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewHobby.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewDrinking.translatesAutoresizingMaskIntoConstraints = false
        entryViewDrinking.delegate = self
        entryViewDrinking.labelTitle.text = "음주 스타일"
        entryViewDrinking.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        contentView.addSubview(entryViewDrinking)
        
        entryViewDrinking.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewDrinking.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        entryViewDrinking.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        entryViewDrinking.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewDrinking.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewSmoking.translatesAutoresizingMaskIntoConstraints = false
        entryViewSmoking.delegate = self
        entryViewSmoking.labelTitle.text = "흡연 여부"
        entryViewSmoking.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        contentView.addSubview(entryViewSmoking)
        
        entryViewSmoking.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewSmoking.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        entryViewSmoking.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        entryViewSmoking.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewSmoking.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        seperator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        
        buttonInitialize.translatesAutoresizingMaskIntoConstraints = false
        buttonInitialize.clipsToBounds = true
        buttonInitialize.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)), for: .normal)
        buttonInitialize.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), for: .highlighted)
        buttonInitialize.setTitle("초기화", for: .normal)
        buttonInitialize.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonInitialize.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonInitialize.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonInitialize.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonInitialize.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.view.addSubview(buttonInitialize)
        
        buttonInitialize.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -7 * QUtils.optimizeRatio()).isActive = true
        buttonInitialize.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonInitialize.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        buttonInitialize.heightAnchor.constraint(equalToConstant: buttonInitialize.layer.cornerRadius * 2).isActive = true
        
        buttonSearch.translatesAutoresizingMaskIntoConstraints = false
        buttonSearch.clipsToBounds = true
        buttonSearch.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .normal)
        buttonSearch.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1)), for: .highlighted)
        buttonSearch.setTitle("검색", for: .normal)
        buttonSearch.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonSearch.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonSearch.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonSearch.layer.cornerRadius = buttonInitialize.layer.cornerRadius
        buttonSearch.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.view.addSubview(buttonSearch)
        
        buttonSearch.topAnchor.constraint(equalTo: buttonInitialize.topAnchor).isActive = true
        buttonSearch.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        buttonSearch.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        buttonSearch.heightAnchor.constraint(equalTo: buttonInitialize.heightAnchor).isActive = true
        
        self.view.layoutIfNeeded()
        
        parameter.loadFromDatabase()
        updateSelectedValues()
        
        reloadSearchFilters()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var contentSize = theScrollView.contentSize
        contentSize.height = entryViewRegion.superview!.frame.size.height + buttonSearch.frame.size.height + 8 * QUtils.optimizeRatio()
        theScrollView.contentSize = contentSize
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        theScrollView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonInitialize:
            parameter.clear()
            updateSelectedValues()
            break
            
        case buttonSearch:
            guard parameter.hasCondition else {
                let alertController = AlertPopupViewController(withTitle: "안내", message: "최소 1개 이상의 조건을 설정해주세요.")
                alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
                alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
                alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "확인", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
                UIApplication.appDelegate().window?.addSubview(alertController.view)
                self.addChild(alertController)
                alertController.show()
                break
            }
            
            parameter.commit()
            
            let requesting = {(free: Bool) -> Void in
                LoadingIndicatorManager.shared.showIndicatorView()
                
                let httpClient = QHttpClient()
                httpClient.request(to: RequestUrl.Search + "\(MyData.shared.mem_idx)", params: self.parameter.params) { (isSucceed, errMessage, response) in
                    LoadingIndicatorManager.shared.hideIndicatorView()
                    guard isSucceed, let responseData = response as? [String:Any], let mem_idx = responseData["mem_idx"] as? Int else {
                        let alertController = AlertPopupViewController(withTitle: "검색 결과", message: "검색 조건에 맞는 회원이 없습니다.\n검색 조건을 변경해 보세요." + (free ? "" : "\n(체리 차감 안됨)"))
                        alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
                        alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
                        alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "확인", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
                        UIApplication.appDelegate().window?.addSubview(alertController.view)
                        self.addChild(alertController)
                        alertController.show()
                        return
                    }
                    
                    if let cherry_quantity = responseData["cherry_quantity"] as? Int {
                        MyData.shared.cherry_quantity = cherry_quantity
                        NotificationCenter.default.post(name: NotificationName.Cherry.Changed, object: cherry_quantity)
                    }
                    
                    let alertController = AlertPopupViewController(withTitle: "검색 결과", message: "조건에 맞는 회원을 찾았습니다." + (free ? " (무료)" : "\n체리 1개가 차감되었습니다."))
                    alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
                    alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
                    alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "확인", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
                    alertController.defaultAction = {() -> Void in
                        LoadingIndicatorManager.shared.showIndicatorView()
                        
                        let userData = UserData()
                        userData.mem_idx = mem_idx
                        userData.reloadData { (isSucceed) in
                            LoadingIndicatorManager.shared.hideIndicatorView()
                            
                            (UIApplication.appDelegate().window?.rootViewController as? MainViewController)?.favouriteViewController.needToReload = true
                            
                            let viewController = UserProfileViewController(data: userData)
                            viewController.searchParams = self.parameter
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }
                    }
                    UIApplication.appDelegate().window?.addSubview(alertController.view)
                    self.addChild(alertController)
                    alertController.show()
                }
            }
            
            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.Service.Free + "\(MyData.shared.mem_idx)", method: .get, headerValues: nil, params: nil) { (isSucceed, errMessage, response) in
                var titleString = "유료 검색"
                var message = "체리 1개를 사용하여 검색하시겠습니까?\n내가 가진 체리 \(MyData.shared.cherry_quantity)개"
                var isFree = false
                
                if let responseData = response as? [String:Any], (responseData["search"] as? Int ?? 0) > 0 {
                    titleString = "무료 검색"
                    message = "1일 1회 무료 검색을 사용합니다."
                    isFree = true
                }
                
                let alertController = AlertPopupViewController(withTitle: titleString, message: message)
                alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
                alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
                alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
                alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                    requesting(isFree)
                }))
                UIApplication.appDelegate().window?.addSubview(alertController.view)
                self.addChild(alertController)
                alertController.show()
            }
            break
            
        default:
            break
        }
    }
    
    @objc private func pressedEntryButton(_ sender: UIButton) {
        guard let entryView = sender.superview as? SearchEntryView else { return }
       
        if entryView == entryViewRegion {
            guard let dataArray = filterData["area"] else { return }
            
            pickerData.removeAll()
            pickerData.append(contentsOf: dataArray)
            
            let maximumRows = Int((UIScreen.main.bounds.size.height / SignupProfileSpecTableViewCell.height).rounded(.down) - 5)
            
            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: SignupProfileSpecTableViewCell.height * CGFloat(pickerData.count > maximumRows ? maximumRows : pickerData.count)))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(SignupProfileSpecTableViewCell.self, forCellReuseIdentifier: "SignupProfileSpecTableViewCell")
            showingTableView = tableView
            
            activatingEntryView = entryViewRegion
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewRegion.labelTitle.text, View: tableView)
            alertController.delegate = self
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewAge {pickerData.removeAll()
            var minimum: Int?, maximum: Int?
            let dataArray = filterData["search_age"] ?? []
            for i in 0 ..< dataArray.count {
                let item = dataArray[i]
                
                if item.code == "010" {
                    minimum = item.rawData["code_name"] as? Int
                } else if item.code == "020" {
                    maximum = item.rawData["code_name"] as? Int
                }
            }
            
            let minValue = minimum ?? 27
            let maxValue = maximum ?? 50
            
            for i in minValue ..< maxValue {
                pickerData.append("\(i)")
            }
            
            var value = sender == entryViewAge.button1 ? parameter.minAge : parameter.maxAge
            
            if value == nil {
                value = sender == entryViewAge.button1 ? minValue : maxValue - 1
            }
            
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: 260))
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            pickerView.selectRow(value! - minValue, inComponent: 0, animated: false)
            
            activatingEntryView = entryViewAge
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewAge.labelTitle.text, View: pickerView)
            alertController.delegate = self
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let value = pickerView.selectedRow(inComponent: 0) + minValue
                
                if sender == self.entryViewAge.button1 {
                    self.parameter.minAge = value
                } else {
                    self.parameter.maxAge = value
                }
                
                if let minAge = self.parameter.minAge, let maxAge = self.parameter.maxAge, maxAge < minAge {
                    self.parameter.minAge = maxAge
                    self.parameter.maxAge = minAge
                }
                self.updateSelectedValues()
            }))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewHeight {
            pickerData.removeAll()
            for i in 150 ..< 201 {
                pickerData.append("\(i)")
            }
            
            var value = sender == entryViewHeight.button1 ? parameter.minHeight : parameter.maxHeight
            
            if value == nil {
                value = 170
            }
            
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: 260))
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            pickerView.selectRow(value! - 150, inComponent: 0, animated: false)
            
            activatingEntryView = entryViewHeight
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewHeight.labelTitle.text, View: pickerView)
            alertController.delegate = self
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let value = pickerView.selectedRow(inComponent: 0) + 150
                
                if sender == self.entryViewHeight.button1 {
                    self.parameter.minHeight = value
                } else {
                    self.parameter.maxHeight = value
                }
                
                if let minHeight = self.parameter.minHeight, let maxHeight = self.parameter.maxHeight, maxHeight < minHeight {
                    self.parameter.minHeight = maxHeight
                    self.parameter.maxHeight = minHeight
                }
                self.updateSelectedValues()
            }))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewShape {
            let key = (MyData.shared.sex ?? .male) == .male ? "femaleform" : "maleform"
            
            guard let dataArray = filterData[key] else { return }
            
            pickerData.removeAll()
            pickerData.append(contentsOf: dataArray)
            
            let maximumRows = Int((UIScreen.main.bounds.size.height / SignupProfileSpecTableViewCell.height).rounded(.down) - 5)
            
            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: SignupProfileSpecTableViewCell.height * CGFloat(pickerData.count > maximumRows ? maximumRows : pickerData.count)))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(SignupProfileSpecTableViewCell.self, forCellReuseIdentifier: "SignupProfileSpecTableViewCell")
            showingTableView = tableView
            
            activatingEntryView = entryViewShape
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewBlood.labelTitle.text, View: tableView)
            alertController.delegate = self
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewBlood {
            pickerData.removeAll()
            pickerData.append("A")
            pickerData.append("B")
            pickerData.append("AB")
            pickerData.append("O")
            
            let maximumRows = Int((UIScreen.main.bounds.size.height / SignupProfileSpecTableViewCell.height).rounded(.down) - 5)
            
            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: SignupProfileSpecTableViewCell.height * CGFloat(pickerData.count > maximumRows ? maximumRows : pickerData.count)))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(SignupProfileSpecTableViewCell.self, forCellReuseIdentifier: "SignupProfileSpecTableViewCell")
            showingTableView = tableView
            
            activatingEntryView = entryViewBlood
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewBlood.labelTitle.text, View: tableView)
            alertController.delegate = self
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewReligion {
            guard let dataArray = filterData["religion"] else { return }
            
            pickerData.removeAll()
            pickerData.append(contentsOf: dataArray)
            
            let maximumRows = Int((UIScreen.main.bounds.size.height / SignupProfileSpecTableViewCell.height).rounded(.down) - 5)
            
            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: SignupProfileSpecTableViewCell.height * CGFloat(pickerData.count > maximumRows ? maximumRows : pickerData.count)))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(SignupProfileSpecTableViewCell.self, forCellReuseIdentifier: "SignupProfileSpecTableViewCell")
            showingTableView = tableView
            
            activatingEntryView = entryViewReligion
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewReligion.labelTitle.text, View: tableView)
            alertController.delegate = self
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewHobby {
            guard let dataArray = filterData["hobby"] else { return }
            
            pickerData.removeAll()
            pickerData.append(contentsOf: dataArray)
            
            let maximumRows = Int((UIScreen.main.bounds.size.height / SignupProfileSpecTableViewCell.height).rounded(.down) - 5)
            
            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: SignupProfileSpecTableViewCell.height * CGFloat(pickerData.count > maximumRows ? maximumRows : pickerData.count)))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(SignupProfileSpecTableViewCell.self, forCellReuseIdentifier: "SignupProfileSpecTableViewCell")
            showingTableView = tableView
            
            activatingEntryView = entryViewHobby
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewHobby.labelTitle.text, View: tableView)
            alertController.delegate = self
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewDrinking {
            guard let dataArray = filterData["drinking"] else { return }
            
            pickerData.removeAll()
            pickerData.append(contentsOf: dataArray)
            
            let maximumRows = Int((UIScreen.main.bounds.size.height / SignupProfileSpecTableViewCell.height).rounded(.down) - 5)
            
            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: SignupProfileSpecTableViewCell.height * CGFloat(pickerData.count > maximumRows ? maximumRows : pickerData.count)))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(SignupProfileSpecTableViewCell.self, forCellReuseIdentifier: "SignupProfileSpecTableViewCell")
            showingTableView = tableView
            
            activatingEntryView = entryViewDrinking
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewDrinking.labelTitle.text, View: tableView)
            alertController.delegate = self
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewSmoking {
            guard let dataArray = filterData["smoking"] else { return }
            
            pickerData.removeAll()
            pickerData.append(contentsOf: dataArray)
            
            let maximumRows = Int((UIScreen.main.bounds.size.height / SignupProfileSpecTableViewCell.height).rounded(.down) - 5)
            
            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: SignupProfileSpecTableViewCell.height * CGFloat(pickerData.count > maximumRows ? maximumRows : pickerData.count)))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(SignupProfileSpecTableViewCell.self, forCellReuseIdentifier: "SignupProfileSpecTableViewCell")
            showingTableView = tableView
            
            activatingEntryView = entryViewSmoking
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewSmoking.labelTitle.text, View: tableView)
            alertController.delegate = self
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        }
    }
    
    private func reloadSearchFilters() {
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Search + "\(MyData.shared.mem_idx)", method: .get, headerValues: nil, params: nil) { (isSucceed, errMessage, response) in
            guard let responseData = response as? [[String:Any]] else { return }
            
            self.filterData.removeAll()
            
            for item in responseData {
                let newItem = AppData(with: item)
                guard let code_type = newItem.code_type else { continue }
                
                var dataArray = self.filterData[code_type] ?? []
                dataArray.append(newItem)
                self.filterData[code_type] = dataArray
            }
        }
    }
    
    private func updateSelectedValues() {
        entryViewRegion.value = parameter.region?.code_name
        entryViewAge.value1 = parameter.minAge != nil ? "\(parameter.minAge!)" : nil
        entryViewAge.value2 = parameter.maxAge != nil ? "\(parameter.maxAge!)" : nil
        entryViewHeight.value1 = parameter.minHeight != nil ? "\(parameter.minHeight!)" : nil
        entryViewHeight.value2 = parameter.maxHeight != nil ? "\(parameter.maxHeight!)" : nil
        entryViewShape.value = parameter.shape?.code_name
        entryViewBlood.value = parameter.blood?.rawValue.uppercased()
        entryViewReligion.value = parameter.religion?.code_name
        entryViewHobby.value = parameter.hobby?.code_name
        entryViewDrinking.value = parameter.drinking?.code_name
        entryViewSmoking.value = parameter.smoking?.code_name
    }
}

extension SearchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let string = pickerData[row] as? String {
            return string
        } else if let data = pickerData[row] as? AppData {
            return data.code_name
        }
        
        return nil
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = pickerData[indexPath.row]
        
        if activatingEntryView == entryViewRegion {
            parameter.region = value as? AppData
        } else if activatingEntryView == entryViewShape {
            parameter.shape = value as? AppData
        } else if activatingEntryView == entryViewBlood {
            parameter.blood = BloodType(rawValue: (value as? String ?? "").lowercased())
        } else if activatingEntryView == entryViewReligion {
            parameter.religion = value as? AppData
        } else if activatingEntryView == entryViewHobby {
            parameter.hobby = value as? AppData
        } else if activatingEntryView == entryViewDrinking {
            parameter.drinking = value as? AppData
        } else if activatingEntryView == entryViewSmoking {
            parameter.smoking = value as? AppData
        }

        for subVC in self.children {
            guard let alertController = subVC as? BasePopupViewController else { continue }
            alertController.hide()
        }

        updateSelectedValues()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickerData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SignupProfileSpecTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SignupProfileSpecTableViewCell") as? SignupProfileSpecTableViewCell else { return UITableViewCell() }
        
        let candidate = pickerData[indexPath.row]
        
        if let data = candidate as? AppData {
            cell.labelTitle.text = data.code_name
        } else if let titleString = candidate as? String {
            cell.labelTitle.text = titleString
        } else {
            cell.labelTitle.text = nil
        }
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        
        cell.isSelectedCell = false
        
        return cell
    }
}

extension SearchViewController: BasePopupViewControllerDelegate {
    func popupViewController(dismissed viewController: BasePopupViewController) {
        activatingEntryView = nil
        showingTableView = nil
        
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}

extension SearchViewController: SearchEntryViewDelegate {
    func searchEntryView(didClearValue entryView: SearchEntryView) {
        switch entryView {
        case entryViewRegion:
            parameter.region = nil
            break
            
        case entryViewAge:
            parameter.minAge = nil
            parameter.maxAge = nil
            break
            
        case entryViewHeight:
            parameter.minHeight = nil
            parameter.maxHeight = nil
            break
            
        case entryViewShape:
            parameter.shape = nil
            break
        case entryViewBlood:
            parameter.blood = nil
            break
            
        case entryViewReligion:
            parameter.religion = nil
            break
            
        case entryViewHobby:
            parameter.hobby = nil
            break
            
        case entryViewDrinking:
            parameter.drinking = nil
            break
            
        case entryViewSmoking:
            parameter.smoking = nil
            break
            
        default:
            break
        }
    }
}
