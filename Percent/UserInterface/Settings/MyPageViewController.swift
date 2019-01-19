//
//  MyPageViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 24/11/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

enum MyPageType: String {
    case Profile = "img_mypage_2"
    case Settings = "img_mypage_3"
    case Purchase = "img_mypage_4"
    case Notice = "img_mypage_5"
    case Supports = "img_mypage_6"
    case Terms = "img_mypage_7"
    case Logout = ""
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
        
        tableData.append(MyPageData(type: .Profile, title: "프로필"))
        tableData.append(MyPageData(type: .Settings, title: "설정"))
        tableData.append(MyPageData(type: .Purchase, title: "퍼센트 충전"))
        tableData.append(MyPageData(type: .Notice, title: "공지사항"))
        tableData.append(MyPageData(type: .Supports, title: "고객센터"))
        tableData.append(MyPageData(type: .Terms, title: "이용약관 / 법적고지"))
        tableData.append(MyPageData(type: .Logout, title: "로그아웃"))
        
        theTableView.reloadData()
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = tableData[indexPath.row]
        
        switch data.type {
        case .Settings:
            let viewController = SettingsViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            break
            
        case .Notice, .Supports:
            let viewController = BoardViewController(type: data.type == .Supports ? .faq : .notice)
            self.navigationController?.pushViewController(viewController, animated: true)
            break
            
        case .Logout:
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
