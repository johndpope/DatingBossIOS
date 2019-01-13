//
//  SignupProfileSpecsViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 17/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

import AVFoundation
import Photos

class SignupProfileSpecsViewController: BaseSignupStepsViewController {
    private let theScrollView = UIScrollView()
    
    private let collectionViewPictures: UICollectionView!
    private var replaceIndex: Int?
    
    private let entryViewHeight = SignupProfilePopupEntryView()
    private let entryViewShape = SignupProfilePopupEntryView()
    private let entryViewBlood = SignupProfilePopupEntryView()
    private let entryViewRegion = SignupProfilePopupEntryView()
    private let entryViewEducation = SignupProfilePopupEntryView()
    private let entryViewEducationDetail = SignupProfileTextEntryView()
    private let entryViewJob = SignupProfilePopupEntryView()
    private let entryViewWage = SignupProfilePopupEntryView()
    private let entryViewReligion = SignupProfilePopupEntryView()
    private let entryViewHobby = SignupProfilePopupEntryView()
    private let entryViewDrinking = SignupProfilePopupEntryView()
    private let entryViewSmoking = SignupProfilePopupEntryView()
    
    private let buttonTextView = UIButton(type: .custom)
    private let textViewComment = UITextView()
    private var constraintTextViewHeight: NSLayoutConstraint!
    
    private let buttonCancel = UIButton(type: .custom)
    private let buttonConfirm = UIButton(type: .custom)
    
    private var pickerData = [Any]()
    
    private var selectedEntryView: SignupProfileEntryView?
    private var editingView: UIView?
    
    override init(navigationViewEffect effect: UIVisualEffect? = nil) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = SignupProfilePictureCollectionViewCell.sectionInset
        flowLayout.minimumLineSpacing = SignupProfilePictureCollectionViewCell.minimumLineSpacing
        flowLayout.minimumInteritemSpacing = SignupProfilePictureCollectionViewCell.minimumInteritemSpacing
        flowLayout.itemSize = SignupProfilePictureCollectionViewCell.itemSize
        flowLayout.scrollDirection = .horizontal
        collectionViewPictures = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        
        super.init(navigationViewEffect: effect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = "프로필 작성"
        
        theScrollView.translatesAutoresizingMaskIntoConstraints = false
        theScrollView.clipsToBounds = true
        theScrollView.delegate = self
        self.view.addSubview(theScrollView)
        
        theScrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        theScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        theScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.view.bringSubviewToFront(headerView)
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "※ 작성 후 변경은 한달 후에 가능하니 신중히 작성해주세요."
        label.textColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        label.numberOfLines = 0
        theScrollView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: theScrollView.topAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        
        var bottomAnchor = label.bottomAnchor
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "※ 허위로 작성시 이용에 불이익을 받을 수 있습니다."
        label.textColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        label.numberOfLines = 0
        theScrollView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: bottomAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = label.bottomAnchor
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "※ 사진은 최소 3장(필수) 최대 5장"
        label.textColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        label.numberOfLines = 0
        theScrollView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: bottomAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = label.bottomAnchor
        
        collectionViewPictures.translatesAutoresizingMaskIntoConstraints = false
        collectionViewPictures.backgroundColor = self.view.backgroundColor
        collectionViewPictures.delegate = self
        collectionViewPictures.dataSource = self
        collectionViewPictures.showsHorizontalScrollIndicator = false
        collectionViewPictures.register(SignupProfilePictureCollectionViewCell.self, forCellWithReuseIdentifier: "SignupProfilePictureCollectionViewCell")
        theScrollView.addSubview(collectionViewPictures)
        
        collectionViewPictures.topAnchor.constraint(equalTo: bottomAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        collectionViewPictures.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionViewPictures.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionViewPictures.heightAnchor.constraint(equalToConstant: SignupProfilePictureCollectionViewCell.itemSize.height).isActive = true
        
        entryViewHeight.translatesAutoresizingMaskIntoConstraints = false
        entryViewHeight.labelTitle.text = "키"
        entryViewHeight.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        theScrollView.addSubview(entryViewHeight)
        
        entryViewHeight.topAnchor.constraint(equalTo: collectionViewPictures.bottomAnchor).isActive = true
        entryViewHeight.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        entryViewHeight.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        entryViewHeight.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewHeight.bottomAnchor
        
        var seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewShape.translatesAutoresizingMaskIntoConstraints = false
        entryViewShape.labelTitle.text = "체형"
        entryViewShape.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        theScrollView.addSubview(entryViewShape)
        
        entryViewShape.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewShape.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        entryViewShape.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        entryViewShape.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewShape.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        theScrollView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewBlood.translatesAutoresizingMaskIntoConstraints = false
        entryViewBlood.labelTitle.text = "혈액형"
        entryViewBlood.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        theScrollView.addSubview(entryViewBlood)
        
        entryViewBlood.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewBlood.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        entryViewBlood.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        entryViewBlood.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewBlood.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        theScrollView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewRegion.translatesAutoresizingMaskIntoConstraints = false
        entryViewRegion.labelTitle.text = "지역"
        entryViewRegion.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        theScrollView.addSubview(entryViewRegion)
        
        entryViewRegion.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewRegion.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        entryViewRegion.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        entryViewRegion.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewRegion.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        theScrollView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewEducation.translatesAutoresizingMaskIntoConstraints = false
        entryViewEducation.labelTitle.text = "학력"
        entryViewEducation.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        theScrollView.addSubview(entryViewEducation)
        
        entryViewEducation.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewEducation.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        entryViewEducation.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        entryViewEducation.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewEducation.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        theScrollView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewEducationDetail.translatesAutoresizingMaskIntoConstraints = false
        entryViewEducationDetail.hideCheckIndicator = true
        entryViewEducationDetail.labelTitle.text = "학교(선택)"
        entryViewEducationDetail.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        entryViewEducationDetail.textfield.returnKeyType = .done
        entryViewEducationDetail.textfield.addTarget(self, action: #selector(self.textfieldDidChange(_:)), for: .editingChanged)
        entryViewEducationDetail.textfield.autocorrectionType = .no
        entryViewEducationDetail.textfield.delegate = self
        theScrollView.addSubview(entryViewEducationDetail)
        
        entryViewEducationDetail.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewEducationDetail.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        entryViewEducationDetail.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        entryViewEducationDetail.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewEducationDetail.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        theScrollView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true

        entryViewJob.translatesAutoresizingMaskIntoConstraints = false
        entryViewJob.labelTitle.text = "직업"
        entryViewJob.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        theScrollView.addSubview(entryViewJob)

        entryViewJob.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewJob.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        entryViewJob.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        entryViewJob.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true

        bottomAnchor = entryViewJob.bottomAnchor

        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        theScrollView.addSubview(seperator)

        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true

        entryViewWage.translatesAutoresizingMaskIntoConstraints = false
        entryViewWage.labelTitle.text = "연봉"
        entryViewWage.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        theScrollView.addSubview(entryViewWage)

        entryViewWage.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewWage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        entryViewWage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        entryViewWage.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true

        bottomAnchor = entryViewWage.bottomAnchor

        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        theScrollView.addSubview(seperator)

        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true

        entryViewReligion.translatesAutoresizingMaskIntoConstraints = false
        entryViewReligion.labelTitle.text = "종교"
        entryViewReligion.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        theScrollView.addSubview(entryViewReligion)

        entryViewReligion.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewReligion.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        entryViewReligion.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        entryViewReligion.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true

        bottomAnchor = entryViewReligion.bottomAnchor

        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        theScrollView.addSubview(seperator)

        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true

        entryViewHobby.translatesAutoresizingMaskIntoConstraints = false
        entryViewHobby.labelTitle.text = "취미"
        entryViewHobby.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        theScrollView.addSubview(entryViewHobby)

        entryViewHobby.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewHobby.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        entryViewHobby.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        entryViewHobby.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true

        bottomAnchor = entryViewHobby.bottomAnchor

        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        theScrollView.addSubview(seperator)

        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true

        entryViewDrinking.translatesAutoresizingMaskIntoConstraints = false
        entryViewDrinking.labelTitle.text = "음주 스타일"
        entryViewDrinking.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        theScrollView.addSubview(entryViewDrinking)

        entryViewDrinking.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewDrinking.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        entryViewDrinking.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        entryViewDrinking.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true

        bottomAnchor = entryViewDrinking.bottomAnchor

        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        theScrollView.addSubview(seperator)

        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true

        entryViewSmoking.translatesAutoresizingMaskIntoConstraints = false
        entryViewSmoking.labelTitle.text = "흡연여부"
        entryViewSmoking.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        theScrollView.addSubview(entryViewSmoking)

        entryViewSmoking.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewSmoking.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        entryViewSmoking.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        entryViewSmoking.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true

        bottomAnchor = entryViewSmoking.bottomAnchor

        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        theScrollView.addSubview(seperator)

        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true

        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "하고 싶은 말"
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)
        theScrollView.addSubview(label)

        label.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true

        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.layer.borderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        backView.layer.borderWidth = 1
        theScrollView.addSubview(backView)

        backView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        backView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        backView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true

        buttonTextView.translatesAutoresizingMaskIntoConstraints = false
        buttonTextView.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        backView.addSubview(buttonTextView)
        
        buttonTextView.topAnchor.constraint(equalTo: backView.topAnchor).isActive = true
        buttonTextView.bottomAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        buttonTextView.leadingAnchor.constraint(equalTo: backView.leadingAnchor).isActive = true
        buttonTextView.trailingAnchor.constraint(equalTo: backView.trailingAnchor).isActive = true
        
        textViewComment.translatesAutoresizingMaskIntoConstraints = false
        textViewComment.isUserInteractionEnabled = false
        textViewComment.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        textViewComment.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        textViewComment.delegate = self
        textViewComment.isEditable = true
        backView.addSubview(textViewComment)

        textViewComment.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        textViewComment.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        textViewComment.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        constraintTextViewHeight = textViewComment.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio())
        constraintTextViewHeight.isActive = true
        textViewComment.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true

        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.clipsToBounds = true
        buttonCancel.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)), for: .normal)
        buttonCancel.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), for: .highlighted)
        buttonCancel.setTitle("취소", for: .normal)
        buttonCancel.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonCancel.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonCancel.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonCancel.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonCancel.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        theScrollView.addSubview(buttonCancel)

        buttonCancel.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: 32 * QUtils.optimizeRatio()).isActive = true
        buttonCancel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonCancel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        buttonCancel.heightAnchor.constraint(equalToConstant: buttonCancel.layer.cornerRadius * 2).isActive = true

        buttonConfirm.translatesAutoresizingMaskIntoConstraints = false
        buttonConfirm.clipsToBounds = true
        buttonConfirm.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .normal)
        buttonConfirm.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1)), for: .highlighted)
        buttonConfirm.setTitle("시작", for: .normal)
        buttonConfirm.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonConfirm.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonConfirm.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonConfirm.layer.cornerRadius = buttonCancel.layer.cornerRadius
        buttonConfirm.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        theScrollView.addSubview(buttonConfirm)

        buttonConfirm.topAnchor.constraint(equalTo: buttonCancel.topAnchor).isActive = true
        buttonConfirm.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        buttonConfirm.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        buttonConfirm.heightAnchor.constraint(equalTo: buttonCancel.heightAnchor).isActive = true
        
        self.theScrollView.layoutIfNeeded()
        
        AppDataManager.shared.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        _ = textViewComment.resignFirstResponder()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadContentSize()
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        _ = textViewComment.resignFirstResponder()
        _ = entryViewEducationDetail.textfield.resignFirstResponder()
        
        switch sender {
        case buttonTextView:
            editingView = textViewComment.superview
            _ = textViewComment.becomeFirstResponder()
            break
            
        case buttonConfirm:
            let viewController = SignupStepViewController(step: 2)
            viewController.delegate = self
            self.present(viewController, animated: true, completion: nil)
            break
            
        case buttonCancel:
            let alertController = AlertPopupViewController(withTitle: "회원가입 중단", message: "회원가입을 중단하시겠습니까?")
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "아니오", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "예", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                exit(0)
            }))
            self.view.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
            break
            
        default: break
        }
    }
    
    @objc private func pressedEntryButton(_ sender: UIButton) {
        _ = textViewComment.resignFirstResponder()
        _ = entryViewEducationDetail.textfield.resignFirstResponder()
        
        guard let entryView = sender.superview as? SignupProfileEntryView else { return }
        
        if entryView == entryViewHeight {
            pickerData.removeAll()
            for i in 150 ..< 201 {
                pickerData.append("\(i)")
            }
            
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: 260))
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            pickerView.selectRow((UserPayload.shared.height ?? 170) - 150, inComponent: 0, animated: false)
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewHeight.labelTitle.text, View: pickerView)
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let value = pickerView.selectedRow(inComponent: 0) + 150
                UserPayload.shared.height = value
                
                self.entryViewHeight.checked = true
                self.entryViewHeight.labelValue.text = "\(value) cm"
            }))
            self.view.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewShape {
            let key = UserPayload.shared.gender == .male ? "maleform" : "femaleform"
            
            guard let dataArray = AppDataManager.shared.data[key] else { return }
            
            var selectedRow = dataArray.count / 2
            
            pickerData.removeAll()
            for i in 0 ..< dataArray.count {
                let item = dataArray[i]
                if let code = item.code, code == UserPayload.shared.shape?.code {
                    selectedRow = i
                }
                pickerData.append(item.code_name ?? "")
            }
            
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: 260))
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewShape.labelTitle.text, View: pickerView)
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let value = dataArray[pickerView.selectedRow(inComponent: 0)]
                UserPayload.shared.shape = value
                
                self.entryViewShape.checked = true
                self.entryViewShape.labelValue.text = value.code_name
            }))
            self.view.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewBlood {
            let dataArray = ["A", "B", "AB", "O"]
            var selectedRow = 0
            
            pickerData.removeAll()
            for i in 0 ..< dataArray.count {
                let item = dataArray[i]
                if item == UserPayload.shared.blood ?? "" {
                    selectedRow = i
                }
                pickerData.append(item)
            }
            
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: 260))
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewBlood.labelTitle.text, View: pickerView)
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let value = dataArray[pickerView.selectedRow(inComponent: 0)]
                UserPayload.shared.blood = value
                
                self.entryViewBlood.checked = true
                self.entryViewBlood.labelValue.text = value
            }))
            self.view.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewRegion {
            guard let dataArray = AppDataManager.shared.data["area"] else { return }
            
            var selectedRow = 0
            
            pickerData.removeAll()
            for i in 0 ..< dataArray.count {
                let item = dataArray[i]
                if let code = item.code, code == UserPayload.shared.region?.code {
                    selectedRow = i
                }
                pickerData.append(item.code_name ?? "")
            }
            
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: 260))
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewRegion.labelTitle.text, View: pickerView)
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let value = dataArray[pickerView.selectedRow(inComponent: 0)]
                UserPayload.shared.region = value
                
                self.entryViewRegion.checked = true
                self.entryViewRegion.labelValue.text = value.code_name
            }))
            self.view.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewEducation {
            guard let dataArray = AppDataManager.shared.data["edu"] else { return }
            
            var selectedRow = 0
            
            pickerData.removeAll()
            for i in 0 ..< dataArray.count {
                let item = dataArray[i]
                if let code = item.code, code == UserPayload.shared.education?.code {
                    selectedRow = i
                }
                pickerData.append(item.code_name ?? "")
            }
            
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: 260))
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewEducation.labelTitle.text, View: pickerView)
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let value = dataArray[pickerView.selectedRow(inComponent: 0)]
                UserPayload.shared.education = value
                
                self.entryViewEducation.checked = true
                self.entryViewEducation.labelValue.text = value.code_name
            }))
            self.view.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewEducationDetail {
            editingView = entryViewEducationDetail
            _ = entryViewEducationDetail.textfield.becomeFirstResponder()
        } else if entryView == entryViewJob {
            guard let dataArray = AppDataManager.shared.data["job"] else { return }
            
            var selectedRow = 0
            
            pickerData.removeAll()
            for i in 0 ..< dataArray.count {
                let item = dataArray[i]
                if let code = item.code, code == UserPayload.shared.job?.code {
                    selectedRow = i
                }
                pickerData.append(item.code_name ?? "")
            }
            
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: 260))
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewJob.labelTitle.text, View: pickerView)
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let value = dataArray[pickerView.selectedRow(inComponent: 0)]
                UserPayload.shared.job = value
                
                self.entryViewJob.checked = true
                self.entryViewJob.labelValue.text = value.code_name
            }))
            self.view.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewWage {
            guard let dataArray = AppDataManager.shared.data["income"] else { return }
            
            var selectedRow = 0
            
            pickerData.removeAll()
            for i in 0 ..< dataArray.count {
                let item = dataArray[i]
                if let code = item.code, code == UserPayload.shared.wage?.code {
                    selectedRow = i
                }
                pickerData.append(item.code_name ?? "")
            }
            
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: 260))
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewWage.labelTitle.text, View: pickerView)
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let value = dataArray[pickerView.selectedRow(inComponent: 0)]
                UserPayload.shared.wage = value
                
                self.entryViewWage.checked = true
                self.entryViewWage.labelValue.text = value.code_name
            }))
            self.view.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewReligion {
            guard let dataArray = AppDataManager.shared.data["religion"] else { return }
            
            var selectedRow = 0
            
            pickerData.removeAll()
            for i in 0 ..< dataArray.count {
                let item = dataArray[i]
                if let code = item.code, code == UserPayload.shared.religion?.code {
                    selectedRow = i
                }
                pickerData.append(item.code_name ?? "")
            }
            
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: 260))
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewReligion.labelTitle.text, View: pickerView)
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let value = dataArray[pickerView.selectedRow(inComponent: 0)]
                UserPayload.shared.religion = value
                
                self.entryViewReligion.checked = true
                self.entryViewReligion.labelValue.text = value.code_name
            }))
            self.view.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewHobby {
            guard let dataArray = AppDataManager.shared.data["hobby"] else { return }
            
            pickerData.removeAll()
            pickerData.append(contentsOf: dataArray)
            
            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: SignupProfileSpecTableViewCell.height * 7))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(SignupProfileSpecTableViewCell.self, forCellReuseIdentifier: "SignupProfileSpecTableViewCell")
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewHobby.labelTitle.text, View: tableView)
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            self.view.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewDrinking {
            guard let dataArray = AppDataManager.shared.data["drinking"] else { return }
            
            var selectedRow = 0
            
            pickerData.removeAll()
            for i in 0 ..< dataArray.count {
                let item = dataArray[i]
                if let code = item.code, code == UserPayload.shared.drinking?.code {
                    selectedRow = i
                }
                pickerData.append(item.code_name ?? "")
            }
            
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: 260))
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewDrinking.labelTitle.text, View: pickerView)
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let value = dataArray[pickerView.selectedRow(inComponent: 0)]
                UserPayload.shared.drinking = value
                
                self.entryViewDrinking.checked = true
                self.entryViewDrinking.labelValue.text = value.code_name
            }))
            self.view.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewSmoking {
            guard let dataArray = AppDataManager.shared.data["smoking"] else { return }
            
            var selectedRow = 0
            
            pickerData.removeAll()
            for i in 0 ..< dataArray.count {
                let item = dataArray[i]
                if let code = item.code, code == UserPayload.shared.smoking?.code {
                    selectedRow = i
                }
                pickerData.append(item.code_name ?? "")
            }
            
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: 260))
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewSmoking.labelTitle.text, View: pickerView)
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let value = dataArray[pickerView.selectedRow(inComponent: 0)]
                UserPayload.shared.smoking = value
                
                self.entryViewSmoking.checked = true
                self.entryViewSmoking.labelValue.text = value.code_name
            }))
            self.view.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        }
    }
    
    private func reloadContentSize() {
        var contentSize = theScrollView.contentSize
        contentSize.width = self.view.frame.size.width
        contentSize.height = buttonConfirm.frame.maxY + 7 * QUtils.optimizeRatio()
        theScrollView.contentSize = contentSize
    }
    
    @objc private func keyboardShown(notification: NSNotification) {
        guard editingView != nil else { return }
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        var contentSize = theScrollView.contentSize
        contentSize.height = buttonConfirm.frame.maxY + keyboardFrame.size.height + 7 * QUtils.optimizeRatio()
        theScrollView.contentSize = contentSize
        
        var contentOffset = theScrollView.contentOffset
        contentOffset.y = editingView!.frame.maxY - theScrollView.frame.size.height + keyboardFrame.size.height
        theScrollView.setContentOffset(contentOffset, animated: true)
    }

    @objc private func keyboardHidden(notification: NSNotification) {
        var contentSize = theScrollView.contentSize
        contentSize.height = buttonConfirm.frame.maxY + 7 * QUtils.optimizeRatio()
        theScrollView.contentSize = contentSize
        
        var contentOffset = theScrollView.contentOffset
        contentOffset.y = theScrollView.contentSize.height - theScrollView.frame.size.height
        theScrollView.setContentOffset(contentOffset, animated: true)
    }
    
    @objc private func textfieldDidChange(_ textfield: UITextField) {
        if (textfield.superview as? SignupProfileTextEntryView) == entryViewEducationDetail {
            UserPayload.shared.educationDetail = textfield.text
        }
    }
}

extension SignupProfileSpecsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = textViewComment.resignFirstResponder()
        
        if indexPath.row < UserPayload.shared.pictures.count {
            replaceIndex = indexPath.row
        }
        
        let accessableCamera = AVCaptureDevice.authorizationStatus(for: .video)
        let accessablePhoto = PHPhotoLibrary.authorizationStatus()
        
        guard accessableCamera == .authorized || accessablePhoto == .authorized else {
            let alertController = AlertPopupViewController(withTitle: "접근권한이 없습니다.", message: "카메라, 사진 접근 권한이 없습니다.\n설정으로 이동하여 접근권한 설정을\n변경하여 주세요.")
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "설정", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    })
                }
            }))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
            return
        }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if accessableCamera == .authorized {
            alertController.addAction(UIAlertAction(title: "카메라로 촬영하기", style: .default, handler: { (action) in
                let pickerController = UIImagePickerController()
                pickerController.delegate = self
                pickerController.sourceType = .camera
                pickerController.allowsEditing = true
                pickerController.cameraCaptureMode = .photo
                pickerController.cameraDevice = .rear
                pickerController.showsCameraControls = true
                self.present(pickerController, animated: true, completion: nil)
            }))
        }
        if accessablePhoto == .authorized {
            alertController.addAction(UIAlertAction(title: "사진에서 가져오기", style: .default, handler: { (action) in
                let pickerController = UIImagePickerController()
                pickerController.delegate = self
                pickerController.allowsEditing = true
                pickerController.sourceType = .photoLibrary
                self.present(pickerController, animated: true, completion: nil)
            }))
        }
        if replaceIndex != nil {
            alertController.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { (action) in
                UserPayload.shared.pictures.remove(at: self.replaceIndex!)
                self.collectionViewPictures.reloadData()
            }))
        }
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignupProfilePictureCollectionViewCell", for: indexPath) as? SignupProfilePictureCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.row < UserPayload.shared.pictures.count {
            cell.image = UserPayload.shared.pictures[indexPath.row]
        } else {
            cell.image = nil
        }
        return cell
    }
}

extension SignupProfileSpecsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        replaceIndex = nil
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            replaceIndex = nil
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        LoadingIndicatorManager.shared.showIndicatorView()
        
        let index = replaceIndex ?? UserPayload.shared.pictures.count
        
        var params = [String:Any]()
        params["picture"] = image.pngData()
        params["tmp_fl"] = "y"
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Image.Info + "\(MyData.shared.mem_idx)/\(index + 1)/y", params: params) { (isSucceed, errMessage, response) in
            LoadingIndicatorManager.shared.hideIndicatorView()
            
        }
        
        if replaceIndex != nil, replaceIndex! < UserPayload.shared.pictures.count {
            UserPayload.shared.pictures[replaceIndex!] = image
        } else {
            UserPayload.shared.pictures.append(image)
        }
        
        collectionViewPictures.reloadData()
        
        replaceIndex = nil
        picker.dismiss(animated: true, completion: nil)
    }
}

extension SignupProfileSpecsViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _ = textViewComment.resignFirstResponder()
        _ = entryViewEducationDetail.textfield.resignFirstResponder()
    }
}

extension SignupProfileSpecsViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let originHeight = constraintTextViewHeight.constant
        
        let textview = UITextView(frame: textViewComment.frame)
        textview.font = textViewComment.font
        textview.textContainerInset = textViewComment.textContainerInset
        textview.text = textViewComment.text
        textview.sizeToFit()
        
        var height = textview.frame.size.height
        if textview.frame.size.height < 56 * QUtils.optimizeRatio() {
            height = 56 * QUtils.optimizeRatio()
        }
        
        textViewComment.removeConstraint(constraintTextViewHeight)
        constraintTextViewHeight = textViewComment.heightAnchor.constraint(equalToConstant: height)
        constraintTextViewHeight.isActive = true

        theScrollView.layoutIfNeeded()
        
        let diff = height - originHeight
        
        if diff != 0 {
            var contentOffset = theScrollView.contentOffset
            contentOffset.y += diff
            theScrollView.setContentOffset(contentOffset, animated: false)
        }
    }
}

extension SignupProfileSpecsViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        editingView = textField.superview
        return true
    }
}

extension SignupProfileSpecsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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

extension SignupProfileSpecsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = pickerData[indexPath.row] as? AppData, let code = data.code else { return }
        
        let dataArray = UserPayload.shared.hobby.map { (item) -> String in
            return item.code ?? "-1"
        }
        
        if let index = dataArray.firstIndex(of: code) {
            UserPayload.shared.hobby.remove(at: index)
        } else if UserPayload.shared.hobby.count > 2 {
            let alertController = UIAlertController(title: "", message: "더 선택할 수 없습니다.", preferredStyle: .alert)
            self.present(alertController, animated: true) {
                _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (timer) in
                    timer.invalidate()
                    alertController.dismiss(animated: true, completion: nil)
                })
            }
            return
        } else {
            UserPayload.shared.hobby.append(data)
        }
        
        var text = ""
        for i in 0 ..< UserPayload.shared.hobby.count {
            guard let item = UserPayload.shared.hobby[i].code_name else { continue }
            
            if text.count > 0 {
                text += ", "
            }
            
            text += item
        }
        
        entryViewHobby.labelValue.text = text
        entryViewHobby.checked = text.count > 0
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickerData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SignupProfileSpecTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SignupProfileSpecTableViewCell") as? SignupProfileSpecTableViewCell else { return UITableViewCell() }
        cell.data = pickerData[indexPath.row] as? AppData
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        
        if let code = cell.data?.code {
            let dataArray = UserPayload.shared.hobby.map { (item) -> String in
                return item.code ?? "-1"
            }
            
            cell.isSelectedCell = dataArray.firstIndex(of: code) != nil
        } else {
            cell.isSelectedCell = false
        }
        
        return cell
    }
}

extension SignupProfileSpecsViewController: SignupStepViewControllerDelegate {
    func signupStepViewController(doneProgress viewController: SignupStepViewController) {
        let viewController = SignupSurveyViewController(depth: 0)
        self.navigationController?.pushViewController(viewController, animated: false)
        
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func signupStepViewController(titleOf viewController: SignupStepViewController) -> String? {
        return AppDataManager.shared.data["survey1"]?.first?.code_name
    }
}
