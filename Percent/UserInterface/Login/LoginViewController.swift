//
//  LoginViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 12/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

import AVFoundation
import Photos

class LoginViewController: BaseViewController {
    private let contentView = UIView()
    
    private let textFieldEmail = UITextField()
    private let textFieldPassword = UITextField()
    private let buttonFindEmail = UIButton(type: .custom)
    private let buttonFindPassword = UIButton(type: .custom)
    private let buttonLogin = UIButton(type: .custom)
    private let buttonSignup = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            PHPhotoLibrary.requestAuthorization({ (status) in
                
            })
        }
        
        self.setNavigationViewHidden(true, animated: false)
        
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "img_login_background")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.view.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        var button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.alpha = 0.0
        contentView.backgroundColor = .clear
        self.view.addSubview(contentView)
        
        contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        contentView.addSubview(button)
        
        button.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        let imageViewIcon = UIImageView()
        imageViewIcon.translatesAutoresizingMaskIntoConstraints = false
        imageViewIcon.image = UIImage(named: "img_login_icon")
        imageViewIcon.contentMode = .scaleAspectFit
        contentView.addSubview(imageViewIcon)
        
        imageViewIcon.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageViewIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageViewIcon.widthAnchor.constraint(equalToConstant: 76 * QUtils.optimizeRatio()).isActive = true
        imageViewIcon.heightAnchor.constraint(equalToConstant: 76 * QUtils.optimizeRatio()).isActive = true
        
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 2
        contentView.addSubview(backView)
        
        backView.topAnchor.constraint(equalTo: imageViewIcon.bottomAnchor, constant: 76 * QUtils.optimizeRatio()).isActive = true
        backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40 * QUtils.optimizeRatio()).isActive = true
        backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40 * QUtils.optimizeRatio()).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 114 * QUtils.optimizeRatio()).isActive = true
        
        var seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        backView.addSubview(seperator)
        
        seperator.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
        
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        textFieldEmail.placeholder = kStringLoginEmailPlaceholder
        textFieldEmail.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        textFieldEmail.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.returnKeyType = .next
        textFieldEmail.clearButtonMode = .whileEditing
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.delegate = self
        backView.addSubview(textFieldEmail)
        
        imageView = UIImageView()
        imageView.image = UIImage(named: "img_login_mail")
        imageView.contentMode = .scaleAspectFit
        imageView.sizeToFit()
        var frame = imageView.frame
        frame.size.width += 16 * QUtils.optimizeRatio()
        imageView.frame = frame
        textFieldEmail.leftView = imageView
        textFieldEmail.leftViewMode = .always
        
        textFieldEmail.topAnchor.constraint(equalTo: backView.topAnchor).isActive = true
        textFieldEmail.bottomAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        textFieldEmail.leadingAnchor.constraint(equalTo: backView.leadingAnchor).isActive = true
        textFieldEmail.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        textFieldPassword.placeholder = kStringLoginPasswordPlaceholder
        textFieldPassword.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        textFieldPassword.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textFieldPassword.returnKeyType = .send
        textFieldPassword.clearButtonMode = .whileEditing
        textFieldPassword.autocapitalizationType = .none
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.delegate = self
        backView.addSubview(textFieldPassword)
        
        imageView = UIImageView()
        imageView.image = UIImage(named: "img_login_lock")
        imageView.contentMode = .scaleAspectFit
        imageView.sizeToFit()
        frame = imageView.frame
        frame.size.width += 16 * QUtils.optimizeRatio()
        imageView.frame = frame
        textFieldPassword.leftView = imageView
        textFieldPassword.leftViewMode = .always
        
        textFieldPassword.topAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        textFieldPassword.bottomAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        textFieldPassword.leadingAnchor.constraint(equalTo: backView.leadingAnchor).isActive = true
        textFieldPassword.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        
        buttonFindPassword.translatesAutoresizingMaskIntoConstraints = false
        buttonFindPassword.setTitle(kStringLoginFindPassword, for: .normal)
        buttonFindPassword.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonFindPassword.setTitleColor(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), for: .highlighted)
        buttonFindPassword.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonFindPassword.contentEdgeInsets = UIEdgeInsets(top: 16 * QUtils.optimizeRatio(), left: 16 * QUtils.optimizeRatio(), bottom: 16 * QUtils.optimizeRatio(), right: 16 * QUtils.optimizeRatio())
        buttonFindPassword.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        contentView.addSubview(buttonFindPassword)
        
        buttonFindPassword.topAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        buttonFindPassword.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24 * QUtils.optimizeRatio()).isActive = true
        buttonFindPassword.heightAnchor.constraint(equalToConstant: 48 * QUtils.optimizeRatio()).isActive = true
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        contentView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: buttonFindPassword.topAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        seperator.bottomAnchor.constraint(equalTo: buttonFindPassword.bottomAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: buttonFindPassword.leadingAnchor).isActive = true
        seperator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        buttonFindEmail.translatesAutoresizingMaskIntoConstraints = false
        buttonFindEmail.setTitle(kStringLoginFindEmail, for: .normal)
        buttonFindEmail.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonFindEmail.setTitleColor(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), for: .highlighted)
        buttonFindEmail.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonFindEmail.contentEdgeInsets = UIEdgeInsets(top: 16 * QUtils.optimizeRatio(), left: 16 * QUtils.optimizeRatio(), bottom: 16 * QUtils.optimizeRatio(), right: 16 * QUtils.optimizeRatio())
        buttonFindEmail.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        contentView.addSubview(buttonFindEmail)
        
        buttonFindEmail.topAnchor.constraint(equalTo: buttonFindPassword.topAnchor).isActive = true
        buttonFindEmail.trailingAnchor.constraint(equalTo: seperator.leadingAnchor).isActive = true
        
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        buttonLogin.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .normal)
        buttonLogin.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), for: .highlighted)
        buttonLogin.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)), for: .disabled)
        buttonLogin.setTitle(kStringLoginLogin, for: .normal)
        buttonLogin.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonLogin.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonLogin.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonLogin.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        buttonLogin.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonLogin.clipsToBounds = true
        contentView.addSubview(buttonLogin)
        
        buttonLogin.topAnchor.constraint(equalTo: buttonFindEmail.bottomAnchor).isActive = true
        buttonLogin.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40 * QUtils.optimizeRatio()).isActive = true
        buttonLogin.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40 * QUtils.optimizeRatio()).isActive = true
        buttonLogin.heightAnchor.constraint(equalToConstant: buttonLogin.layer.cornerRadius * 2).isActive = true
        
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = kStringLoginSignupGuide + " "
//        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        label.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
//        label.sizeToFit()
//        contentView.addSubview(label)
//
//        var attributes = [NSAttributedString.Key:Any]()
//        attributes[.foregroundColor] = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        attributes[.font] = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .semibold)
//        attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
//        attributes[.underlineColor] = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//
//        buttonSignup.translatesAutoresizingMaskIntoConstraints = false
//        buttonSignup.setAttributedTitle(NSAttributedString(string: kStringLoginSignup, attributes: attributes), for: .normal)
//        attributes[.foregroundColor] = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
//        buttonSignup.setAttributedTitle(NSAttributedString(string: kStringLoginSignup, attributes: attributes), for: .highlighted)
//        buttonSignup.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
//        buttonSignup.sizeToFit()
//        contentView.addSubview(buttonSignup)
//
//        label.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
//        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: (UIScreen.main.bounds.size.width - label.frame.size.width - buttonSignup.frame.size.width) / 2).isActive = true
//
//        buttonSignup.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor).isActive = true
//        buttonSignup.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
//        buttonSignup.widthAnchor.constraint(equalToConstant: buttonSignup.frame.size.width + 32 * QUtils.optimizeRatio()).isActive = true
//        buttonSignup.heightAnchor.constraint(equalToConstant: buttonSignup.frame.size.height + 16 * QUtils.optimizeRatio()).isActive = true

        buttonSignup.translatesAutoresizingMaskIntoConstraints = false
        buttonSignup.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)), for: .normal)
        buttonSignup.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), for: .highlighted)
        buttonSignup.setTitle(kStringLoginSignup, for: .normal)
        buttonSignup.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonSignup.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonSignup.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonSignup.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        buttonSignup.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonSignup.clipsToBounds = true
        contentView.addSubview(buttonSignup)
        
        buttonSignup.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 12 * QUtils.optimizeRatio()).isActive = true
        buttonSignup.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40 * QUtils.optimizeRatio()).isActive = true
        buttonSignup.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40 * QUtils.optimizeRatio()).isActive = true
        buttonSignup.heightAnchor.constraint(equalToConstant: buttonLogin.layer.cornerRadius * 2).isActive = true
        buttonSignup.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        self.view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.contentView.alpha = 1.0
        }
        
        if ApplicationOptions.Build.Level == .DEVELOP {
            textFieldEmail.text = ApplicationOptions.TestInfo.ID
            textFieldPassword.text = ApplicationOptions.TestInfo.Password
        }
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        _ = textFieldEmail.resignFirstResponder()
        _ = textFieldPassword.resignFirstResponder()
        
        switch sender {
        case buttonLogin:
            var errMessage: String?
            var handler: ((UIAlertAction) -> Void)?
            
            if textFieldEmail.text?.count ?? 0 == 0 || textFieldEmail.text?.isValidEmail() == false {
                if textFieldEmail.text?.count ?? 0 == 0 {
                    errMessage = "이메일을 입력하세요."
                } else {
                    errMessage = "이메일 형식이 올바르지 않습니다."
                }
                
                handler = {(action) -> Void in
                    self.textFieldEmail.text = nil
                    self.textFieldPassword.text = nil
                    
                    _ = self.textFieldEmail.becomeFirstResponder()
                }
            } else if textFieldPassword.text?.count ?? 0 == 0 {
                errMessage = "비밀번호를 입력하세요asdad."
                handler = {(action) -> Void in
                    self.textFieldPassword.text = nil
                    
                    _ = self.textFieldPassword.becomeFirstResponder()
                }
            }
            
            guard errMessage == nil else {
                InstanceMessageManager.shared.showMessage(errMessage!)
                break
            }
            
            LoadingIndicatorManager.shared.showIndicatorView()
            
            var params = [String:Any]()
            params["id"] = textFieldEmail.text
            params["pw"] = textFieldPassword.text?.sha256()
            params["app_version"] = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
            params["os"] = "ios"
            params["device_info"] = UIDevice.modelName
            
            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.Account.Login, params: params) { (isSucceed, errMessage, response) in
                LoadingIndicatorManager.shared.hideIndicatorView()
                guard isSucceed, let responseData = response as? [String:Any] else {
                    InstanceMessageManager.shared.showMessage("로그인 정보가 유효하지 않습니다.")
                    return
                }
                
                MyData.shared.setMyInfo(with: responseData)
                
                QDataManager.shared.userId = self.textFieldEmail.text
                QDataManager.shared.password = self.textFieldPassword.text
                QDataManager.shared.commit()
                
                if MyData.shared.signupStatus == .complete {
                    let viewController = MainViewController()
                    UIApplication.appDelegate().changeRootViewController(viewController, animated: true)
                } else if MyData.shared.signupStatus == .profile {
                    let viewController = SignupProfileSpecsViewController()
                    let navController = SignupNavigationViewController(rootViewController: viewController)
                    UIApplication.appDelegate().changeRootViewController(navController, animated: true)
                }
            }
            break
            
        case buttonFindEmail:
            let viewController = FindEmailPopupViewController()
            self.view.addSubview(viewController.view)
            self.addChild(viewController)
            
            viewController.show()
            break
            
        case buttonFindPassword:
            let viewController = FindPasswordPopupViewController()
            self.view.addSubview(viewController.view)
            self.addChild(viewController)
            
            viewController.show()
            break
            
        case buttonSignup:
            let alertController = AlertPopupViewController(withTitle: "회원가입", message: "만 19세 이상만 가입이 가능합니다.\n계속 진행하시겠습니까?")
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "아니오", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "예", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let viewController = SignupGuideViewController()
                let navController = SignupNavigationViewController(rootViewController: viewController)
                self.present(navController, animated: true, completion: nil)
            }))
            self.view.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
            break
            
        default: break
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldEmail {
            _ = textFieldPassword.becomeFirstResponder()
            return false
        } else {
            pressedButton(buttonLogin)
        }
        
        return true
    }
}
