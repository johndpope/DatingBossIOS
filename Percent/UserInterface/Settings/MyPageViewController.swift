//
//  MyPageViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 24/11/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

import MessageUI

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
//        tableData.append(MyPageData(type: .logout, title: "로그아웃"))
        
        theTableView.reloadData()
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = tableData[indexPath.row]
        
        switch data.type {
        case .avoidKnowns:
            let viewController = AvoidKnownsViewController()
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
            
        case .terms:
            let viewController = TermsViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
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
            
        case .supports:
            guard MFMailComposeViewController.canSendMail() else {
                let alertController = AlertPopupViewController(withTitle: "고객센터", message: "기기에서 메일을 보낼 수 없습니다.\n기기에 메일 설정이 되어 있는지 확인해 주세요.")
                alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
                alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
                alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "확인", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
                self.view.addSubview(alertController.view)
                self.addChild(alertController)
                alertController.show()
                return
            }
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setSubject("고객센터 문의 (\(MyData.shared.nickname ?? "") 님")
            mailComposer.setToRecipients([SUPPORT_EMAIL])
            
            var body = "\n\n\n*아래는 문제 해결을 위해 필요한 정보입니다. 지우지 말고 함께 보내주세요.\n\n"
            body += "AppInfo: iOS / " + UIDevice.current.systemVersion
            body += "Device Info: " + UIDevice.modelName
            body += "Device Display: \(UIScreen.main.bounds.size.width)x\(UIScreen.main.bounds.size.height)"
            
            mailComposer.setMessageBody(body, isHTML: false)
            self.present(mailComposer, animated: true, completion: nil)
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

extension MyPageViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension MyPageViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
