//
//  RecommendsViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class RecommendsViewController: BaseMainViewController {
    private let collectionView: UICollectionView
    
    private let buttonBuyCherries = UIButton(type: .custom)
    private let buttonPremium = UIButton(type: .custom)
    private let buttonEvents = UIButton(type: .custom)
    
    private var collectionData = [RecommendData]()
    
    private let loadingQueue = DispatchQueue(label: "RecommendsViewController.loading", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    
    override init(navigationViewEffect effect: UIVisualEffect? = nil) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = RecommendsCollectionViewCell.sectionInset
        flowLayout.minimumInteritemSpacing = RecommendsCollectionViewCell.minimumInteritemSpacing
        flowLayout.itemSize = RecommendsCollectionViewCell.itemSize
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        
        super.init(navigationViewEffect: effect)
        
        showCherriesOnNavigation = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "추천"
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "오늘의 추천"
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18 * QUtils.optimizeRatio(), weight: .bold)
        self.view.addSubview(label)
        
        label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecommendsCollectionViewCell.self, forCellWithReuseIdentifier: "RecommendsCollectionViewCell")
        self.view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: RecommendsCollectionViewCell.itemSize.height).isActive = true
        
        buttonBuyCherries.translatesAutoresizingMaskIntoConstraints = false
        buttonBuyCherries.clipsToBounds = true
        buttonBuyCherries.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .normal)
        buttonBuyCherries.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.6862745098, green: 0.1843137255, blue: 0.2156862745, alpha: 1)), for: .highlighted)
        buttonBuyCherries.setTitle("이용 방법", for: .normal)
        buttonBuyCherries.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonBuyCherries.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonBuyCherries.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonBuyCherries.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonBuyCherries.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        buttonBuyCherries.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8 * QUtils.optimizeRatio(), bottom: 0, right: 0)
        buttonBuyCherries.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8 * QUtils.optimizeRatio())
        self.view.addSubview(buttonBuyCherries)
        
        buttonBuyCherries.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 14 * QUtils.optimizeRatio()).isActive = true
        buttonBuyCherries.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonBuyCherries.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        buttonBuyCherries.heightAnchor.constraint(equalToConstant: buttonBuyCherries.layer.cornerRadius * 2).isActive = true
        
        buttonPremium.translatesAutoresizingMaskIntoConstraints = false
        buttonPremium.clipsToBounds = true
        buttonPremium.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.6862745098, green: 0.1843137255, blue: 0.2156862745, alpha: 1)), for: .normal)
        buttonPremium.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .highlighted)
        buttonPremium.setTitle("이상형 설정", for: .normal)
        buttonPremium.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonPremium.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonPremium.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonPremium.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonPremium.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.view.addSubview(buttonPremium)
        
        buttonPremium.topAnchor.constraint(equalTo: buttonBuyCherries.bottomAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        buttonPremium.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonPremium.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: -4 * QUtils.optimizeRatio()).isActive = true
        buttonPremium.heightAnchor.constraint(equalToConstant: buttonPremium.layer.cornerRadius * 2).isActive = true
        
        buttonEvents.translatesAutoresizingMaskIntoConstraints = false
        buttonEvents.clipsToBounds = true
        buttonEvents.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.9764705882, green: 0.3921568627, blue: 0.4352941176, alpha: 1)), for: .normal)
        buttonEvents.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.6862745098, green: 0.1843137255, blue: 0.2156862745, alpha: 1)), for: .highlighted)
        buttonEvents.setTitle("지인 만나지 않기", for: .normal)
        buttonEvents.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonEvents.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonEvents.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonEvents.layer.cornerRadius = buttonPremium.layer.cornerRadius
        buttonEvents.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.view.addSubview(buttonEvents)
        
        buttonEvents.centerYAnchor.constraint(equalTo: buttonPremium.centerYAnchor).isActive = true
        buttonEvents.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 4 * QUtils.optimizeRatio()).isActive = true
        buttonEvents.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        buttonEvents.heightAnchor.constraint(equalTo: buttonPremium.heightAnchor).isActive = true
        
        self.view.layoutIfNeeded()
        
        reloadData()
    }
    
    private func reloadData() {
        loadingQueue.sync {
            self.collectionView.reloadData()
            
            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.Main.Recommends + "\(MyData.shared.mem_idx)", method: .get, params: nil) { (isSucceed, errMessage, response) in
                guard let responseData = response as? [[String:Any]] else { return }
                
                self.collectionData.append(contentsOf: responseData.map({ (item) -> RecommendData in
                    return RecommendData(with: item)
                }))
                self.collectionView.reloadData()
            }
        }
    }
}

extension RecommendsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = collectionData[indexPath.row]
        let mem_idx = data.mem_idx
        
        LoadingIndicatorManager.shared.showIndicatorView()
        
        let userData = UserData()
        userData.mem_idx = mem_idx
        userData.reloadData { (isSucceed) in
            LoadingIndicatorManager.shared.hideIndicatorView()
            
            let viewController = UserProfileViewController(data: userData)
            let navControlelr = UINavigationController(rootViewController: viewController)
            self.present(navControlelr, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendsCollectionViewCell", for: indexPath) as? RecommendsCollectionViewCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let theCell = cell as? RecommendsCollectionViewCell else { return }
        
        theCell.data = collectionData[indexPath.row]
    }
}
