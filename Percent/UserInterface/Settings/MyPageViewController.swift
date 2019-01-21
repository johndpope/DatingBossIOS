//
//  MyPageViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 24/11/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

enum MyPageType: String {
    case profile = "img_mypage_2"
    case settings = "img_mypage_3"
    case purchase = "img_mypage_4"
    case notice = "img_mypage_5"
    case supports = "img_mypage_6"
    case terms = "img_mypage_7"
    case preferLooks = "img_mypage_8"
    case avoidKnowns = "img_mypage_9"
    case events = "img_mypage_10"
    case logout = ""
}

struct MyPageData {
    let type: MyPageType
    let title: String
}

class MyPageViewController: BaseViewController {
    private let theTableView = UITableView()
    
    private var tableData = [MyPageData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "마이페이지"
        
        theTableView.translatesAutoresizingMaskIntoConstraints = false
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: "MyPageTableViewCell")
        theTableView.separatorStyle = .none
        self.view.addSubview(theTableView)
        
        theTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        theTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        theTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        reloadData()
    }
    
    private func reloadData() {
        tableData.removeAll()
        
        tableData.append(MyPageData(type: .avoidKnowns, title: "지인 만나지 않기"))
        tableData.append(MyPageData(type: .preferLooks, title: "이상형 설정"))
        tableData.append(MyPageData(type: .profile, title: "프로필"))
        tableData.append(MyPageData(type: .settings, title: "설정"))
        tableData.append(MyPageData(type: .purchase, title: "체리 충전"))
        tableData.append(MyPageData(type: .notice, title: "공지사항"))
        tableData.append(MyPageData(type: .events, title: "이벤트"))
        tableData.append(MyPageData(type: .supports, title: "고객센터"))
        tableData.append(MyPageData(type: .terms, title: "이용약관 / 개인정보 취급 방침"))
        tableData.append(MyPageData(type: .logout, title: "로그아웃"))
        
        theTableView.reloadData()
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = tableData[indexPath.row]
        
        switch data.type {
        case .avoidKnowns:
            let viewController = AvoidKnownsSettingViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            break
            
        case .preferLooks:
            let viewController = PreferLooksSettingViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            break
            
        case .profile:
            LoadingIndicatorManager.shared.showIndicatorView()
            
            MyData.shared.reloadData { (isSucceed) in
                LoadingIndicatorManager.shared.hideIndicatorView()
                let viewController = MyProfileViewController(data: MyData.shared)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            break
            
        case .settings:
            let viewController = SettingsViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            break
            
        case .notice/*, .supports*/, .events:
            var type = BoardType.notice
            if data.type == .supports {
                type = .faq
            } else if data.type == .events {
                type = .event
            }
            
            let viewController = BoardViewController(type: type)
            self.navigationController?.pushViewController(viewController, animated: true)
            break
            
        case .logout:
            QDataManager.shared.password = nil
            QDataManager.shared.commit()
            
            let viewController = LoginViewController()
            UIApplication.appDelegate().changeRootViewController(viewController)
            break
            
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MyPageTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell") as? MyPageTableViewCell else { return UITableViewCell() }
        cell.data = tableData[indexPath.row]
        return cell
    }
}
