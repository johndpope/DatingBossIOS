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

private let kTagTextfieldSearchHobby = 1001

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
    private let entryViewJobDetail = SignupProfileTextEntryView()
    private let entryViewWage = SignupProfilePopupEntryView()
    private let entryViewReligion = SignupProfilePopupEntryView()
    private let entryViewHobby = SignupProfilePopupEntryView()
    private let entryViewDrinking = SignupProfilePopupEntryView()
    private let entryViewSmoking = SignupProfilePopupEntryView()
    
    private var seperatorJobDetail: UIView!
    
    private let buttonTextView = UIButton(type: .custom)
    private let textViewComment = UITextView()
    private var constraintTextViewHeight: NSLayoutConstraint!
    
    private let buttonCancel = UIButton(type: .custom)
    private let buttonConfirm = UIButton(type: .custom)
    
    private var pickerData = [Any]()
    
    private var selectedEntryView: SignupProfileEntryView?
    private var editingView: UIView?
    
    private var selectedDataArray = [String]()
    
    private weak var activatingEntryView: SignupProfileEntryView?
    
    private var constraintJobDetailHeight: NSLayoutConstraint!
    
    private weak var textfieldSearchHobby: UITextField?
    private var searchResults = [AppData]()
    private weak var showingTableView: UITableView?
    
    private var blockScrolling = false
    
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
        label.text = "※ 허위로 작성시 이용에 불이익을 받을 수 있습니다."
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
        label.text = "※ 연봉 정보는 이성에게 노출하지 않고 분석에만 쓰입니다."
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
        label.text = "※ 연락처 기재 시 강제탈퇴 처리됩니다."
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
        label.text = "※ 사진은 최소 3장(필수) 최대 6장까지 등록할 수 있습니다."
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
        label.text = "※ 본인 얼굴이 나온 사진을 등록해주세요.(심사항목)"
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
        if let height = UserPayload.shared.height {
            entryViewHeight.labelValue.text = "\(height)"
            entryViewHeight.checked = true
        } else {
            entryViewHeight.checked = false
        }
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
        entryViewShape.labelValue.text = UserPayload.shared.shape?.code_name
        entryViewShape.checked = (UserPayload.shared.shape?.code_name ?? "").count > 0
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
        entryViewBlood.labelValue.text = UserPayload.shared.blood
        entryViewBlood.checked = (UserPayload.shared.blood ?? "").count > 0
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
        entryViewRegion.labelValue.text = UserPayload.shared.region?.code_name
        entryViewRegion.checked = (UserPayload.shared.region?.code_name ?? "").count > 0
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
        entryViewEducation.labelValue.text = UserPayload.shared.education?.code_name
        entryViewEducation.checked = (UserPayload.shared.education?.code_name ?? "").count > 0
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
        entryViewEducationDetail.textfield.text = UserPayload.shared.educationDetail
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
        entryViewJob.labelValue.text = UserPayload.shared.job?.code_name
        entryViewJob.checked = (UserPayload.shared.job?.code_name ?? "").count > 0
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
        
        entryViewJobDetail.translatesAutoresizingMaskIntoConstraints = false
        entryViewJobDetail.clipsToBounds = true
        entryViewJobDetail.hideCheckIndicator = true
        entryViewJobDetail.labelTitle.text = "직업(선택)"
        entryViewJobDetail.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        entryViewJobDetail.textfield.returnKeyType = .done
        entryViewJobDetail.textfield.addTarget(self, action: #selector(self.textfieldDidChange(_:)), for: .editingChanged)
        entryViewJobDetail.textfield.autocorrectionType = .no
        entryViewJobDetail.textfield.delegate = self
        entryViewJobDetail.textfield.text = UserPayload.shared.jobDetail
        theScrollView.addSubview(entryViewJobDetail)
        
        entryViewJobDetail.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewJobDetail.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        entryViewJobDetail.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        constraintJobDetailHeight = entryViewJobDetail.heightAnchor.constraint(equalToConstant: 0)
        constraintJobDetailHeight.isActive = true
        
        bottomAnchor = entryViewJobDetail.bottomAnchor

        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        seperator.isHidden = true
        theScrollView.addSubview(seperator)
        
        seperatorJobDetail = seperator

        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true

        entryViewWage.translatesAutoresizingMaskIntoConstraints = false
        entryViewWage.labelTitle.text = "연봉"
        entryViewWage.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        entryViewWage.labelValue.text = UserPayload.shared.wage?.code_name
        entryViewWage.checked = (UserPayload.shared.wage?.code_name ?? "").count > 0
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
        entryViewReligion.labelValue.text = UserPayload.shared.religion?.code_name
        entryViewReligion.checked = (UserPayload.shared.religion?.code_name ?? "").count > 0
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
        var hobbies = ""
        for i in 0 ..< UserPayload.shared.hobby.count {
            if hobbies.count > 0 {
                hobbies += ", "
            }
            
            hobbies += UserPayload.shared.hobby[i].code_name ?? ""
        }
        entryViewHobby.labelValue.text = hobbies
        entryViewHobby.checked = hobbies.count > 0
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
        entryViewDrinking.labelValue.text = UserPayload.shared.drinking?.code_name
        entryViewDrinking.checked = (UserPayload.shared.drinking?.code_name ?? "").count > 0
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
        entryViewSmoking.labelValue.text = UserPayload.shared.smoking?.code_name
        entryViewSmoking.checked = (UserPayload.shared.smoking?.code_name ?? "").count > 0
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
        textViewComment.text = UserPayload.shared.introduction
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
        buttonConfirm.setTitle("작성 완료", for: .normal)
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
        
        var params = [String:Any]()
        params["opposite_mem_idx"] = MyData.shared.mem_idx
        params["tmp_fl"] = "y"
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Image.Info + "\(MyData.shared.mem_idx)", params: params) { (isSucceed, errMessage, response) in
            guard let responseData = response as? [[String:Any]] else { return }
            
            for i in 0 ..< responseData.count {
                let item = responseData[i]
                guard let picture_idx = item["picture_idx"] as? Int,
                    let urlString = item["picture_name"] as? String/* ,
                    let imageUrl = URL(string: RequestUrl.Image.File + urlString),
                    let imageData = try? Data(contentsOf: imageUrl),
                    let image = UIImage(data: imageData) */ else { continue }
                
                let newData = UserPictureData(image: nil, imageUrl: urlString, picture_idx: "\(picture_idx)")
                UserPayload.shared.pictures.append(newData)
            }
            
            self.collectionViewPictures.reloadData()
        }
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
        
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            PHPhotoLibrary.requestAuthorization({ (status) in
                
            })
        }
        
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
            uploadProfile()
            break
            
        case buttonCancel:
            let alertController = AlertPopupViewController(withTitle: "회원가입 중단", message: "회원가입을 중단하시겠습니까?")
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let viewController = LoginViewController()
                UIApplication.appDelegate().changeRootViewController(viewController)
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
            
            activatingEntryView = entryViewHeight
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewHeight.labelTitle.text, View: pickerView)
            alertController.delegate = self
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let value = pickerView.selectedRow(inComponent: 0) + 150
                UserPayload.shared.height = value
                
                self.entryViewHeight.checked = true
                self.entryViewHeight.labelValue.text = "\(value)"
                
                UserPayload.shared.commit()
            }))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewShape {
            let key = UserPayload.shared.gender == .male ? "maleform" : "femaleform"
            
            guard let dataArray = AppDataManager.shared.data[key] else { return }
            
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
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewShape.labelTitle.text, View: tableView)
            alertController.delegate = self
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewBlood {
            let dataArray = ["A", "B", "AB", "O"]
            
            pickerData.removeAll()
            pickerData.append(contentsOf: dataArray)
            
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
        } else if entryView == entryViewRegion {
            guard let dataArray = AppDataManager.shared.data["area"] else { return }
            
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
        } else if entryView == entryViewEducation {
            guard let dataArray = AppDataManager.shared.data["edu"] else { return }
            
            pickerData.removeAll()
            pickerData.append(contentsOf: dataArray)
            
            let maximumRows = Int((UIScreen.main.bounds.size.height / SignupProfileSpecTableViewCell.height).rounded(.down) - 5)
            
            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: SignupProfileSpecTableViewCell.height * CGFloat(pickerData.count > maximumRows ? maximumRows : pickerData.count)))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(SignupProfileSpecTableViewCell.self, forCellReuseIdentifier: "SignupProfileSpecTableViewCell")
            showingTableView = tableView
            
            activatingEntryView = entryViewEducation
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewEducation.labelTitle.text, View: tableView)
            alertController.delegate = self
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewEducationDetail {
            editingView = entryViewEducationDetail
            _ = entryViewEducationDetail.textfield.becomeFirstResponder()
        } else if entryView == entryViewJob {
            guard let dataArray = AppDataManager.shared.data["job"] else { return }
            
            pickerData.removeAll()
            pickerData.append(contentsOf: dataArray)
            
            let maximumRows = Int((UIScreen.main.bounds.size.height / SignupProfileSpecTableViewCell.height).rounded(.down) - 5)
            
            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: SignupProfileSpecTableViewCell.height * CGFloat(pickerData.count > maximumRows ? maximumRows : pickerData.count)))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(SignupProfileSpecTableViewCell.self, forCellReuseIdentifier: "SignupProfileSpecTableViewCell")
            showingTableView = tableView
            
            activatingEntryView = entryViewJob
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewJob.labelTitle.text, View: tableView)
            alertController.delegate = self
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewWage {
            guard let dataArray = AppDataManager.shared.data["income"] else { return }
            
            pickerData.removeAll()
            pickerData.append(contentsOf: dataArray)
            
            let maximumRows = Int((UIScreen.main.bounds.size.height / SignupProfileSpecTableViewCell.height).rounded(.down) - 5)
            
            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: SignupProfileSpecTableViewCell.height * CGFloat(pickerData.count > maximumRows ? maximumRows : pickerData.count)))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(SignupProfileSpecTableViewCell.self, forCellReuseIdentifier: "SignupProfileSpecTableViewCell")
            showingTableView = tableView
            
            activatingEntryView = entryViewWage
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewWage.labelTitle.text, View: tableView)
            alertController.delegate = self
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewReligion {
            guard let dataArray = AppDataManager.shared.data["religion"] else { return }
            
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
            guard let dataArray = AppDataManager.shared.data["hobby"] else { return }
            
            pickerData.removeAll()
            
            let preselected = UserPayload.shared.hobby.map { (item) -> String in
                return item.code ?? ""
            }
            
            selectedDataArray.removeAll()
            
            for i in 0 ..< dataArray.count {
                let item = dataArray[i]
                guard let code = item.code, preselected.firstIndex(of: code) != nil else { continue }
                selectedDataArray.append(code)
            }
            
            pickerData.append(contentsOf: dataArray)
            
            activatingEntryView = entryViewHobby
            
            let maximumRows = (UIScreen.main.bounds.size.height / SignupProfileSpecTableViewCell.height).rounded(.down) - 5
            
            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWidthPopupContentView, height: SignupProfileSpecTableViewCell.height * maximumRows))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(SignupProfileSpecTableViewCell.self, forCellReuseIdentifier: "SignupProfileSpecTableViewCell")
            showingTableView = tableView
            
            let alertController = AlertPopupCustomViewController(withTitle: entryViewHobby.labelTitle.text, View: tableView)
            alertController.delegate = self
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                var selection = [AppData]()
                
                var valueString = ""
                
                for code in self.selectedDataArray {
                    var data: AppData?
                    for i in 0 ..< self.pickerData.count {
                        guard let item = self.pickerData[i] as? AppData, item.code == code else { continue }
                        data = item
                        break
                    }
                    
                    guard let codeName = data?.code_name else { continue }
                    
                    selection.append(data!)
                    
                    if valueString.count > 0 {
                        valueString += ", "
                    }
                    
                    valueString += codeName
                }
                
                UserPayload.shared.hobby.removeAll()
                UserPayload.shared.hobby.append(contentsOf: selection)
                
                self.entryViewHobby.labelValue.text = valueString
                self.entryViewHobby.checked = valueString.count > 0
                
                UserPayload.shared.commit()
            }))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
        } else if entryView == entryViewDrinking {
            guard let dataArray = AppDataManager.shared.data["drinking"] else { return }
            
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
            guard let dataArray = AppDataManager.shared.data["smoking"] else { return }
            
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
        guard blockScrolling == false else {
            blockScrolling = false
            return
        }
        
        var contentSize = theScrollView.contentSize
        contentSize.height = buttonConfirm.frame.maxY + 7 * QUtils.optimizeRatio()
        theScrollView.contentSize = contentSize
        
        var contentOffset = theScrollView.contentOffset
        contentOffset.y = theScrollView.contentSize.height - theScrollView.frame.size.height
        theScrollView.setContentOffset(contentOffset, animated: true)
    }
    
    @objc private func textfieldDidChange(_ textfield: UITextField) {
        if textfield.tag == kTagTextfieldSearchHobby {
            searchHobby()
            return
        }
        
        if (textfield.superview as? SignupProfileTextEntryView) == entryViewEducationDetail {
            UserPayload.shared.educationDetail = textfield.text
        } else if (textfield.superview as? SignupProfileTextEntryView) == entryViewJobDetail {
            UserPayload.shared.jobDetail = textfield.text
        }
    }
    
    private func searchHobby() {
        searchResults.removeAll()
        guard let keyword = textfieldSearchHobby?.text, keyword.count > 0, let dataArray = pickerData as? [AppData] else {
            showingTableView?.reloadData()
            return
        }
        
        for i in 0 ..< dataArray.count {
            let item = dataArray[i]
            guard let code_name = item.code_name, code_name.range(of: keyword) != nil else { continue }
            searchResults.append(item)
        }
        
        showingTableView?.reloadData()
    }
    
    private func uploadProfile() {
        var errMessage: String?
        
        if UserPayload.shared.pictures.count < 3 {
            errMessage = "프로필 사진을 3장 이상 등록해주세요."
        } else if entryViewHeight.checked == false {
            errMessage = "키를 입력하세요."
        } else if entryViewShape.checked == false {
            errMessage = "체형을 입력하세요."
        } else if entryViewBlood.checked == false {
            errMessage = "혈액형을 입력하세요."
        } else if entryViewRegion.checked == false {
            errMessage = "지역을 입력하세요."
        } else if entryViewEducation.checked == false {
            errMessage = "학력을 입력하세요."
        } else if entryViewJob.checked == false {
            errMessage = "직업을 입력하세요."
        } else if entryViewWage.checked == false {
            errMessage = "연봉을 입력하세요."
        } else if entryViewReligion.checked == false {
            errMessage = "종교를 입력하세요."
        } else if entryViewHobby.checked == false {
            errMessage = "취미를 입력하세요."
        } else if entryViewDrinking.checked == false {
            errMessage = "음주 스타일을 입력하세요."
        } else if entryViewSmoking.checked == false {
            errMessage = "흡연여부를 입력하세요."
//        } else if textViewComment.text.count == 0 {
//            errMessage = "하고싶은 말을 입력하세요."
        }
        
        guard errMessage == nil else {
            InstanceMessageManager.shared.showMessage(errMessage!, margin: buttonConfirm.frame.size.height + 8 * QUtils.optimizeRatio())
            return
        }
        
        var params = [String:Any]()
        params["height"] = UserPayload.shared.height
        params["form_cd"] = UserPayload.shared.shape?.code
        params["blood_type"] = UserPayload.shared.blood?.lowercased()
        params["area_cd"] = UserPayload.shared.region?.code
        params["edu_cd"] = UserPayload.shared.education?.code
        params["job_cd"] = UserPayload.shared.job?.code
        params["income_cd"] = UserPayload.shared.wage?.code
        params["religion_cd"] = UserPayload.shared.religion?.code
        params["drinking_cd"] = UserPayload.shared.drinking?.code
        params["smoking_cd"] = UserPayload.shared.smoking?.code
        
        var hobby_cd = ""
        for hobby in UserPayload.shared.hobby {
            guard let code = hobby.code else { continue }
            if hobby_cd.count > 0 {
                hobby_cd += ","
            }
            
            hobby_cd += code
        }
        params["hobby_cd"] = hobby_cd
        
        params["introduction"] = UserPayload.shared.introduction
        params["school"] = UserPayload.shared.educationDetail
        params["job_etc"] = UserPayload.shared.jobDetail
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Account.Update + "\(MyData.shared.mem_idx)", method: .patch, headerValues: nil, params: params) { (isSucceed, errMessage, response) in
            guard let responseData = response as? [String:Any],
                let status = responseData["Status"] as? String,
                status == "OK"  else {
                    InstanceMessageManager.shared.showMessage(kStringErrorUnknown, margin: self.buttonConfirm.frame.size.height + 8 * QUtils.optimizeRatio())
                    return
            }
            
            var params = [String:Any]()
            params["sign_up_fl"] = "s"
            
            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.Account.ChangeStatus + "\(MyData.shared.mem_idx)", method: .patch, params: params, completion: nil)
            
            let viewController = SignupStepViewController(step: 2)
            viewController.delegate = self
            self.present(viewController, animated: true, completion: nil)
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
        
        let showPermissionAlert = {(message: String) -> Void in
            let alertController = AlertPopupViewController(withTitle: "접근권한이 없습니다.", message: message)
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
        }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "카메라로 촬영하기", style: .default, handler: { (action) in
            guard accessableCamera == .authorized else {
                showPermissionAlert("카메라 접근 권한이 없습니다.\n설정으로 이동하여 접근권한 설정을\n변경하여 주세요.")
                return
            }
            
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            pickerController.allowsEditing = true
            pickerController.cameraCaptureMode = .photo
            pickerController.cameraDevice = .rear
            pickerController.showsCameraControls = true
            self.present(pickerController, animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: "사진에서 가져오기", style: .default, handler: { (action) in
            guard accessablePhoto == .authorized else {
                showPermissionAlert("사진 접근 권한이 없습니다.\n설정으로 이동하여 접근권한 설정을\n변경하여 주세요.")
                return
            }
            
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.allowsEditing = true
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }))
        if indexPath.row > 0, indexPath.row < UserPayload.shared.pictures.count {
            alertController.addAction(UIAlertAction(title: "대표사진 등록", style: .default, handler: { (action) in
                LoadingIndicatorManager.shared.showIndicatorView()
                
                var pictureList = [[String:Any]]()
                for i in 0 ..< UserPayload.shared.pictures.count {
                    let item = UserPayload.shared.pictures[i]
                    
                    var newData = [String:Any]()
                    newData["picture_idx"] = item.picture_idx
                    newData["picture_seq"] = i + 1
                    pictureList.append(newData)
                }
                
                var params = [String:Any]()
                params["pictureList"] = pictureList
                
                let httpClient = QHttpClient()
                httpClient.request(to: RequestUrl.Image.Info + "\(MyData.shared.mem_idx)", method: .patch, headerValues: nil, params: params, completion: { (isSucceed, errMessgae, response) in
                    LoadingIndicatorManager.shared.hideIndicatorView()
                    
                    var pictureArray = UserPayload.shared.pictures
                    let data = pictureArray.remove(at: indexPath.row)
                    pictureArray.insert(data, at: 0)
                    UserPayload.shared.pictures = pictureArray
                    
                    self.collectionViewPictures.reloadData()
                })
            }))
        }
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignupProfilePictureCollectionViewCell", for: indexPath) as? SignupProfilePictureCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.row < UserPayload.shared.pictures.count {
            cell.data = UserPayload.shared.pictures[indexPath.row]
        } else {
            cell.data = nil
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? SignupProfilePictureCollectionViewCell)?.reloadData()
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
        params["picture"] = image.jpegData(compressionQuality: 0.8)
        params["tmp_fl"] = "y"
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Image.Info + "\(MyData.shared.mem_idx)/\(index + 1)/y", params: params) { (isSucceed, errMessage, response) in
            LoadingIndicatorManager.shared.hideIndicatorView()
            
            guard let responseData = response as? [String:Any], let picture_idx = responseData["picture_idx"] as? String else {
                picker.dismiss(animated: true, completion: {
                    InstanceMessageManager.shared.showMessage(kStringErrorUnknown)
                })
                return
            }
            
            let newData = UserPictureData(image: image, imageUrl: nil, picture_idx: picture_idx)
            
            if self.replaceIndex != nil, self.replaceIndex! < UserPayload.shared.pictures.count {
                UserPayload.shared.pictures[self.replaceIndex!] = newData
            } else {
                UserPayload.shared.pictures.append(newData)
            }
            
            self.collectionViewPictures.reloadData()
            
            self.replaceIndex = nil
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

extension SignupProfileSpecsViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _ = textViewComment.resignFirstResponder()
        _ = entryViewEducationDetail.textfield.resignFirstResponder()
        _ = textfieldSearchHobby?.resignFirstResponder()
    }
}

extension SignupProfileSpecsViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        UserPayload.shared.introduction = textView.text
        
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
        guard textField.tag != kTagTextfieldSearchHobby else { return true }
        
        editingView = textField.superview
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        blockScrolling = textField == textfieldSearchHobby
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
        guard activatingEntryView != entryViewHobby else {
            var data: AppData?
            
            if (textfieldSearchHobby?.text?.count ?? 0) > 0 {
                data = searchResults[indexPath.row]
            } else {
                data = pickerData[indexPath.row] as? AppData
            }
            
            guard let code = data?.code else { return }
            
            if let index = selectedDataArray.firstIndex(of: code) {
                _ = selectedDataArray.remove(at: index)
            } else if selectedDataArray.count < 3 {
                selectedDataArray.append(code)
            } else {
                InstanceMessageManager.shared.showMessage("더 선택할 수 없습니다.")
            }
            
            tableView.reloadData()
            return
        }
        
        let value = pickerData[indexPath.row]
        
        if activatingEntryView == entryViewShape {
            UserPayload.shared.shape = value as? AppData
            
            self.entryViewShape.checked = true
            self.entryViewShape.labelValue.text = (value as? AppData)?.code_name
        } else if activatingEntryView == entryViewBlood {
            UserPayload.shared.blood = value as? String
            
            self.entryViewBlood.checked = true
            self.entryViewBlood.labelValue.text = value as? String
        } else if activatingEntryView == entryViewRegion {
            UserPayload.shared.region = value as? AppData
            
            self.entryViewRegion.checked = true
            self.entryViewRegion.labelValue.text = (value as? AppData)?.code_name
        } else if activatingEntryView == entryViewEducation {
            UserPayload.shared.education = value as? AppData
            
            self.entryViewEducation.checked = true
            self.entryViewEducation.labelValue.text = (value as? AppData)?.code_name
        } else if activatingEntryView == entryViewJob {
            UserPayload.shared.job = value as? AppData
            UserPayload.shared.jobDetail = nil
            
            self.entryViewJob.checked = true
            self.entryViewJob.labelValue.text = (value as? AppData)?.code_name
            
            self.entryViewJobDetail.textfield.text = nil
            
            seperatorJobDetail.isHidden = (value as? AppData)?.code_name != "기타"
            constraintJobDetailHeight.constant = (value as? AppData)?.code_name != "기타" ? 0 : 56 * QUtils.optimizeRatio()
            self.view.layoutIfNeeded()
            
            reloadContentSize()
        } else if activatingEntryView == entryViewWage {
            UserPayload.shared.wage = value as? AppData
            
            self.entryViewWage.checked = true
            self.entryViewWage.labelValue.text = (value as? AppData)?.code_name
        } else if activatingEntryView == entryViewReligion {
            UserPayload.shared.religion = value as? AppData
            
            self.entryViewReligion.checked = true
            self.entryViewReligion.labelValue.text = (value as? AppData)?.code_name
        } else if activatingEntryView == entryViewDrinking {
            UserPayload.shared.drinking = value as? AppData
            
            self.entryViewDrinking.checked = true
            self.entryViewDrinking.labelValue.text = (value as? AppData)?.code_name
        } else if activatingEntryView == entryViewSmoking {
            UserPayload.shared.smoking = value as? AppData
            
            self.entryViewSmoking.checked = true
            self.entryViewSmoking.labelValue.text = (value as? AppData)?.code_name
        }
        
        for subVC in self.children {
            guard let alertController = subVC as? BasePopupViewController else { continue }
            alertController.hide()
        }
        
        UserPayload.shared.commit()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return activatingEntryView == entryViewHobby ? SignupProfileSpecTableViewCell.height : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard activatingEntryView == entryViewHobby else { return UIView() }
        
        var frame = CGRect.zero
        frame.size.width = tableView.frame.size.width
        frame.size.height = self.tableView(tableView, heightForHeaderInSection: section)
        
        let headerView = UIView(frame: frame)
        headerView.backgroundColor = .clear
        
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backView.layer.borderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        backView.layer.borderWidth = 1
        backView.layer.cornerRadius = 20 * QUtils.optimizeRatio()
        backView.clipsToBounds = true
        headerView.addSubview(backView)
        
        backView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12 * QUtils.optimizeRatio()).isActive = true
        backView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12 * QUtils.optimizeRatio()).isActive = true
        backView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        backView.heightAnchor.constraint(equalToConstant: backView.layer.cornerRadius * 2).isActive = true
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "img_popup_search")
        backView.addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12 * QUtils.optimizeRatio()).isActive = true
        imageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 32 * QUtils.optimizeRatio()).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 32 * QUtils.optimizeRatio()).isActive = true
        
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.tag = kTagTextfieldSearchHobby
        textfield.placeholder = "검색"
        textfield.textColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        textfield.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        textfield.returnKeyType = .done
        textfield.delegate = self
        textfield.clearButtonMode = .always
        textfield.addTarget(self, action: #selector(self.textfieldDidChange(_:)), for: .editingChanged)
        backView.addSubview(textfield)
        
        textfieldSearchHobby = textfield
        
        textfield.topAnchor.constraint(equalTo: backView.topAnchor).isActive = true
        textfield.bottomAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        textfield.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        textfield.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12 * QUtils.optimizeRatio()).isActive = true
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if activatingEntryView == entryViewHobby, (textfieldSearchHobby?.text ?? "").count > 0 {
            return searchResults.count
        }
        
        return pickerData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SignupProfileSpecTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SignupProfileSpecTableViewCell") as? SignupProfileSpecTableViewCell else { return UITableViewCell() }
        
        var candidate: Any
        if activatingEntryView == entryViewHobby, (textfieldSearchHobby?.text ?? "").count > 0 {
            candidate = searchResults[indexPath.row]
        } else {
            candidate = pickerData[indexPath.row]
        }
        
        if let data = candidate as? AppData {
            cell.labelTitle.text = data.code_name
        } else if let titleString = candidate as? String {
            cell.labelTitle.text = titleString
        } else {
            cell.labelTitle.text = nil
        }
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        
        if activatingEntryView == entryViewHobby, let code = (candidate as? AppData)?.code {
            cell.isSelectedCell = selectedDataArray.firstIndex(of: code) != nil
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

extension SignupProfileSpecsViewController: BasePopupViewControllerDelegate {
    func popupViewController(canDismiss viewController: BasePopupViewController) -> Bool {
        guard (textfieldSearchHobby?.isEditing ?? false) == true else { return true }
        _ = textfieldSearchHobby?.resignFirstResponder()
        return false
    }
    
    func popupViewController(dismissed viewController: BasePopupViewController) {
        activatingEntryView = nil
        showingTableView = nil
        
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}

