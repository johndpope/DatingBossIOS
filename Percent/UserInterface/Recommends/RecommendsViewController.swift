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
    
    private let buttonGuide = UIButton(type: .custom)
    private let buttonPrefer = UIButton(type: .custom)
    private let buttonAvoidKnowns = UIButton(type: .custom)
    
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
        
        buttonGuide.translatesAutoresizingMaskIntoConstraints = false
        buttonGuide.clipsToBounds = true
        buttonGuide.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .normal)
        buttonGuide.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.6862745098, green: 0.1843137255, blue: 0.2156862745, alpha: 1)), for: .highlighted)
        buttonGuide.setTitle("이용 방법", for: .normal)
        buttonGuide.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonGuide.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonGuide.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonGuide.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonGuide.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        buttonGuide.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8 * QUtils.optimizeRatio(), bottom: 0, right: 0)
        buttonGuide.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8 * QUtils.optimizeRatio())
        self.view.addSubview(buttonGuide)
        
        buttonGuide.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 14 * QUtils.optimizeRatio()).isActive = true
        buttonGuide.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonGuide.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        buttonGuide.heightAnchor.constraint(equalToConstant: buttonGuide.layer.cornerRadius * 2).isActive = true
        
        buttonPrefer.translatesAutoresizingMaskIntoConstraints = false
        buttonPrefer.clipsToBounds = true
        buttonPrefer.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.6862745098, green: 0.1843137255, blue: 0.2156862745, alpha: 1)), for: .normal)
        buttonPrefer.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .highlighted)
        buttonPrefer.setTitle("이상형 설정", for: .normal)
        buttonPrefer.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonPrefer.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonPrefer.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonPrefer.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonPrefer.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.view.addSubview(buttonPrefer)
        
        buttonPrefer.topAnchor.constraint(equalTo: buttonGuide.bottomAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        buttonPrefer.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonPrefer.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: -4 * QUtils.optimizeRatio()).isActive = true
        buttonPrefer.heightAnchor.constraint(equalToConstant: buttonPrefer.layer.cornerRadius * 2).isActive = true
        
        buttonAvoidKnowns.translatesAutoresizingMaskIntoConstraints = false
        buttonAvoidKnowns.clipsToBounds = true
        buttonAvoidKnowns.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.9764705882, green: 0.3921568627, blue: 0.4352941176, alpha: 1)), for: .normal)
        buttonAvoidKnowns.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.6862745098, green: 0.1843137255, blue: 0.2156862745, alpha: 1)), for: .highlighted)
        buttonAvoidKnowns.setTitle("지인 만나지 않기", for: .normal)
        buttonAvoidKnowns.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonAvoidKnowns.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonAvoidKnowns.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonAvoidKnowns.layer.cornerRadius = buttonPrefer.layer.cornerRadius
        buttonAvoidKnowns.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.view.addSubview(buttonAvoidKnowns)
        
        buttonAvoidKnowns.centerYAnchor.constraint(equalTo: buttonPrefer.centerYAnchor).isActive = true
        buttonAvoidKnowns.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 4 * QUtils.optimizeRatio()).isActive = true
        buttonAvoidKnowns.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        buttonAvoidKnowns.heightAnchor.constraint(equalTo: buttonPrefer.heightAnchor).isActive = true
        
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonGuide:
            let viewController = BoardViewController(type: .notice)
            let navController = UINavigationController(rootViewController: viewController)
            self.present(navController, animated: true, completion: nil)
            break
            
        case buttonPrefer:
            let viewController = PreferLooksSettingViewController()
            let navController = UINavigationController(rootViewController: viewController)
            self.present(navController, animated: true, completion: nil)
            break
            
        case buttonAvoidKnowns:
            let viewController = AvoidKnownsSettingViewController()
            let navController = UINavigationController(rootViewController: viewController)
            self.present(navController, animated: true, completion: nil)
            break
            
        default:
            break
        }
    }
    
    func reloadData() {
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Main.Recommends + "\(MyData.shared.mem_idx)", method: .get, params: nil) { (isSucceed, errMessage, response) in
            guard let responseData = response as? [[String:Any]] else { return }
            
            self.collectionData.removeAll()
            
            self.collectionData.append(contentsOf: responseData.map({ (item) -> RecommendData in
                return RecommendData(with: item)
            }))
            self.collectionView.reloadData()
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
            
            (UIApplication.appDelegate().window?.rootViewController as? MainViewController)?.favouriteViewController.needToReload = true
            
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
