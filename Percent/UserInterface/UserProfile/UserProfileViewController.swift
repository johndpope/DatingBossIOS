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
    let content: NSAttributedString
    let isApproved: Bool?
}

class UserProfileViewController: BaseViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var data: UserData
    
    internal let buttonReport = UIButton(type: .custom)
    
    internal let theTableView =  UITableView()
    internal let theCollectionView: UICollectionView!
    internal let coverView = UIView()
    internal let pageControl = UIPageControl()
    
    internal let headerView: UserProfileHeaderView
    internal let statsView: UserProfileStatsView
    
    internal var collectionData = [PictureData]()
    
    internal var tableData = [UserProfileTableData]()
    
    internal var constraintHeaderMoving: NSLayoutConstraint!
    internal var constraintHeaderStick: NSLayoutConstraint!
    
    internal let buttonProposal = UIButton(type: .custom)
    
    internal var isProposalButtonShown = true
    
    internal var statsData = [String:[ChartValueData]]()
    
    internal var showRadarChart = false
    
    var searchParams: SearchParameters?
    
    internal let isMine: Bool
    
    init(navigationViewEffect effect: UIVisualEffect? = nil, data uData: UserData) {
        data = uData
        isMine = data.mem_idx == MyData.shared.mem_idx
        
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
        
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        self.view.addSubview(backView)
        
        backView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        backView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        backView.heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.size.height).isActive = true
        
        self.view.sendSubviewToBack(backView)
        
        theTableView.translatesAutoresizingMaskIntoConstraints = false
        theTableView.separatorStyle = .none
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.register(UserProfileSectionHeaderCell.self, forCellReuseIdentifier: "UserProfileSectionHeaderCell")
        theTableView.register(UserProfileTableViewCell.self, forCellReuseIdentifier: "UserProfileTableViewCell")
        theTableView.register(UserRadarChartTableViewCell.self, forCellReuseIdentifier: "UserRadarChartTableViewCell")
        self.view.addSubview(theTableView)
        
        theTableView.topAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        theTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        theTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        theCollectionView.translatesAutoresizingMaskIntoConstraints = false
        theCollectionView.clipsToBounds = false
        theCollectionView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        theCollectionView.isPagingEnabled = true
        theCollectionView.delegate = self
        theCollectionView.dataSource = self
        theCollectionView.register(UserPictureCollectionViewCell.self, forCellWithReuseIdentifier: "UserPictureCollectionViewCell")
        theTableView.addSubview(theCollectionView)
        
        theCollectionView.topAnchor.constraint(equalTo: theTableView.topAnchor, constant: -kHeightNavigationView - 72 * QUtils.optimizeRatio()).isActive = true
        theCollectionView.widthAnchor.constraint(equalToConstant: UserPictureCollectionViewCell.itemSize.width).isActive = true
        theCollectionView.heightAnchor.constraint(equalToConstant: UserPictureCollectionViewCell.itemSize.height).isActive = true
        
        coverView.translatesAutoresizingMaskIntoConstraints = false
        coverView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        coverView.alpha = 0
        coverView.isUserInteractionEnabled = false
        theTableView.addSubview(coverView)
        
        coverView.topAnchor.constraint(equalTo: theCollectionView.topAnchor).isActive = true
        coverView.bottomAnchor.constraint(equalTo: theCollectionView.bottomAnchor).isActive = true
        coverView.leadingAnchor.constraint(equalTo: theCollectionView.leadingAnchor).isActive = true
        coverView.trailingAnchor.constraint(equalTo: theCollectionView.trailingAnchor).isActive = true
        
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        theTableView.addSubview(pageControl)
        
        pageControl.centerXAnchor.constraint(equalTo: theTableView.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: theCollectionView.bottomAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        headerView.showProfile(false, animated: false)
        headerView.reloadData()
        theTableView.addSubview(headerView)
        
        headerView.buttonLike.isHidden = data.report_fl
        
        headerView.buttonLike.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        headerView.buttonEdit.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        
        constraintHeaderMoving = headerView.topAnchor.constraint(equalTo: theCollectionView.bottomAnchor)
        constraintHeaderMoving.isActive = true
        constraintHeaderStick = headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        constraintHeaderStick.isActive = false
        headerView.leadingAnchor.constraint(equalTo: theCollectionView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: theCollectionView.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 72 * QUtils.optimizeRatio()).isActive = true
        
        if isMine == false {
            statsView.translatesAutoresizingMaskIntoConstraints = false
            statsView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            theTableView.addSubview(statsView)
            
            statsView.topAnchor.constraint(equalTo: theCollectionView.bottomAnchor, constant:  72 * QUtils.optimizeRatio()).isActive = true
            statsView.leadingAnchor.constraint(equalTo: theCollectionView.leadingAnchor).isActive = true
            statsView.trailingAnchor.constraint(equalTo: theCollectionView.trailingAnchor).isActive = true
        }
        
        reloadTableFooterView()
        
        theTableView.bringSubviewToFront(headerView)
        
        buttonProposal.translatesAutoresizingMaskIntoConstraints = false
        buttonProposal.clipsToBounds = true
        buttonProposal.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .normal)
        buttonProposal.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.7018831372, green: 0.7020055652, blue: 0.7018753886, alpha: 1)), for: .disabled)
        buttonProposal.setTitle("호감 보내기", for: .normal)
        buttonProposal.setTitle("신고한 사용자", for: .disabled)
        buttonProposal.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonProposal.titleLabel?.font = UIFont.systemFont(ofSize: 18 * QUtils.optimizeRatio(), weight: .bold)
        buttonProposal.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonProposal.layer.cornerRadius = 22 * QUtils.optimizeRatio()
        self.view.addSubview(buttonProposal)
        
        buttonProposal.isEnabled = !data.report_fl
        buttonProposal.isHidden = isMine
        
        buttonProposal.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        buttonProposal.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonProposal.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        buttonProposal.heightAnchor.constraint(equalToConstant: 44 * QUtils.optimizeRatio()).isActive = true
        
        theTableView.contentInset = UIEdgeInsets(top: 72 * QUtils.optimizeRatio(), left: 0, bottom: 0, right: 0)
        
        reloadImages()
        reloadData()
        
        reloadStats()
        
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if initialized, isMine {
            LoadingIndicatorManager.shared.showIndicatorView()
            
            MyData.shared.reloadData { (isSucceed) in
                self.data = MyData.shared
                self.headerView.data = MyData.shared
                self.headerView.reloadData()
                
                self.reloadImages()
                self.reloadData()
                
                self.reloadStats()
                
                self.reloadTableFooterView()
                
                LoadingIndicatorManager.shared.hideIndicatorView()
                
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var frame = CGRect.zero
        frame.size.width = theTableView.frame.size.width
        frame.size.height = theCollectionView.frame.size.height + (isMine == false ? statsView.frame.size.height + 16 * QUtils.optimizeRatio() : 0) - kHeightNavigationView
        
        let tableHeaderView = UIView()
        tableHeaderView.frame = frame
        tableHeaderView.isUserInteractionEnabled = false
        theTableView.tableHeaderView = tableHeaderView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        statsView.startAnimating()
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case headerView.buttonLike:
            break
            
        case headerView.buttonEdit:
            UserPayload.shared.loadFromMyData {
                let viewController = EditProfileViewController()
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            break
            
        case buttonReport:
            guard data.report_fl == false else {
                InstanceMessageManager.shared.showMessage("이미 신고한 사용자입니다.")
                return
            }
            
            LoadingIndicatorManager.shared.showIndicatorView()
            
            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.Report + "\(MyData.shared.mem_idx)", method: .get, params: nil) { (isSucceed, errMessage, response) in
                LoadingIndicatorManager.shared.hideIndicatorView()
                
                guard let responseData = response as? [[String:Any]] else {
                    InstanceMessageManager.shared.showMessage(kStringErrorUnknown)
                    return
                }
                
                let dataArray = responseData.map({ (item) -> UserReportData in
                    return UserReportData(with: item)
                })
                
                let viewController = UserReportViewController(targetId: self.data.mem_idx, data: dataArray)
                viewController.delegate = self
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
            break
            
        default:
            break
        }
    }
    
    private func reloadTableFooterView() {
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
        tableData.removeAll()
        
        let norAttr = QTextAttributes(withForegroundColour: #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)).attributes
        let highAttr = QTextAttributes(withForegroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)).attributes
        
        var attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: data.area ?? "", attributes: searchParams?.region != nil ? highAttr : norAttr))
        attributedString.append(NSAttributedString(string: "에 사는 ", attributes: norAttr))
        attributedString.append(NSAttributedString(string: "\(data.age)", attributes: (searchParams?.minAge != nil || searchParams?.maxAge != nil) ? highAttr : norAttr))
        attributedString.append(NSAttributedString(string: "세 ", attributes: norAttr))
        attributedString.append(NSAttributedString(string: "\((data.blood_type ?? .A).rawValue.uppercased())", attributes: searchParams?.blood != nil ? highAttr : norAttr))
        attributedString.append(NSAttributedString(string: "형 \(data.sex == .female ? "여자" : "남자")입니다.", attributes: norAttr))
        tableData.append(UserProfileTableData(iconName: "img_profile_1", content: attributedString, isApproved: nil))
        
        attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "학력은 \(data.edu ?? "")", attributes: norAttr))
        if let school = data.school, school.count > 0 {
            attributedString.append(NSAttributedString(string: " (\(school)) ", attributes: norAttr))
        }
        attributedString.append(NSAttributedString(string: "입니다", attributes: norAttr))
        tableData.append(UserProfileTableData(iconName: "img_profile_2", content: attributedString, isApproved: nil))
        
        attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "제 직업은 \(data.job ?? "")", attributes: norAttr))
        if let job_etc = data.job_etc, job_etc.count > 0 {
            attributedString.append(NSAttributedString(string: " (\(job_etc)) ", attributes: norAttr))
        }
        attributedString.append(NSAttributedString(string: "입니다.", attributes: norAttr))
        tableData.append(UserProfileTableData(iconName: "img_profile_3", content: attributedString, isApproved: nil))
        
        attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "키는 ", attributes: norAttr))
        attributedString.append(NSAttributedString(string: "\(data.height)", attributes: (searchParams?.minHeight != nil || searchParams?.maxHeight != nil) ? highAttr : norAttr))
        attributedString.append(NSAttributedString(string: "cm이고 ", attributes: norAttr))
        attributedString.append(NSAttributedString(string: data.form ?? "", attributes: searchParams?.shape != nil ? highAttr : norAttr))
        attributedString.append(NSAttributedString(string: " 체형입니다.", attributes: norAttr))
        tableData.append(UserProfileTableData(iconName: "img_profile_4", content: attributedString, isApproved: nil))
        
        attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "종교는 ", attributes: norAttr))
        attributedString.append(NSAttributedString(string: data.religion ?? "", attributes: searchParams?.religion != nil ? highAttr : norAttr))
        attributedString.append(NSAttributedString(string: "입니다.", attributes: norAttr))
        tableData.append(UserProfileTableData(iconName: "img_profile_5", content: attributedString, isApproved: nil))
        
        attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "취미는 ", attributes: norAttr))
        attributedString.append(NSAttributedString(string: data.hobby ?? "", attributes: searchParams?.hobby != nil ? highAttr : norAttr))
        attributedString.append(NSAttributedString(string: "입니다.", attributes: norAttr))
        tableData.append(UserProfileTableData(iconName: "img_profile_6", content: attributedString, isApproved: nil))
        
        attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: data.drinking ?? "", attributes: searchParams?.drinking != nil ? highAttr : norAttr))
        tableData.append(UserProfileTableData(iconName: "img_profile_7", content: attributedString, isApproved: nil))
        
        attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: data.smoking ?? "", attributes: searchParams?.smoking != nil ? highAttr : norAttr))
        tableData.append(UserProfileTableData(iconName: "img_profile_8", content: attributedString, isApproved: nil))
        
        theTableView.reloadData()
    }
    
    override func loadNavigationItems() {
        super.loadNavigationItems()
        
        guard isMine == false else { return }
        
        buttonReport.translatesAutoresizingMaskIntoConstraints = false
        buttonReport.setImage(UIImage(named: "img_report")?.resize(maxWidth: 28), for: .normal)
        buttonReport.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        navigationView.contentView.addSubview(buttonReport)
        
        buttonReport.widthAnchor.constraint(equalToConstant: 52 * QUtils.optimizeRatio()).isActive = true
        buttonReport.heightAnchor.constraint(equalToConstant: kHeightNavigationView).isActive = true
        buttonReport.bottomAnchor.constraint(equalTo: navigationView.contentView.bottomAnchor).isActive = true
        buttonReport.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor, constant: -10 * QUtils.optimizeRatio()).isActive = true
        
        self.view.bringSubviewToFront(navigationView)
    }
    
    private func reloadStats() {
        var params = [String:Any]()
        params["opposite_mem_idx"] = data.mem_idx
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Account.GetStats + "\(MyData.shared.mem_idx)", params: params) { (isSucceed, errMessage, response) in
            guard let responseData = response as? [[String:Any]] else { return }
            
            self.statsData.removeAll()
            
            for i in 0 ..< responseData.count {
                let item = ChartValueData(with: responseData[i])
                guard let code = item.code else { continue }
                
                var dataArray = self.statsData[code] ?? []
                dataArray.append(item)
                self.statsData[code] = dataArray
            }
            
            self.theTableView.reloadData()
        }
    }
    
    @objc private func toggleExpandGraph(_ sender: UIButton) {
        showRadarChart = !showRadarChart
        sender.isSelected = showRadarChart
        
        theTableView.reloadData()
    }
}

extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        guard section > 0 else { return 0 }
//        return 46 * QUtils.optimizeRatio()
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard section > 0 else { return nil }
//
//        let sectionheaderView = UIView()
//        sectionheaderView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: self.tableView(tableView, heightForHeaderInSection: section))
//        sectionheaderView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
//
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = section == 1 ? "정보" : "하고싶은 말"
//        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
//        label.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
//        sectionheaderView.addSubview(label)
//
//        label.centerYAnchor.constraint(equalTo: sectionheaderView.centerYAnchor).isActive = true
//        label.leadingAnchor.constraint(equalTo: sectionheaderView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
//
//        if section == 1 {
//            let seperator = UIView()
//            seperator.translatesAutoresizingMaskIntoConstraints = false
//            seperator.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
//            sectionheaderView.addSubview(seperator)
//
//            seperator.topAnchor.constraint(equalTo: sectionheaderView.topAnchor).isActive = true
//            seperator.leadingAnchor.constraint(equalTo: sectionheaderView.leadingAnchor).isActive = true
//            seperator.trailingAnchor.constraint(equalTo: sectionheaderView.trailingAnchor).isActive = true
//            seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
//
//            let image = UIImage(named: "img_profile_expand_bg")!
//
//            let button = UIButton(type: .custom)
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.setBackgroundImage(image, for: .normal)
//            button.setImage(UIImage(named: "img_profile_expand")?.recolour(with: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)).resize(maxWidth: 24), for: .normal)
//            button.setImage(UIImage(named: "img_profile_collapsed")?.recolour(with: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)).resize(maxWidth: 24), for: .selected)
//            button.addTarget(self, action: #selector(self.toggleExpandGraph(_:)), for: .touchUpInside)
//            sectionheaderView.addSubview(button)
//
//            button.isSelected = showRadarChart
//
//            button.topAnchor.constraint(equalTo: sectionheaderView.topAnchor).isActive = true
//            button.centerXAnchor.constraint(equalTo: sectionheaderView.centerXAnchor).isActive = true
//            button.widthAnchor.constraint(equalToConstant: image.size.width).isActive = true
//            button.heightAnchor.constraint(equalToConstant: image.size.height).isActive = true
//        }
//
//        return sectionheaderView
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section > 0 else { return showRadarChart ? statsData.keys.count : 0 }
        return (section == 1 ? tableData.count : 0) + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.section > 0 else {
            guard showRadarChart, self.tableView(tableView, cellForRowAt: indexPath) as? UserRadarChartTableViewCell != nil else { return 0 }
            return 46 + UIScreen.main.bounds.size.width * 0.8
        }
        
        guard indexPath.row > 0 else {
            return UserProfileSectionHeaderCell.height + (indexPath.section > 1 ? 8 * QUtils.optimizeRatio() : 0)
        }
        return 56 * QUtils.optimizeRatio()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section > 0 else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserRadarChartTableViewCell") as? UserRadarChartTableViewCell else { return UITableViewCell() }
            cell.showLegend = indexPath.row == 0 && !isMine
            
            var titleString = "가치관"
            if indexPath.row == 1 {
                titleString = "성격"
            } else if indexPath.row == 2 {
                titleString = "연애스타일"
            }
            
            cell.labelTitle.text = titleString
            
            let keys = Array(self.statsData.keys).sorted()
            let key = keys[indexPath.row]
            cell.data = self.statsData[key]
            
            cell.reloadData()
            
            return cell
        }
        
        guard indexPath.row > 0 else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserProfileSectionHeaderCell") as? UserProfileSectionHeaderCell else { return UITableViewCell() }
            cell.labelTitle.text = indexPath.section == 1 ? "정보" : "하고싶은 말"
            cell.buttonExpander.addTarget(self, action: #selector(self.toggleExpandGraph(_:)), for: .touchUpInside)
            cell.buttonExpander.isSelected = self.showRadarChart
            cell.showExpander = indexPath.section == 1
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserProfileTableViewCell") as? UserProfileTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? UserProfileTableViewCell)?.data = tableData[indexPath.row - 1]
    }
}

extension UserProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = ImagePreviewViewController(images: collectionData, preselectedIndex: indexPath.row)
        UIApplication.appDelegate().window?.addSubview(viewController.view)
        self.addChild(viewController)
        
        viewController.show()
    }
    
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
        guard scrollView == theTableView else  { return }
        
        let stdOffset = scrollView.contentOffset.y + headerView.frame.size.height + kHeightNavigationView
        if stdOffset <= 0 {
            for cell in theCollectionView.visibleCells {
                guard let theCell = cell as? UserPictureCollectionViewCell else { continue }
                theCell.topConstraint.constant = stdOffset
                theCell.layoutIfNeeded()
            }
        }
        
        guard theCollectionView.frame.size.height > 0 else { return }
        
        let max = theCollectionView.frame.size.height - kHeightNavigationView - headerView.frame.size.height
        var alpha = (scrollView.contentOffset.y + headerView.frame.size.height) / max
        
        var isStick = false
        
        if alpha < 0 {
            alpha = 0
        } else if alpha > 1 {
            alpha = 1
            isStick = true
        }
        
        self.navigationView.contentView.backgroundColor = alpha == 1 ? #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1) : .clear
        
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
        
        self.coverView.alpha = alpha
    }
}

extension UserProfileViewController: UserReportViewControllerDelegate {
    func userReportViewController(didReport viewController: UserReportViewController) {
        buttonProposal.isEnabled = false
        headerView.buttonLike.isHidden = true
        
        data.report_fl = true
    }
}
