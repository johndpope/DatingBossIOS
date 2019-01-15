//
//  SignupSelectFavorLooksViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 14/12/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class SignupSelectFavorLooksViewController: BaseSignupStepsViewController {
    private let imageViewLooks = UIImageView()
    private let buttonImage = UIButton(type: .custom)
    
    private let theScrollView = UIScrollView()
    
    private let buttonYes = UIButton(type: .custom)
    private let buttonNo = UIButton(type: .custom)
    
    private let collectionViewTag: UICollectionView!
    private let buttonDone = UIButton(type: .custom)
    
    private var currentPage = 0
    private var evaluatingData = [FavorLookData]()
    
    private var collectionData = [TagData]()
    private var selectedTagIndex = [Int]()
    
    override init(navigationViewEffect effect: UIVisualEffect? = nil) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8 * QUtils.optimizeRatio()
        flowLayout.minimumInteritemSpacing = 8 * QUtils.optimizeRatio()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30 * QUtils.optimizeRatio(), bottom: 0, right: 30 * QUtils.optimizeRatio())
        
        var itemSize = CGSize.zero
        itemSize.width = ((UIScreen.main.bounds.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - (flowLayout.minimumInteritemSpacing * 2)) / 3).rounded(.down)
        itemSize.height = 48 * QUtils.optimizeRatio()
        flowLayout.itemSize = itemSize
        
        collectionViewTag = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        
        super.init(navigationViewEffect: effect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        labelTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        labelTitle.text = "이상형 외모 설정"
        
        imageViewLooks.translatesAutoresizingMaskIntoConstraints = false
        imageViewLooks.isUserInteractionEnabled = true
        imageViewLooks.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        imageViewLooks.clipsToBounds = true
        imageViewLooks.contentMode = .scaleAspectFill
        self.view.addSubview(imageViewLooks)
        
        self.view.bringSubviewToFront(headerView)
        
        imageViewLooks.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        imageViewLooks.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageViewLooks.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageViewLooks.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 270 / 512).isActive = true
        
        buttonImage.translatesAutoresizingMaskIntoConstraints = false
        buttonImage.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        imageViewLooks.addSubview(buttonImage)
        
        buttonImage.topAnchor.constraint(equalTo: imageViewLooks.topAnchor).isActive = true
        buttonImage.bottomAnchor.constraint(equalTo: imageViewLooks.bottomAnchor).isActive = true
        buttonImage.leadingAnchor.constraint(equalTo: imageViewLooks.leadingAnchor).isActive = true
        buttonImage.trailingAnchor.constraint(equalTo: imageViewLooks.trailingAnchor).isActive = true
        
        theScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(theScrollView)
        
        theScrollView.topAnchor.constraint(equalTo: imageViewLooks.bottomAnchor).isActive = true
        theScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        theScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        theScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        var contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        theScrollView.addSubview(contentView)
        
        contentView.topAnchor.constraint(equalTo: theScrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: theScrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: theScrollView.heightAnchor).isActive = true
        
        let normalAttr = QTextAttributes(withForegroundColour: #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)).attributes
        let highAttr = QTextAttributes(withForegroundColour: #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)).attributes
        
        var attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "본인의 이상형 외모라면 ", attributes: normalAttr))
        attributedString.append(NSAttributedString(string: "Yes", attributes: highAttr))
        attributedString.append(NSAttributedString(string: "를, 아니라면 ", attributes: normalAttr))
        attributedString.append(NSAttributedString(string: "No", attributes: highAttr))
        attributedString.append(NSAttributedString(string: "를 선택하세요.", attributes: normalAttr))
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attributedString
        label.numberOfLines = 0
        label.textAlignment = .center
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30 * QUtils.optimizeRatio()).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30 * QUtils.optimizeRatio()).isActive = true
        
        buttonNo.translatesAutoresizingMaskIntoConstraints = false
        buttonNo.setImage(UIImage(named: "img_favor_no_nor"), for: .normal)
        buttonNo.setImage(UIImage(named: "img_favor_no_high"), for: .normal)
        buttonNo.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        contentView.addSubview(buttonNo)
        
        buttonNo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 20 * QUtils.optimizeRatio()).isActive = true
        buttonNo.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -30 * QUtils.optimizeRatio()).isActive = true
        buttonNo.widthAnchor.constraint(equalToConstant: 120 * QUtils.optimizeRatio()).isActive = true
        buttonNo.heightAnchor.constraint(equalToConstant: 120 * QUtils.optimizeRatio()).isActive = true
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No"
        label.textColor = #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .regular)
        contentView.addSubview(label)
        
        label.bottomAnchor.constraint(equalTo: buttonNo.topAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        label.centerXAnchor.constraint(equalTo: buttonNo.centerXAnchor).isActive = true
        
        buttonYes.translatesAutoresizingMaskIntoConstraints = false
        buttonYes.setImage(UIImage(named: "img_favor_yes_nor"), for: .normal)
        buttonYes.setImage(UIImage(named: "img_favor_yes_high"), for: .normal)
        buttonYes.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        contentView.addSubview(buttonYes)
        
        buttonYes.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 20 * QUtils.optimizeRatio()).isActive = true
        buttonYes.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 30 * QUtils.optimizeRatio()).isActive = true
        buttonYes.widthAnchor.constraint(equalToConstant: 120 * QUtils.optimizeRatio()).isActive = true
        buttonYes.heightAnchor.constraint(equalToConstant: 120 * QUtils.optimizeRatio()).isActive = true
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Yes"
        label.textColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .regular)
        contentView.addSubview(label)
        
        label.bottomAnchor.constraint(equalTo: buttonYes.topAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        label.centerXAnchor.constraint(equalTo: buttonYes.centerXAnchor).isActive = true
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        theScrollView.addSubview(contentView)
        
        contentView.topAnchor.constraint(equalTo: theScrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: theScrollView.leadingAnchor, constant: self.view.frame.size.width).isActive = true
        contentView.widthAnchor.constraint(equalTo: theScrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: theScrollView.heightAnchor).isActive = true
        
        attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "이상형으로 선택한 이성의 ", attributes: normalAttr))
        attributedString.append(NSAttributedString(string: "외모를 단어", attributes: highAttr))
        attributedString.append(NSAttributedString(string: "로 표현해 주세요.", attributes: normalAttr))
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attributedString
        label.numberOfLines = 0
        label.textAlignment = .center
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30 * QUtils.optimizeRatio()).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30 * QUtils.optimizeRatio()).isActive = true
        
        buttonDone.translatesAutoresizingMaskIntoConstraints = false
        buttonDone.clipsToBounds = true
        buttonDone.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .normal)
        buttonDone.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)), for: .disabled)
        buttonDone.setTitle("설정 완료", for: .normal)
        buttonDone.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonDone.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonDone.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonDone.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonDone.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        contentView.addSubview(buttonDone)
        
        buttonDone.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7 * QUtils.optimizeRatio()).isActive = true
        buttonDone.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonDone.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        buttonDone.heightAnchor.constraint(equalToConstant: buttonDone.layer.cornerRadius * 2).isActive = true
        
        collectionViewTag.translatesAutoresizingMaskIntoConstraints = false
        collectionViewTag.backgroundColor = .clear
        collectionViewTag.delegate = self
        collectionViewTag.dataSource = self
        collectionViewTag.register(SignupSelectTagCollectionViewCell.self, forCellWithReuseIdentifier: "SignupSelectTagCollectionViewCell")
        contentView.addSubview(collectionViewTag)
        
        collectionViewTag.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        collectionViewTag.bottomAnchor.constraint(equalTo: buttonDone.topAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        collectionViewTag.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionViewTag.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        self.view.layoutIfNeeded()
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.FavorLooks.Tag + "\(MyData.shared.mem_idx)", method: .get, headerValues: nil, params: nil) { (isSucceed, errMessage, response) in
            guard let responseData = response as? [[String:Any]] else { return }
            
            self.collectionData.removeAll()
            self.collectionData.append(contentsOf: responseData.map({ (item) -> TagData in
                return TagData(with: item)
            }))
            
            self.collectionViewTag.reloadData()
        }
        
        reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        (self.navigationController as? SignupNavigationViewController)?.navigatingView.step = 5
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonImage:
            guard let image = imageViewLooks.image else { break }
            let viewController = ImagePreviewViewController(image: image)
            UIApplication.appDelegate().window?.addSubview(viewController.view)
            self.addChild(viewController)
            
            viewController.show()
            break
            
        case buttonNo:
            currentPage += 1
            reloadEvaluatingData()
            break
            
        case buttonYes:
            var contentOffset = theScrollView.contentOffset
            contentOffset.x = theScrollView.bounds.size.width
            theScrollView.setContentOffset(contentOffset, animated: false)
            break
            
        case buttonDone:
            var looksList = [[String:Any]]()
            for index in selectedTagIndex {
                let data = collectionData[index]
                
                var dict = [String:Any]()
                dict["opposite_mem_idx"] = evaluatingData[currentPage].mem_idx
                dict["looks_cd"] = data.code
                looksList.append(dict)
            }
            
            var params = [String:Any]()
            params["looksList"] = looksList
            
            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.FavorLooks.AddTag + "\(MyData.shared.mem_idx)", method: .patch, headerValues: nil, params: params, completion: nil)
            
            pressedButton(buttonNo)
            break
            
        default: break
        }
    }
    
    private func reloadData() {
        imageViewLooks.image = nil
        
        LoadingIndicatorManager.shared.showIndicatorView()
        theScrollView.setContentOffset(CGPoint.zero, animated: false)
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.FavorLooks.Pictrues + "\(MyData.shared.mem_idx)/\(5)", method: .get, headerValues: nil, params: nil) { (isSucceed, errMessage, response) in
            LoadingIndicatorManager.shared.hideIndicatorView()
            
            guard let responseData = response as? [[String:Any]] else { return }
            
            self.evaluatingData.removeAll()
            self.evaluatingData.append(contentsOf: responseData.map({ (item) -> FavorLookData in
                return FavorLookData(with: item)
            }))
            
            self.reloadEvaluatingData()
        }
    }
    
    private func reloadEvaluatingData() {
        guard currentPage < evaluatingData.count else {
            var params = [String:Any]()
            params["sign_up_fl"] = "r"
            
            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.Account.ChangeStatus + "\(MyData.shared.mem_idx)", method: .patch, params: params, completion: nil)
            
            let viewController = SignupFinalizeViewController()
            self.present(viewController, animated: true, completion: nil)
            return
        }
        
        imageViewLooks.pin_clearImages()
        
        theScrollView.setContentOffset(CGPoint.zero, animated: false)
        
        let currentData = evaluatingData[currentPage]
        
        selectedTagIndex.removeAll()
        collectionViewTag.reloadData()
        
        buttonDone.isEnabled = false
        
        self.imageViewLooks.pin_setImage(from: currentData.imageUrl)
    }
}

extension SignupSelectFavorLooksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let index = selectedTagIndex.firstIndex(of: indexPath.row) {
            selectedTagIndex.remove(at: index)
        } else {
            selectedTagIndex.append(indexPath.row)
        }
        
        collectionViewTag.reloadData()
        
        buttonDone.isEnabled = selectedTagIndex.count > 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignupSelectTagCollectionViewCell", for: indexPath) as? SignupSelectTagCollectionViewCell else { return UICollectionViewCell() }
        cell.data = collectionData[indexPath.row]
        cell.isSelectedTag = selectedTagIndex.firstIndex(of: indexPath.row) != nil
        return cell
    }
}
