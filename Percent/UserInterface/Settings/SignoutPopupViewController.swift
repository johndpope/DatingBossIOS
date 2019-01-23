//
//  SignoutPopupViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 23/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class SignoutPopupViewController: BasePopupViewController {
    private let entryViewPassword = SignupProfileTextEntryView()
    
    private let buttonCancel = UIButton(type: .custom)
    private let buttonConfirm = UIButton(type: .custom)
    
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
        
        let width = 340 * QUtils.optimizeRatio()
        
        constraintWidth.constant = width
        constraintVertical.isActive = false
        contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -280 - UIApplication.appDelegate().window!.safeAreaInsets.bottom).isActive = true
        
        entryViewPassword.translatesAutoresizingMaskIntoConstraints = false
        entryViewPassword.labelTitle.text = "비밀번호"
        entryViewPassword.textfield.delegate = self
        entryViewPassword.textfield.isSecureTextEntry = true
        entryViewPassword.hideCheckIndicator = true
        entryViewPassword.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        contentView.addSubview(entryViewPassword)
        
        entryViewPassword.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        entryViewPassword.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -21 * QUtils.optimizeRatio()).isActive = true
        entryViewPassword.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        entryViewPassword.heightAnchor.constraint(equalToConstant: 50 * QUtils.optimizeRatio()).isActive = true
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: entryViewPassword.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let labelMessage = UILabel()
        labelMessage.translatesAutoresizingMaskIntoConstraints = false
        labelMessage.text = "* 탈퇴 후 1개월 뒤에 재가입할 수 있습니다."
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
        
        _ = entryViewPassword.textfield.becomeFirstResponder()
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
                InstanceMessageManager.shared.showMessage("비밀번호를 입력하세요.", margin: 260)
                return
            }
            
            guard password.sha256() == QDataManager.shared.password else {
                InstanceMessageManager.shared.showMessage("비밀번호가 일치하지 않습니다.", margin: 260)
                return
            }
            
            var params = [String:Any]()
            params["pw"] = password.sha256()
            
            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.Account.Unregister + "\(MyData.shared.mem_idx)", method: .delete, headerValues: nil, params: params) { (isSucceed, errMessage, response) in
                guard let status = (response as? [String:Any])?["Status"] as? String, status != "Failed" else { return }
                MyData.shared.clear()
                QDataManager.shared.password = nil
                QDataManager.shared.commit()
                
                let viewController = LoginViewController()
                UIApplication.appDelegate().changeRootViewController(viewController)
            }
            break
            
        default: break
        }
    }
    
    @objc private func pressedEntryButton(_ sender: UIButton) {
        _ = (sender.superview as? SignupProfileTextEntryView)?.textfield.becomeFirstResponder()
    }
}

extension SignoutPopupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.resignFirstResponder()
        return true
    }
}
