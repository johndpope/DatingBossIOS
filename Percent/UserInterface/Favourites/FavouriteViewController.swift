//
//  FavouriteViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class FavouriteViewController: BaseMainViewController {
    private let theCollectionView: UICollectionView!
    
    private var keys: [GatheringType] = [.read, .request, .response]
    private var collectionData = [GatheringType:[GatherData]]()
    
    private var pagingData: [Int] = [0, 0, 0]
    
    private var editMode = false
    
    private var selectedIndexPaths = [IndexPath]()
    
    override init(navigationViewEffect effect: UIVisualEffect? = nil) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = FavouriteCollectionViewCell.sectionInset
        flowLayout.minimumLineSpacing = FavouriteCollectionViewCell.minimumLineSpacing
        flowLayout.minimumInteritemSpacing = FavouriteCollectionViewCell.minimumInteritemSpacing
        flowLayout.itemSize = FavouriteCollectionViewCell.itemSize
        theCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        
        super.init(navigationViewEffect: effect)
        
        showCherriesOnNavigation = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "모아보기"
        
        theCollectionView.translatesAutoresizingMaskIntoConstraints = false
        theCollectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        theCollectionView.register(FavouriteCollectionViewCell.self, forCellWithReuseIdentifier: "FavouriteCollectionViewCell")
        theCollectionView.register(FavouriteHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FavouriteHeaderView")
        theCollectionView.register(FavouriteMoreView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FavouriteMoreView")
        theCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "UICollectionReusableView")
        theCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "UICollectionReusableView")
        theCollectionView.delegate = self
        theCollectionView.dataSource = self
        self.view.addSubview(theCollectionView)
        
        theCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        theCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        theCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }
    
    func reloadData() {
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Main.Favourite + "\(MyData.shared.mem_idx)", method: .get, headerValues: nil, params: nil) { (isSucceed, errMessage, response) in
            guard let responseData = response as? [[String:Any]] else { return }
            
            self.collectionData.removeAll()
            
            self.pagingData  = [0, 0, 0]
            
            for i in 0 ..< responseData.count {
                let item = GatherData(with: responseData[i])
                guard let type = item.type else { continue }
                
                var dataArray = self.collectionData[type] ?? []
                dataArray.append(item)
                self.collectionData[type] = dataArray
            }
            
            self.theCollectionView.reloadData()
        }
    }
    
    @objc func loadMoreData(_ sender: UIButton) {
        let section = sender.tag
        let key = keys[section]
        let paging = pagingData[section] + 1
        guard let dataArray = collectionData[key]  else { return }
        
        guard 6 * paging < dataArray.count else {
            pagingData[section] = 0
            theCollectionView.reloadData()
            return
        }
        
        pagingData[section] = paging
        theCollectionView.reloadData()
    }
    
    @objc func toggleEditMode(_ sender: UIButton) {
        editMode = !editMode
        selectedIndexPaths.removeAll()
        theCollectionView.reloadData()
    }
    
    @objc func requestDelete(_ sender: UIButton) {
        guard selectedIndexPaths.count > 0 else {
            InstanceMessageManager.shared.showMessage("선택된 항목이 없습니다.", margin: self.view.safeAreaInsets.bottom)
            return
        }
//        
//        var read = [Int](), request = [Int](), response = [Int]()
//        for i in 0 ..< self.selectedIndexPaths.count {
//            let item = self.selectedIndexPaths[i]
//            
//            if item.section == 0 {
//                read.append(item.row)
//            } else if item.section == 1 {
//                request.append(item.row)
//            } else if item.section == 2 {
//                response.append(item.row)
//            }
//        }
//        
//        let completion = {() -> Void in
//            var dataArray = self.collectionData[.read] ?? []
//            for i in 0 ..< dataArray.count {
//                guard read.firstIndex(of: i) != nil else { continue }
//                _ = dataArray.remove(at: i)
//            }
//            self.collectionData[.read] = dataArray
//
//            dataArray = self.collectionData[.request] ?? []
//            for i in 0 ..< dataArray.count {
//                guard request.firstIndex(of: i) != nil else { continue }
//                _ = dataArray.remove(at: i)
//            }
//            self.collectionData[.request] = dataArray
//
//            dataArray = self.collectionData[.response] ?? []
//            for i in 0 ..< dataArray.count {
//                guard response.firstIndex(of: i) != nil else { continue }
//                _ = dataArray.remove(at: i)
//            }
//            self.collectionData[.response] = dataArray
//
//            self.theCollectionView.reloadData()
//        }
//
//        var params = [String:Any]()
    }
    
    @objc func selectCell(_ sender: UIButton) {
        guard let cell = (sender.superview?.superview as? FavouriteCollectionViewCell), let indexPath = cell.indexPath else { return }
        
        let key = keys[indexPath.section]
        guard let dataArray = collectionData[key] else { return }
        
        guard editMode == false else {
            var index: Int?
            for i in 0 ..< selectedIndexPaths.count {
                let anIndexPath = selectedIndexPaths[i]
                guard indexPath.section == anIndexPath.section, indexPath.row == anIndexPath.row else { continue }
                index = i
                break
            }
            
            if index != nil {
                _ = selectedIndexPaths.remove(at: index!)
            } else {
                selectedIndexPaths.append(indexPath)
            }
            
            cell.setSelected(index == nil, animated: true)
            return
        }
        
        let data = dataArray[indexPath.row]
        
        LoadingIndicatorManager.shared.showIndicatorView()
        
        data.reloadData { (isSucceed) in
            LoadingIndicatorManager.shared.hideIndicatorView()
            
            let viewController = UserProfileViewController(data: data)
            let navControlelr = UINavigationController(rootViewController: viewController)
            self.present(navControlelr, animated: true, completion: nil)
        }
    }
}

extension FavouriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let key = keys[section]
        guard let dataArray = collectionData[key] else { return 0}
        
        let paging = pagingData[section]
        let maxCount = 6 * (paging + 1)
        
        return dataArray.count > maxCount ? maxCount : dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionViewCell", for: indexPath) as? FavouriteCollectionViewCell else { return UICollectionViewCell() }
        
        cell.indexPath = indexPath
        cell.isEditMode = editMode
        
        var index: Int?
        for i in 0 ..< selectedIndexPaths.count {
            let anIndexPath = selectedIndexPaths[i]
            guard indexPath.section == anIndexPath.section, indexPath.row == anIndexPath.row else { continue }
            index = i
            break
        }
        
        cell.setSelected(index != nil, animated: false)
        cell.buttonSelection.addTarget(self, action: #selector(self.selectCell(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let key = keys[indexPath.section]
        guard let dataArray = collectionData[key] else { return }
        (cell as? FavouriteCollectionViewCell)?.data = dataArray[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let key = keys[section]
        guard let dataArray = collectionData[key], dataArray.count > 0 else { return CGSize.zero }
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: 46 *  QUtils.optimizeRatio())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let key = keys[section]
        guard let dataArray = collectionData[key], dataArray.count > 0 else { return CGSize.zero }
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: 44 *  QUtils.optimizeRatio())
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let key = keys[indexPath.section]
        let defaultCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UICollectionReusableView", for: indexPath)
        guard let dataArray = collectionData[key], dataArray.count > 0 else { return defaultCell }
        
        if kind ==  UICollectionView.elementKindSectionHeader {
            guard let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FavouriteHeaderView", for: indexPath) as? FavouriteHeaderView else { return defaultCell }
            var titleString = "내가 본 이성"
            
            if indexPath.section == 1 {
                titleString = "받은 호감"
            } else if indexPath.section == 2 {
                titleString = "보낸 호감"
            }
            
            reusableView.labelTitle.text = titleString
            
            if indexPath.section == 0 {
                reusableView.isEditMode = self.editMode
                
                reusableView.buttonConfirm.addTarget(self, action: #selector(self.requestDelete(_:)), for: .touchUpInside)
                reusableView.buttonCancel.addTarget(self, action: #selector(self.toggleEditMode(_:)), for: .touchUpInside)
                reusableView.buttonDelete.addTarget(self, action: #selector(self.toggleEditMode(_:)), for: .touchUpInside)
            } else {
                reusableView.isEditMode = nil
            }
            
            return reusableView
        } else if kind ==  UICollectionView.elementKindSectionFooter {
            guard let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FavouriteMoreView", for: indexPath) as? FavouriteMoreView else { return defaultCell }
            var buttonTitle = "접기"
            
            let paging = pagingData[indexPath.section]
            let maxCount = 6 * (paging + 1)
            
            if maxCount < dataArray.count {
                buttonTitle = "더 보기"
            }
            
            reusableView.button.setTitle(buttonTitle, for: .normal)
            reusableView.button.tag = indexPath.section
            reusableView.button.addTarget(self, action: #selector(self.loadMoreData(_:)), for: .touchUpInside)
            return reusableView
        }
        
        return defaultCell
    }
}

