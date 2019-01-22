//
//  AvoidKnownsNoDataViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

import Contacts

class AvoidKnownsViewController: BaseViewController {
    let buttonContacts = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "지인 만나지 않기"
        
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentView)
        
        contentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "등록된 회원과 서로 추천되지 않습니다."
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18 * QUtils.optimizeRatio(), weight: .regular)
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        let bottomAnchor = label.bottomAnchor
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "※ 수집한 번호는 \'지인 만나지 않기\'기능 외에\n다른 용도로 쓰이지 않습니다."
        label.textColor = #colorLiteral(red: 0.6529199481, green: 0.2550097108, blue: 0.2336317599, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18 * QUtils.optimizeRatio(), weight: .regular)
        label.numberOfLines = 2
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: bottomAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        buttonContacts.translatesAutoresizingMaskIntoConstraints = false
        buttonContacts.clipsToBounds = true
        buttonContacts.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.6529199481, green: 0.2550097108, blue: 0.2336317599, alpha: 1)), for: .normal)
        buttonContacts.setTitle("연락처 불러오기", for: .normal)
        buttonContacts.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonContacts.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonContacts.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonContacts.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24 * QUtils.optimizeRatio(), bottom: 0, right: 24 * QUtils.optimizeRatio())
        buttonContacts.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        buttonContacts.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        contentView.addSubview(buttonContacts)
        
        buttonContacts.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonContacts.heightAnchor.constraint(equalToConstant: buttonContacts.layer.cornerRadius * 2).isActive = true
        buttonContacts.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        buttonContacts.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonContacts:
            let status = CNContactStore.authorizationStatus(for: .contacts)
            
            if status == .denied {
                let alertController = AlertPopupViewController(withTitle: "안내", message: "연락처 접근권한이 없습니다.\n설정에서 접근권한을 설정해주세요.")
                alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
                alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
                    
                    alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "설정으로 가기", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                print("Settings opened: \(success)") // Prints true
                            })
                        }
                    }))
                } else {
                    alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "확인", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
                }
                UIApplication.appDelegate().window?.addSubview(alertController.view)
                self.addChild(alertController)
                alertController.show()
                break
            }
            
            let store = CNContactStore()
            store.requestAccess(for: .contacts) { (isSucceed, error) in
                guard isSucceed else { return }
                
                let viewController = AvoidKnownsContactsViewController()
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            break
            
        default: break
        }
    }
}
