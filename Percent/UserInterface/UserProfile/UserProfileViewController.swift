//
//  UserProfileViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 27/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

struct UserProfileTableData {
    let iconName: String
    let content: String
    let isApproved: Bool?
}

class UserProfileViewController: BaseViewController {
    let data: UserData
    
    private let theTableView =  UITableView()
    private let theCollectionView: UICollectionView!
    private let pageControl = UIPageControl()
    
    private let headerView: UserProfileHeaderView
    private let statsView: UserProfileStatsView
    
    private var collectionData = [PictureData]()
    
    private var tableData = [UserProfileTableData]()
    
    init(navigationViewEffect effect: UIVisualEffect? = nil, data uData: UserData) {
        data = uData
        
        headerView = UserProfileHeaderView(data: data)
        statsView  = UserProfileStatsView(data: data)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = UserPictureCollectionViewCell.itemSize
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        theCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        
        super.init(navigationViewEffect: effect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationView.contentView.backgroundColor = .clear
        
        self.navigationView.viewWithTag(kTagNavigationBottomLine)?.removeFromSuperview()
        
        theTableView.translatesAutoresizingMaskIntoConstraints = false
        theTableView.separatorStyle = .none
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.register(UserProfileTableViewCell.self, forCellReuseIdentifier: "UserProfileTableViewCell")
        self.view.addSubview(theTableView)
        
        theTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        theTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        theTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        theCollectionView.translatesAutoresizingMaskIntoConstraints = false
        theCollectionView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        theCollectionView.isPagingEnabled = true
        theCollectionView.delegate = self
        theCollectionView.dataSource = self
        theCollectionView.register(UserPictureCollectionViewCell.self, forCellWithReuseIdentifier: "UserPictureCollectionViewCell")
        theTableView.addSubview(theCollectionView)
        
        theCollectionView.topAnchor.constraint(equalTo: theTableView.topAnchor, constant: -kHeightNavigationView  - UIApplication.shared.statusBarFrame.size.height).isActive = true
        theCollectionView.widthAnchor.constraint(equalToConstant: UserPictureCollectionViewCell.itemSize.width).isActive = true
        theCollectionView.heightAnchor.constraint(equalToConstant: UserPictureCollectionViewCell.itemSize.height).isActive = true
        
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        theTableView.addSubview(pageControl)
        
        pageControl.centerXAnchor.constraint(equalTo: theTableView.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: theCollectionView.bottomAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        headerView.showProfile(false, animated: false)
        theTableView.addSubview(headerView)
        
        headerView.topAnchor.constraint(equalTo: theCollectionView.bottomAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: theCollectionView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: theCollectionView.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 72 * QUtils.optimizeRatio()).isActive = true
        
        statsView.translatesAutoresizingMaskIntoConstraints = false
        theTableView.addSubview(statsView)
        
        statsView.topAnchor.constraint(equalTo: theCollectionView.bottomAnchor, constant:  72 * QUtils.optimizeRatio()).isActive = true
        statsView.leadingAnchor.constraint(equalTo: theCollectionView.leadingAnchor).isActive = true
        statsView.trailingAnchor.constraint(equalTo: theCollectionView.trailingAnchor).isActive = true
        
        reloadImages()
        reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var frame = CGRect.zero
        frame.size.width = theTableView.frame.size.width
        frame.size.height = theCollectionView.frame.size.height + headerView.frame.size.height + statsView.frame.size.height - kHeightNavigationView  - UIApplication.shared.statusBarFrame.size.height
        
        let tableHeaderView = UIView()
        tableHeaderView.frame = frame
        tableHeaderView.isUserInteractionEnabled = false
        theTableView.tableHeaderView = tableHeaderView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        statsView.startAnimating()
    }
    
    private func reloadImages() {
        guard MyData.shared.mem_idx != -1 else { return }
        
        collectionData.removeAll()
        theCollectionView.reloadData()
        
        var params = [String:Any]()
        params["opposite_mem_idx"] = data.mem_idx
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Image.Info + "\(MyData.shared.mem_idx)", params: params) {[weak self] (isSucceed, message, response) in
            guard isSucceed, let responseData = response as? [[String:Any]] else { return }
            self?.collectionData.append(contentsOf: responseData.map({ (item) -> PictureData in
                let newData = PictureData(with: item)
                newData.mem_idx = self?.data.mem_idx ?? -1
                return newData
            }))
            self?.theCollectionView.reloadData()
            
            self?.pageControl.numberOfPages = self?.collectionData.count ?? 0
            self?.pageControl.currentPage = 0
            
            self?.view.layoutIfNeeded()
        }
    }
    
    func reloadData() {
        tableData.append(UserProfileTableData(iconName: "img_profile_1", content: "\(data.area ?? "")에 사는 \(data.age)세 \((data.blood_type ?? .A).rawValue.uppercased())형 \(data.sex == .female ? " 여자" : "남자")입니다.", isApproved: nil))
        tableData.append(UserProfileTableData(iconName: "img_profile_2", content: "학력은 \(data.edu ?? "")했습니다.", isApproved: nil))
        tableData.append(UserProfileTableData(iconName: "img_profile_3", content: "제 직업은 \(data.job ?? "") 입니다.", isApproved: nil))
        tableData.append(UserProfileTableData(iconName: "img_profile_4", content: "키는 \(data.height)cm이고, \(data.form ?? "")의 체형입니다.", isApproved: nil))
        tableData.append(UserProfileTableData(iconName: "img_profile_5", content: "종교는 \(data.religion ?? "") 입니다.", isApproved: nil))
        tableData.append(UserProfileTableData(iconName: "img_profile_6", content: "취미는 \(data.hobby ?? "") 입니다.", isApproved: nil))
        tableData.append(UserProfileTableData(iconName: "img_profile_7", content: data.drinking ?? "", isApproved: nil))
        tableData.append(UserProfileTableData(iconName: "img_profile_8", content: data.smoking ?? "", isApproved: nil))
        
        theTableView.reloadData()
    }
}

extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46 * QUtils.optimizeRatio()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: self.tableView(tableView, heightForHeaderInSection: section))
        headerView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "정보"
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        headerView.addSubview(label)
        
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56 * QUtils.optimizeRatio()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserProfileTableViewCell") as? UserProfileTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? UserProfileTableViewCell)?.data = tableData[indexPath.row]
    }
}

extension UserProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "UserPictureCollectionViewCell", for: indexPath) as? UserPictureCollectionViewCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let theCell = cell as? UserPictureCollectionViewCell else { return }
        theCell.url = collectionData[indexPath.row].imageUrl
    }
}

extension UserProfileViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int((targetContentOffset.pointee.x + scrollView.frame.size.width / 2) / scrollView.frame.size.width)
        pageControl.currentPage = index
    }
}
