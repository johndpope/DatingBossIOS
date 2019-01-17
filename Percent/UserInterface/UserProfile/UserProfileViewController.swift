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
    
    private var constraintHeaderMoving: NSLayoutConstraint!
    private var constraintHeaderStick: NSLayoutConstraint!
    
    private let buttonProposal = UIButton(type: .custom)
    
    private var isProposalButtonShown = true
    
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
        self.navigationTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
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
        
        theCollectionView.topAnchor.constraint(equalTo: theTableView.topAnchor, constant: -kHeightNavigationView  - UIApplication.shared.statusBarFrame.size.height - 72 * QUtils.optimizeRatio()).isActive = true
        theCollectionView.widthAnchor.constraint(equalToConstant: UserPictureCollectionViewCell.itemSize.width).isActive = true
        theCollectionView.heightAnchor.constraint(equalToConstant: UserPictureCollectionViewCell.itemSize.height).isActive = true
        
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        theTableView.addSubview(pageControl)
        
        pageControl.centerXAnchor.constraint(equalTo: theTableView.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: theCollectionView.bottomAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        headerView.showProfile(false, animated: false)
        theTableView.addSubview(headerView)
        
        constraintHeaderMoving = headerView.topAnchor.constraint(equalTo: theCollectionView.bottomAnchor)
        constraintHeaderMoving.isActive = true
        constraintHeaderStick = headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        constraintHeaderStick.isActive = false
        headerView.leadingAnchor.constraint(equalTo: theCollectionView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: theCollectionView.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 72 * QUtils.optimizeRatio()).isActive = true
        
        statsView.translatesAutoresizingMaskIntoConstraints = false
        statsView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        theTableView.addSubview(statsView)
        
        statsView.topAnchor.constraint(equalTo: theCollectionView.bottomAnchor, constant:  72 * QUtils.optimizeRatio()).isActive = true
        statsView.leadingAnchor.constraint(equalTo: theCollectionView.leadingAnchor).isActive = true
        statsView.trailingAnchor.constraint(equalTo: theCollectionView.trailingAnchor).isActive = true
        
        reloadImages()
        reloadData()
        
        let tableFooterView = UIView()
        
        let labelContent = UILabel()
        labelContent.text = data.introduction
        labelContent.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelContent.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        labelContent.numberOfLines = 0
        labelContent.lineBreakMode = .byWordWrapping
        
        var frame = labelContent.frame
        frame.origin.x = 16 * QUtils.optimizeRatio()
        frame.origin.y = 16 * QUtils.optimizeRatio()
        frame.size.width = UIScreen.main.bounds.size.width - frame.origin.x * 2
        labelContent.frame = frame
        
        labelContent.sizeToFit()
        
        frame = tableFooterView.frame
        frame.size.width = UIScreen.main.bounds.size.width
        frame.size.height = labelContent.frame.maxY + 40 * QUtils.optimizeRatio()
        tableFooterView.frame = frame
        
        tableFooterView.addSubview(labelContent)
        
        theTableView.tableFooterView = tableFooterView
        
        theTableView.bringSubviewToFront(headerView)
        
        buttonProposal.translatesAutoresizingMaskIntoConstraints = false
        buttonProposal.clipsToBounds = true
        buttonProposal.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .normal)
        buttonProposal.setTitle("호감 보내기", for: .normal)
        buttonProposal.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonProposal.titleLabel?.font = UIFont.systemFont(ofSize: 18 * QUtils.optimizeRatio(), weight: .bold)
        buttonProposal.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonProposal.layer.cornerRadius = 22 * QUtils.optimizeRatio()
        self.view.addSubview(buttonProposal)
        
        buttonProposal.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        buttonProposal.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonProposal.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        buttonProposal.heightAnchor.constraint(equalToConstant: 44 * QUtils.optimizeRatio()).isActive = true

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var frame = CGRect.zero
        frame.size.width = theTableView.frame.size.width
        frame.size.height = theCollectionView.frame.size.height + statsView.frame.size.height - kHeightNavigationView  - UIApplication.shared.statusBarFrame.size.height
        
        let tableHeaderView = UIView()
        tableHeaderView.frame = frame
        tableHeaderView.isUserInteractionEnabled = false
        theTableView.tableHeaderView = tableHeaderView
        
        theTableView.contentInset = UIEdgeInsets(top: headerView.frame.size.height, left: 0, bottom: 0, right: 0)
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
            
            if let pData = self?.collectionData.first {
                self?.headerView.imageView.pin_setImage(from: pData.imageUrl)
            }
            
            self?.theCollectionView.reloadData()
            
            self?.pageControl.numberOfPages = self?.collectionData.count ?? 0
            self?.pageControl.currentPage = 0
            
            self?.view.layoutIfNeeded()
        }
    }
    
    func reloadData() {
        tableData.append(UserProfileTableData(iconName: "img_profile_1", content: "\(data.area ?? "")에 사는 \(data.age)세 \((data.blood_type ?? .A).rawValue.uppercased())형 \(data.sex == .female ? "여자" : "남자")입니다.", isApproved: nil))
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46 * QUtils.optimizeRatio()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionheaderView = UIView()
        sectionheaderView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: self.tableView(tableView, heightForHeaderInSection: section))
        sectionheaderView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = section == 0 ? "정보" : "하고 싶은 말"
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        sectionheaderView.addSubview(label)
        
        label.centerYAnchor.constraint(equalTo: sectionheaderView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: sectionheaderView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        
        return sectionheaderView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? tableData.count : 0
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard theCollectionView.frame.size.height > 0 else { return }
        
        let max = theCollectionView.frame.size.height - (kHeightNavigationView + UIApplication.shared.statusBarFrame.size.height) * 2 - headerView.frame.size.height
        var alpha = scrollView.contentOffset.y / max
        
        var isStick = false
        
        if alpha < 0 {
            alpha = 0
        } else if alpha > 1 {
            alpha = 1
            isStick = true
        }
        
        if alpha < 0.7, isProposalButtonShown == false {
            isProposalButtonShown = true
            
            buttonProposal.layer.removeAllAnimations()
            buttonProposal.isUserInteractionEnabled = false
            
            UIView.animate(withDuration: 0.3, animations: {
                self.buttonProposal.alpha = 1.0
            }) { (complete) in
                self.buttonProposal.isUserInteractionEnabled = true
            }
        } else if alpha >= 0.7, isProposalButtonShown {
            isProposalButtonShown = false
            
            buttonProposal.layer.removeAllAnimations()
            buttonProposal.isUserInteractionEnabled = false
            
            UIView.animate(withDuration: 0.3, animations: {
                self.buttonProposal.alpha = 0.0
            }) { (complete) in
                self.buttonProposal.isUserInteractionEnabled = false
            }
        }
        
        constraintHeaderMoving.isActive = !isStick
        constraintHeaderStick.isActive = isStick
        
        self.headerView.constraintValue = alpha
        
        self.navigationView.contentView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1).withAlphaComponent(alpha)
    }
}
