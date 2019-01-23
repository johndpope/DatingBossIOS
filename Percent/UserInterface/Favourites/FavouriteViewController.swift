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
    
    private var keys: [GatheringType] = [.read, .response, .request]
    private var collectionData = [GatheringType:[GatherData]]()
    
    private var pagingData: [Int] = [0, 0, 0]
    
    private var editMode = false
    
    private var selectedIndexPaths = [IndexPath]()
    
    var needToReload = true
    
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
        theCollectionView.allowsSelection = false
        theCollectionView.allowsMultipleSelection = false
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
        
        self.needToReload = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.editMode = false
        
        reloadData()
    }
    
    func reloadData() {
        guard needToReload else {
            self.theCollectionView.reloadData()
            return
        }
        
        needToReload = false
        
        self.pagingData  = [0, 0, 0]
        self.theCollectionView.reloadData()
        
        self.theCollectionView.setContentOffset(CGPoint.zero, animated: false)
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Main.Favourite + "\(MyData.shared.mem_idx)", method: .get, headerValues: nil, params: nil) { (isSucceed, errMessage, response) in
            guard let responseData = response as? [[String:Any]] else { return }
            
            self.collectionData.removeAll()
            
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
            
            theCollectionView.setContentOffset(CGPoint.zero, animated: true)
            return
        }
        
        
        self.pagingData[section] = paging
        
        theCollectionView.performBatchUpdates({
            self.pagingData[section] = paging
            
            let start = paging * 6
            var end = (paging + 1) * 6
            if end > dataArray.count {
                end = dataArray.count
            }
            
            var indexPaths = [IndexPath]()
            for i in start ..< end {
                indexPaths.append(IndexPath(row: i, section: section))
            }
            self.theCollectionView.insertItems(at: indexPaths)
        }) { (complete) in
            for subcell in self.theCollectionView.visibleCells {
                self.theCollectionView.bringSubviewToFront(subcell)
            }
        }
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
        
        let alertController = AlertPopupViewController(withTitle: "안내", message: "삭제하시겠습니까?\n삭제된 내용은 복구할 수 없습니다.")
        alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
        alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
            
            var read = [Int](), request = [Int](), response = [Int]()
            for i in 0 ..< self.selectedIndexPaths.count {
                let item = self.selectedIndexPaths[i]
                
                if item.section == 0 {
                    read.append(item.row)
                } else if item.section == 1 {
                    request.append(item.row)
                } else if item.section == 2 {
                    response.append(item.row)
                }
            }
            
            let requestRead = {(completion: (() -> Void)?) -> Void in
                if read.count > 0, let dataArray = self.collectionData[.read] {
                    var opposite_mem_idx = ""
                    for index in read {
                        if opposite_mem_idx.count > 0 {
                            opposite_mem_idx += ","
                        }
                        opposite_mem_idx += "\(dataArray[index].mem_idx)"
                    }
                    var params = [String:Any]()
                    params["opposite_mem_idx"] = opposite_mem_idx
                    
                    let httpClient = QHttpClient()
                    httpClient.request(to: RequestUrl.Main.Favourite + "read/\(MyData.shared.mem_idx)", method: .delete, headerValues: nil, params: params, completion: { (isSucceed, errMessage, response) in
                        completion?()
                    })
                } else {
                    completion?()
                }
            }
            
            let requestReq = {(completion: (() -> Void)?) -> Void in
                if request.count > 0, let dataArray = self.collectionData[.request] {
                    var opposite_mem_idx = ""
                    for index in request {
                        if opposite_mem_idx.count > 0 {
                            opposite_mem_idx += ","
                        }
                        opposite_mem_idx += "\(dataArray[index].mem_idx)"
                    }
                    var params = [String:Any]()
                    params["opposite_mem_idx"] = opposite_mem_idx
                    
                    let httpClient = QHttpClient()
                    httpClient.request(to: RequestUrl.Main.Favourite + "likereq/\(MyData.shared.mem_idx)", method: .delete, headerValues: nil, params: params, completion: { (isSucceed, errMessage, response) in
                        completion?()
                    })
                } else {
                    completion?()
                }
            }
            
            let requestRes = {(completion: (() -> Void)?) -> Void in
                if response.count > 0, let dataArray = self.collectionData[.response] {
                    var opposite_mem_idx = ""
                    for index in response {
                        if opposite_mem_idx.count > 0 {
                            opposite_mem_idx += ","
                        }
                        opposite_mem_idx += "\(dataArray[index].mem_idx)"
                    }
                    var params = [String:Any]()
                    params["opposite_mem_idx"] = opposite_mem_idx
                    
                    let httpClient = QHttpClient()
                    httpClient.request(to: RequestUrl.Main.Favourite + "likeres/\(MyData.shared.mem_idx)", method: .delete, headerValues: nil, params: params, completion: { (isSucceed, errMessage, response) in
                        completion?()
                    })
                } else {
                    completion?()
                }
            }
            
            requestRead({() -> Void in
                requestReq({() -> Void in
                    requestRes({() -> Void in
                        self.editMode = false
                        self.needToReload = true
                        self.reloadData()
                    })
                })
            })
            
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
//            self.editMode = false
//            self.selectedIndexPaths.removeAll()
//            self.theCollectionView.reloadData()
        }))
        UIApplication.appDelegate().window?.addSubview(alertController.view)
        self.addChild(alertController)
        alertController.show()
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
        guard let dataArray = collectionData[key], dataArray.count > 6 else { return CGSize.zero }
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: 44 *  QUtils.optimizeRatio())
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let key = keys[indexPath.section]
        let defaultCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UICollectionReusableView", for: indexPath)
        guard let dataArray = collectionData[key] else { return defaultCell }
        
        if kind ==  UICollectionView.elementKindSectionHeader {
            guard dataArray.count > 0, let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FavouriteHeaderView", for: indexPath) as? FavouriteHeaderView else { return defaultCell }
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
            guard dataArray.count > 6, let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FavouriteMoreView", for: indexPath) as? FavouriteMoreView else { return defaultCell }
            var buttonTitle = "접기"
            
            let paging = pagingData[indexPath.section]
            let maxCount = 6 * (paging + 1)
            
            if maxCount < dataArray.count {
                buttonTitle = "더 보기"
            }
            
            reusableView.tag = indexPath.section
            
            reusableView.button.setTitle(buttonTitle, for: .normal)
            reusableView.button.tag = indexPath.section
            reusableView.button.addTarget(self, action: #selector(self.loadMoreData(_:)), for: .touchUpInside)
            return reusableView
        }
        
        return defaultCell
    }
}

