//
//  ChangePasswordPopupViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 23/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class ChangePasswordPopupViewController: BasePopupViewController {
    private let entryViewPassword = SignupProfileTextEntryView()
    private let entryViewNewPassword = SignupProfileTextEntryView()
    private let entryViewRepeatPassword = SignupProfileTextEntryView()
    
    private let buttonCancel = UIButton(type: .custom)
    private let buttonConfirm = UIButton(type: .custom)
    
    private let labelMessage = UILabel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = "서비스 탈퇴"
        
        entryViewPassword.translatesAutoresizingMaskIntoConstraints = false
        entryViewPassword.labelTitle.text = "기존 비밀번호"
        entryViewPassword.textfield.isSecureTextEntry = true
        entryViewPassword.hideCheckIndicator = true
        contentView.addSubview(entryViewPassword)
        
        entryViewPassword.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        entryViewPassword.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        entryViewPassword.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        entryViewPassword.heightAnchor.constraint(equalToConstant: 50 * QUtils.optimizeRatio()).isActive = true
        
        var seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: entryViewPassword.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewNewPassword.translatesAutoresizingMaskIntoConstraints = false
        entryViewNewPassword.labelTitle.text = "새 비밀번호"
        entryViewNewPassword.textfield.isSecureTextEntry = true
        contentView.addSubview(entryViewNewPassword)
        
        entryViewNewPassword.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewNewPassword.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        entryViewNewPassword.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        entryViewNewPassword.heightAnchor.constraint(equalToConstant: 50 * QUtils.optimizeRatio()).isActive = true
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: entryViewNewPassword.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewRepeatPassword.translatesAutoresizingMaskIntoConstraints = false
        entryViewRepeatPassword.labelTitle.text = "비밀번호 확인"
        entryViewRepeatPassword.textfield.isSecureTextEntry = true
        contentView.addSubview(entryViewRepeatPassword)
        
        entryViewRepeatPassword.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewRepeatPassword.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        entryViewRepeatPassword.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        entryViewRepeatPassword.heightAnchor.constraint(equalToConstant: 50 * QUtils.optimizeRatio()).isActive = true
        
        labelMessage.translatesAutoresizingMaskIntoConstraints = false
        labelMessage.textColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        labelMessage.textAlignment = .center
        labelMessage.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .medium)
        labelMessage.numberOfLines = 0
        contentView.addSubview(labelMessage)
        
        labelMessage.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        labelMessage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15 * QUtils.optimizeRatio()).isActive = true
        labelMessage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15 * QUtils.optimizeRatio()).isActive = true
        
        
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.clipsToBounds = true
        buttonCancel.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)), for: .normal)
        buttonCancel.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), for: .highlighted)
        buttonCancel.setTitle("취소", for: .normal)
        buttonCancel.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonCancel.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonCancel.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonCancel.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        contentView.addSubview(buttonCancel)
        
        buttonCancel.topAnchor.constraint(equalTo: labelMessage.bottomAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        buttonCancel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        buttonCancel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        buttonCancel.heightAnchor.constraint(equalToConstant: 50 * QUtils.optimizeRatio()).isActive = true
        buttonCancel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        buttonConfirm.translatesAutoresizingMaskIntoConstraints = false
        buttonConfirm.clipsToBounds = true
        buttonConfirm.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .normal)
        buttonConfirm.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1)), for: .highlighted)
        buttonConfirm.setTitle("시작", for: .normal)
        buttonConfirm.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonConfirm.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonConfirm.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonConfirm.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        contentView.addSubview(buttonConfirm)
        
        buttonConfirm.topAnchor.constraint(equalTo: buttonCancel.topAnchor).isActive = true
        buttonConfirm.leadingAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        buttonConfirm.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        buttonConfirm.heightAnchor.constraint(equalTo: buttonCancel.heightAnchor).isActive = true
        
        self.view.layoutIfNeeded()
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonCancel:
            hide { (complete) in
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
            break
            
        case buttonConfirm:
            guard let password = entryViewPassword.textfield.text, password.count > 0 else {
                InstanceMessageManager.shared.showMessage("기존 비밀번호를 입력하세요.", margin: 260)
                return
            }
            
            if entryViewPassword.textfield.text?.sha256() != QDataManager.shared.password {
                InstanceMessageManager.shared.showMessage("기존 비밀번호가 일치하지 않습니다.", margin: 260)
                return
            }
            
            if entryViewNewPassword.checked == false {
                InstanceMessageManager.shared.showMessage("비밀번호는 영문 + 숫자 조합 6자리 이상으로 입력하세요.", margin: 260)
                return
            }
            
            if entryViewRepeatPassword.checked == false {
                InstanceMessageManager.shared.showMessage("새 비밀번호가 일치하지 않습니다.", margin: 260)
                return
            }
            
            let newPassword = entryViewNewPassword.textfield.text?.sha256()
            
            var params = [String:Any]()
            params["pw"] = newPassword
            
            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.Account.Update + "\(MyData.shared.mem_idx)", method: .patch, headerValues: nil, params: params) { (isSucceed, errMessage, response) in
                guard let status = (response as? [String:Any])?["Status"] as? String else { return }
                
                if status == "Failed" {
                    InstanceMessageManager.shared.showMessage("기존 비밀번호가 일치하지 않습니다.", margin: 260)
                }
                
                QDataManager.shared.password = newPassword
                
                self.hide { (complete) in
                    self.view.removeFromSuperview()
                    self.removeFromParent()
                }
            }
            break
            
        default: break
        }
    }
    
    private func updateMessage() {
        var message: String?
        
        let password = entryViewNewPassword.textfield.text
        
        let digits = CharacterSet(charactersIn: "0123456789")
        let alphabets = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        
        let hasDigits = (password ?? "").rangeOfCharacter(from: digits) != nil
        let hasChars = (password ?? "").rangeOfCharacter(from: alphabets) != nil
        let hasEnoughLength = (password ?? "").count >= 6
        
        let newValue = hasChars && hasDigits && hasEnoughLength
        entryViewNewPassword.checked = newValue
        
        if entryViewNewPassword.checked {
            entryViewNewPassword.checked = false
        }
        
        if entryViewNewPassword.checked == false {
            message = "※ 비밀번호는 영문 + 숫자 조합 6자리 이상으로 입력하세요."
        }
        
        if entryViewRepeatPassword.textfield.text != password {
            if message != nil {
                message! += "\n"
            } else {
                message = ""
            }
            
            message! += "※ 비밀번호가 일치하지 않습니다."
        }
        
        labelMessage.text = message
        
        self.view.layoutIfNeeded()
    }
}
