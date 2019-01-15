//
//  SignupProfileViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 09/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class SignupProfileViewController: BaseSignupStepsViewController {
    private let theTableView = UITableView()
    
    private let buttonConfirm = UIButton(type: .custom)
    
    private let entryViewEmail = SignupProfileTextEntryView()
    private let entryViewPassword = SignupProfileTextEntryView()
    private let entryViewRepeatPassword = SignupProfileTextEntryView()
    private let entryViewNickname = SignupProfileTextEntryView()
    
    private var isValidEmail = false
    private var isValidNickname = false
    
    private var started = false
    
    private let warnings = ["※ 잘못된 형식의 이메일입니다.", "※ 비밀번호는 영문 + 숫자 조합 6자리 이상으로 입력하세요.", "※ 비밀번호가 일치하지 않습니다.", "※ 닉네임은 두 글자 이상으로 입력하세요."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        labelTitle.text = "계정 정보 입력"
        
        var button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.resignAll), for: .touchUpInside)
        headerView.addSubview(button)
        
        button.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        
        button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.resignAll), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        entryViewEmail.translatesAutoresizingMaskIntoConstraints = false
        entryViewEmail.labelTitle.text = "이메일"
        entryViewEmail.textfield.text = UserPayload.shared.email
        entryViewEmail.textfield.keyboardType = .emailAddress
        entryViewEmail.textfield.returnKeyType = .next
        entryViewEmail.textfield.autocapitalizationType = .none
        entryViewEmail.textfield.delegate = self
        entryViewEmail.textfield.addTarget(self, action: #selector(self.textfieldDidChange(_:)), for: .editingChanged)
//        entryViewEmail.button.addTarget(self, action: #selector(self.resignAll), for: .touchUpInside)
        entryViewEmail.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        self.view.addSubview(entryViewEmail)
        
        entryViewEmail.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        entryViewEmail.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        entryViewEmail.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        entryViewEmail.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        var seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: entryViewEmail.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewPassword.translatesAutoresizingMaskIntoConstraints = false
        entryViewPassword.labelTitle.text = "비밀번호"
        entryViewPassword.textfield.keyboardType = .default
        entryViewPassword.textfield.isSecureTextEntry = true
        entryViewPassword.textfield.returnKeyType = .next
        entryViewPassword.textfield.delegate = self
        entryViewPassword.textfield.addTarget(self, action: #selector(self.textfieldDidChange(_:)), for: .editingChanged)
//        entryViewPassword.button.addTarget(self, action: #selector(self.resignAll), for: .touchUpInside)
        entryViewPassword.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        self.view.addSubview(entryViewPassword)
        
        entryViewPassword.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewPassword.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        entryViewPassword.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        entryViewPassword.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: entryViewPassword.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewRepeatPassword.translatesAutoresizingMaskIntoConstraints = false
        entryViewRepeatPassword.labelTitle.text = "비밀번호 확인"
        entryViewRepeatPassword.textfield.keyboardType = .default
        entryViewRepeatPassword.textfield.isSecureTextEntry = true
        entryViewRepeatPassword.textfield.returnKeyType = .next
        entryViewRepeatPassword.textfield.delegate = self
        entryViewRepeatPassword.textfield.addTarget(self, action: #selector(self.textfieldDidChange(_:)), for: .editingChanged)
//        entryViewRepeatPassword.button.addTarget(self, action: #selector(self.resignAll), for: .touchUpInside)
        entryViewRepeatPassword.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        self.view.addSubview(entryViewRepeatPassword)
        
        entryViewRepeatPassword.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewRepeatPassword.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        entryViewRepeatPassword.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        entryViewRepeatPassword.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: entryViewRepeatPassword.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        entryViewNickname.translatesAutoresizingMaskIntoConstraints = false
        entryViewNickname.labelTitle.text = "닉네임"
        entryViewNickname.textfield.text = UserPayload.shared.nickname
        entryViewNickname.textfield.keyboardType = .default
        entryViewNickname.textfield.returnKeyType = .done
        entryViewNickname.textfield.autocapitalizationType = .none
        entryViewNickname.textfield.delegate = self
        entryViewNickname.textfield.addTarget(self, action: #selector(self.textfieldDidChange(_:)), for: .editingChanged)
//        entryViewNickname.button.addTarget(self, action: #selector(self.resignAll), for: .touchUpInside)
        entryViewNickname.button.addTarget(self, action: #selector(self.pressedEntryButton(_:)), for: .touchUpInside)
        self.view.addSubview(entryViewNickname)
        
        entryViewNickname.topAnchor.constraint(equalTo: seperator.bottomAnchor).isActive = true
        entryViewNickname.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        entryViewNickname.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        entryViewNickname.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio()).isActive = true
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        self.view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: entryViewNickname.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        theTableView.translatesAutoresizingMaskIntoConstraints = false
        theTableView.separatorStyle = .none
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.alwaysBounceVertical = false
        theTableView.register(SignupProfileWarningTableViewCell.self, forCellReuseIdentifier: "SignupProfileWarningTableViewCell")
        self.view.addSubview(theTableView)
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(self.resignAll))
        theTableView.addGestureRecognizer(tapGestureRecognizer)
        
        theTableView.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        theTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        theTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        theTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        buttonConfirm.translatesAutoresizingMaskIntoConstraints = false
        buttonConfirm.clipsToBounds = true
        buttonConfirm.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .normal)
        buttonConfirm.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1)), for: .highlighted)
        buttonConfirm.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)), for: .disabled)
        buttonConfirm.setTitle("가입하기", for: .normal)
        buttonConfirm.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonConfirm.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonConfirm.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonConfirm.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonConfirm.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.view.addSubview(buttonConfirm)
        
        buttonConfirm.isEnabled = false
        
        buttonConfirm.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -7 * QUtils.optimizeRatio()).isActive = true
        buttonConfirm.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonConfirm.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        buttonConfirm.heightAnchor.constraint(equalToConstant: buttonConfirm.layer.cornerRadius * 2).isActive = true
        
        _ = entryViewEmail.textfield.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        leftNavigationItemView?.isHidden = true
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonConfirm:
            var errMessage: String?
            
            let email = entryViewEmail.textfield.text ?? ""
            let password = entryViewPassword.textfield.text ?? ""
            let repeatPassword = entryViewRepeatPassword.textfield.text
            let nickname = entryViewNickname.textfield.text ?? ""
            
            let digits = CharacterSet(charactersIn: "0123456789")
            let alphabets = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
            
            let hasDigits = password.rangeOfCharacter(from: digits) != nil
            let hasChars = password.rangeOfCharacter(from: alphabets) != nil
            let hasEnoughLength = password.count >= 6
            
            if email.count == 0 {
                errMessage = "이메일을 입력해주세요."
            } else if email.isValidEmail() == false {
                errMessage = "잘못된 형식의 이메일입니다."
            } else if isValidEmail == false {
                errMessage = "중복된 이메일입니다."
            } else if hasDigits == false || hasChars == false || hasEnoughLength == false {
                errMessage = "비밀번호는 영문+숫자 조합 6자리 이상으로 입력하세요."
            } else if password != repeatPassword {
                errMessage = "비밀번호가 일치하지 않습니다."
            } else if nickname.count < 2 {
                errMessage = "닉네임은 두 글자 이상으로 입력하세요."
            } else if isValidNickname == false {
                errMessage = "닉네임은 두 글자 이상으로 입력하세요."
            }
            
            guard errMessage == nil else {
                InstanceMessageManager.shared.showMessage(errMessage!, margin: buttonConfirm.frame.size.height + 8 * QUtils.optimizeRatio())
                return
            }
            
            UserPayload.shared.email = entryViewEmail.textfield.text
            UserPayload.shared.password = entryViewPassword.textfield.text
            UserPayload.shared.nickname = entryViewNickname.textfield.text
            
            LoadingIndicatorManager.shared.showIndicatorView()
            
            var params = [String:Any]()
            params["id"] = UserPayload.shared.email
            params["device_id"] = UUID().uuidString
            params["phone"] = UserPayload.shared.phone
            params["pw"] = UserPayload.shared.password?.sha256()
            params["name"] = UserPayload.shared.name
            params["nickname"] = UserPayload.shared.nickname
            params["sex"] = UserPayload.shared.gender.rawValue

            if let timeInterval = UserPayload.shared.birthDate {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMdd"
                params["birth"] = formatter.string(from: Date(timeIntervalSince1970: timeInterval))
            }

            params["fcm_key"] = UUID().uuidString

            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.Account.Signup, params: params) { (isSucceed, errMessage, response) in
                guard let responseData = response as? [String:Any], let status = responseData["Status"] as? String, status == "OK" else {
                    LoadingIndicatorManager.shared.hideIndicatorView()

                    InstanceMessageManager.shared.showMessage(kStringErrorUnknown, margin: self.buttonConfirm.frame.size.height + 8 * QUtils.optimizeRatio())
                    return
                }

                QDataManager.shared.registerStep = 1
                QDataManager.shared.commit()

                var params = [String:Any]()
                params["id"] = UserPayload.shared.email
                params["pw"] = UserPayload.shared.password?.sha256()
                params["app_version"] = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
                params["os"] = "ios"
                params["device_info"] = UIDevice.modelName

                let httpClient = QHttpClient()
                httpClient.request(to: RequestUrl.Account.Login, params: params) { (isSucceed, errMessage, response) in
                    LoadingIndicatorManager.shared.hideIndicatorView()
                    guard let responseData = response as? [String:Any], responseData["mem_idx"] as? Int != nil else {
                        InstanceMessageManager.shared.showMessage(kStringErrorUnknown, margin: self.buttonConfirm.frame.size.height + 8 * QUtils.optimizeRatio())
                        return
                    }

                    MyData.shared.setMyInfo(with: responseData)

                    QDataManager.shared.userId = UserPayload.shared.email
                    QDataManager.shared.password = UserPayload.shared.password
                    QDataManager.shared.commit()

                    var params = [String:Any]()
                    params["sign_up_fl"] = "p"

                    let httpClient = QHttpClient()
                    httpClient.request(to: RequestUrl.Account.ChangeStatus + "\(MyData.shared.mem_idx)", method: .patch, params: params, completion: nil)

                    let viewController = SignupProfileSpecsViewController()
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
            break
            
        default: break
        }
    }
    
    @objc private func pressedEntryButton(_ sender: UIButton) {
        guard let entryView = sender.superview as? SignupProfileTextEntryView else { return }
        _ = entryView.textfield.becomeFirstResponder()
    }
    
    @objc private func textfieldDidChange(_ textfield: UITextField) {
        if textfield.superview == entryViewEmail {
            let originValue = entryViewEmail.checked
            let newValue = textfield.text?.isValidEmail() ?? false
            entryViewEmail.checked = newValue
            
            if originValue != newValue {
                theTableView.reloadSections([0], with: .automatic)
            }
        } else if textfield.superview == entryViewPassword {
            let originValue = entryViewPassword.checked
            
            let password = textfield.text
            
            let digits = CharacterSet(charactersIn: "0123456789")
            let alphabets = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
            
            let hasDigits = (password ?? "").rangeOfCharacter(from: digits) != nil
            let hasChars = (password ?? "").rangeOfCharacter(from: alphabets) != nil
            let hasEnoughLength = (password ?? "").count >= 6
            
            let newValue = hasChars && hasDigits && hasEnoughLength
            entryViewPassword.checked = newValue
            
            var reload = originValue != newValue
            if entryViewRepeatPassword.checked {
                reload = true
                entryViewRepeatPassword.checked = false
            }
            
            if reload {
                theTableView.reloadSections([0], with: .automatic)
            }
        } else if textfield.superview == entryViewRepeatPassword {
            let originValue = entryViewRepeatPassword.checked
            
            let newValue = entryViewRepeatPassword.textfield.text == entryViewPassword.textfield.text && entryViewPassword.checked
            entryViewRepeatPassword.checked = newValue
            
            if originValue != newValue {
                theTableView.reloadSections([0], with: .automatic)
            }
        } else if textfield.superview == entryViewNickname {
            let originValue = entryViewNickname.checked
            
            let newValue = (entryViewNickname.textfield.text ?? "").count >= 2
            entryViewNickname.checked = newValue
            
            if originValue != newValue {
                theTableView.reloadSections([0], with: .automatic)
            }
        }
        
        buttonConfirm.isEnabled = entryViewEmail.checked && entryViewPassword.checked && entryViewRepeatPassword.checked && entryViewNickname.checked
    }
    
    @objc private func resignAll() {
        _ = entryViewEmail.textfield.resignFirstResponder()
        _ = entryViewPassword.textfield.resignFirstResponder()
        _ = entryViewRepeatPassword.textfield.resignFirstResponder()
        _ = entryViewNickname.textfield.resignFirstResponder()
    }
}

extension SignupProfileViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard textField == entryViewEmail.textfield, started == false else { return }
        started = true
        theTableView.reloadData()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        var errMessage: String?
        
        if textField == entryViewEmail.textfield {
            let email = entryViewEmail.textfield.text ?? ""
            if email.count == 0 {
                errMessage = "이메일을 입력해주세요."
            } else if email.isValidEmail() == false {
                errMessage = "잘못된 형식의 이메일입니다."
            }
        } else if textField == entryViewPassword.textfield {
            let password = entryViewPassword.textfield.text ?? ""
            
            let digits = CharacterSet(charactersIn: "0123456789")
            let alphabets = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
            
            let hasDigits = password.rangeOfCharacter(from: digits) != nil
            let hasChars = password.rangeOfCharacter(from: alphabets) != nil
            let hasEnoughLength = password.count >= 6
            
            if hasDigits == false || hasChars == false || hasEnoughLength == false {
                errMessage = "비밀번호는 영문+숫자 조합 6자리 이상으로 입력하세요."
            }
        } else if textField == entryViewRepeatPassword.textfield {
            if textField.text ?? "" != entryViewPassword.textfield.text {
                errMessage = "비밀번호가 일치하지 않습니다."
            }
        } else if textField == entryViewNickname.textfield {
            if (textField.text ?? "").count < 2 {
                errMessage = "닉네임은 두 글자 이상으로 입력하세요."
            }
        }
        
        guard errMessage == nil else {
            InstanceMessageManager.shared.showMessage(errMessage!, margin: 280)
            return
        }
        
        guard textField == entryViewEmail.textfield || textField == entryViewNickname.textfield else { return }
        
        var params = [String:Any]()
        if textField == entryViewEmail.textfield {
            params["id"] = textField.text
        } else {
            params["nickname"] = textField.text
        }
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Account.Validate, params: params) { (isSucceed, errMessage, response) in
            guard let responseData = response as? [String:Any], responseData["Status"] as? String == "OK" else {
                InstanceMessageManager.shared.showMessage(textField == self.entryViewEmail.textfield ? "중복된 이메일입니다." : "중복된 닉네임입니다.", margin: 280)
                
                if textField == self.entryViewEmail.textfield {
                    self.isValidEmail = false
                    self.entryViewEmail.checked = false
                } else {
                    self.isValidNickname = false
                    self.entryViewNickname.checked = false
                }
                return
            }
            
            if textField == self.entryViewEmail.textfield {
                self.isValidEmail = true
            } else {
                self.isValidNickname = true
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == entryViewEmail.textfield {
            _ = entryViewPassword.textfield.becomeFirstResponder()
            return false
        } else if textField == entryViewPassword.textfield {
            _ = entryViewRepeatPassword.textfield.becomeFirstResponder()
            return false
        } else if textField == entryViewRepeatPassword.textfield {
            _ = entryViewNickname.textfield.becomeFirstResponder()
            return false
        } else if textField == entryViewNickname.textfield {
            _ = entryViewNickname.textfield.resignFirstResponder()
        }
        
        return true
    }
}

extension SignupProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resignAll()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return warnings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard started else { return 0 }
        
        if (indexPath.row == 0 && !entryViewEmail.checked)
            || (indexPath.row == 1 && !entryViewPassword.checked)
            || (indexPath.row == 2 && !entryViewRepeatPassword.checked)
            || (indexPath.row == 3 && !entryViewNickname.checked) {
            return 22 * QUtils.optimizeRatio()
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SignupProfileWarningTableViewCell") as? SignupProfileWarningTableViewCell else { return  UITableViewCell() }
        
        cell.labelTitle.isHidden = self.tableView(tableView, heightForRowAt: indexPath) == 0
        cell.labelTitle.text = warnings[indexPath.row]
        return cell
    }
}

class SignupProfileWarningTableViewCell: UITableViewCell {
    let labelTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.contentView.clipsToBounds = true
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.textColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        labelTitle.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        self.contentView.addSubview(labelTitle)
        
        labelTitle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
