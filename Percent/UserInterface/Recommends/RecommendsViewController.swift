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
    
    private var collectionData = [RecommendData]()
    
    private let loadingQueue = DispatchQueue(label: "RecommendsViewController.loading", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    
    override init(navigationViewEffect effect: UIVisualEffect? = nil) {
        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
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
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecommendCollectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "RecommendCollectionHeaderReusableView")
        collectionView.register(RecommendsCollectionViewCell.self, forCellWithReuseIdentifier: "RecommendsCollectionViewCell")
        collectionView.register(RecommendCollectionFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "RecommendCollectionFooterReusableView")
        self.view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
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

extension RecommendsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: RecommendCollectionHeaderReusableView.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: RecommendCollectionFooterReusableView.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader, let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RecommendCollectionHeaderReusableView", for: indexPath) as? RecommendCollectionHeaderReusableView {
            return reusableView
        }
        if kind == UICollectionView.elementKindSectionFooter, let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RecommendCollectionFooterReusableView", for: indexPath) as? RecommendCollectionFooterReusableView {
            reusableView.delegate = self
            return reusableView
        }
        return UICollectionReusableView()
    }
}

extension RecommendsViewController: RecommendCollectionFooterReusableViewDelegate {
    func recommendCollectionFooterReusableView(_ view: RecommendCollectionFooterReusableView, didSelectButton button: UIButton) {
        
        switch button {
        case view.buttonGuide:
            let viewController = BoardViewController(type: .notice)
            viewController.showGuide = true
            let navController = UINavigationController(rootViewController: viewController)
            self.present(navController, animated: true, completion: nil)
            break
            
        case view.buttonPrefer:
            let viewController = PreferLooksSettingViewController()
            let navController = UINavigationController(rootViewController: viewController)
            self.present(navController, animated: true, completion: nil)
            break
            
        case view.buttonAvoidKnowns:
            let viewController = AvoidKnownsViewController()
            let navController = UINavigationController(rootViewController: viewController)
            self.present(navController, animated: true, completion: nil)
            break
            
        default:
            break
        }
    }
}
