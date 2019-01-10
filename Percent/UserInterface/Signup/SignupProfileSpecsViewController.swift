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
    private let entryViewEducationDetail = SignupProfilePopupEntryView()
    private let entryViewJob = SignupProfilePopupEntryView()
    private let entryViewWage = SignupProfilePopupEntryView()
    private let entryViewReligion = SignupProfilePopupEntryView()
    private let entryViewHobby = SignupProfilePopupEntryView()
    private let entryViewDrinking = SignupProfilePopupEntryView()
    private let entryViewSmoking = SignupProfilePopupEntryView()
    
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
        self.view.addSubview(theScrollView)
        
        theScrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        theScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        theScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
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
        entryViewHeight.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        entryViewHeight.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        entryViewHeight.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewHeight.bottomAnchor
        
        var seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewShape.translatesAutoresizingMaskIntoConstraints = false
        entryViewShape.labelTitle.text = "체형"
        entryViewShape.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        self.view.addSubview(entryViewShape)
        
        entryViewShape.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewShape.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor).isActive = true
        entryViewShape.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor).isActive = true
        entryViewShape.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewShape.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewBlood.translatesAutoresizingMaskIntoConstraints = false
        entryViewBlood.labelTitle.text = "혈액형"
        entryViewBlood.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        self.view.addSubview(entryViewBlood)
        
        entryViewBlood.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewBlood.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor).isActive = true
        entryViewBlood.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor).isActive = true
        entryViewBlood.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewBlood.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewRegion.translatesAutoresizingMaskIntoConstraints = false
        entryViewRegion.labelTitle.text = "지역"
        entryViewRegion.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        self.view.addSubview(entryViewRegion)
        
        entryViewRegion.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewRegion.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor).isActive = true
        entryViewRegion.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor).isActive = true
        entryViewRegion.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewRegion.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewEducation.translatesAutoresizingMaskIntoConstraints = false
        entryViewEducation.labelTitle.text = "학력"
        entryViewEducation.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        self.view.addSubview(entryViewEducation)
        
        entryViewEducation.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewEducation.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor).isActive = true
        entryViewEducation.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor).isActive = true
        entryViewEducation.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewEducation.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewEducationDetail.translatesAutoresizingMaskIntoConstraints = false
        entryViewEducationDetail.hideCheckIndicator = true
        entryViewEducationDetail.labelTitle.text = "학교(선택)"
        entryViewEducationDetail.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        self.view.addSubview(entryViewEducationDetail)
        
        entryViewEducationDetail.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewEducationDetail.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor).isActive = true
        entryViewEducationDetail.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor).isActive = true
        entryViewEducationDetail.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewEducationDetail.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewJob.translatesAutoresizingMaskIntoConstraints = false
        entryViewJob.labelTitle.text = "직업"
        entryViewJob.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        self.view.addSubview(entryViewJob)
        
        entryViewJob.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewJob.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor).isActive = true
        entryViewJob.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor).isActive = true
        entryViewJob.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewJob.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewWage.translatesAutoresizingMaskIntoConstraints = false
        entryViewWage.labelTitle.text = "연봉"
        entryViewWage.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        self.view.addSubview(entryViewWage)
        
        entryViewWage.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewWage.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor).isActive = true
        entryViewWage.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor).isActive = true
        entryViewWage.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewWage.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewReligion.translatesAutoresizingMaskIntoConstraints = false
        entryViewReligion.labelTitle.text = "종교"
        entryViewReligion.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        self.view.addSubview(entryViewReligion)
        
        entryViewReligion.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewReligion.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor).isActive = true
        entryViewReligion.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor).isActive = true
        entryViewReligion.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewReligion.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewHobby.translatesAutoresizingMaskIntoConstraints = false
        entryViewHobby.labelTitle.text = "취미"
        entryViewHobby.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        self.view.addSubview(entryViewHobby)
        
        entryViewHobby.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewHobby.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor).isActive = true
        entryViewHobby.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor).isActive = true
        entryViewHobby.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewHobby.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewDrinking.translatesAutoresizingMaskIntoConstraints = false
        entryViewDrinking.labelTitle.text = "음주 스타일"
        entryViewDrinking.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        self.view.addSubview(entryViewDrinking)
        
        entryViewDrinking.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewDrinking.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor).isActive = true
        entryViewDrinking.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor).isActive = true
        entryViewDrinking.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewDrinking.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewSmoking.translatesAutoresizingMaskIntoConstraints = false
        entryViewSmoking.labelTitle.text = "흡연여부"
        entryViewSmoking.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        self.view.addSubview(entryViewSmoking)
        
        entryViewSmoking.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewSmoking.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor).isActive = true
        entryViewSmoking.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor).isActive = true
        entryViewSmoking.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = entryViewSmoking.bottomAnchor
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: theScrollView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        label = UILabel()
    }
    
    @objc private func pressedEntryButton(_ sender: UIButton) {
        
    }
}

extension SignupProfileSpecsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
                pickerController.allowsEditing = true
                pickerController.cameraCaptureMode = .photo
                pickerController.cameraDevice = .rear
                pickerController.showsCameraControls = true
                pickerController.sourceType = .camera
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
