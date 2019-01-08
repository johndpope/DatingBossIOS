//
//  FindPasswordPopupViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 08/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class FindPasswordPopupViewController: BasePopupViewController {
    private let textfieldEmail = UITextField()
    
    private let buttonCancel = UIButton(type:.custom)
    private let buttonConfirm = UIButton(type:.custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = "비밀번호 찾기"
        labelTitle.textColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        
        var label = UILabel()
        label.text = "이메일  "
        label.textColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 *  QUtils.optimizeRatio(), weight: .regular)
        label.sizeToFit()
        
        textfieldEmail.translatesAutoresizingMaskIntoConstraints = false
        textfieldEmail.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        textfieldEmail.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .regular)
        textfieldEmail.keyboardType = .namePhonePad
        textfieldEmail.autocorrectionType = .no
        textfieldEmail.borderStyle = .none
        textfieldEmail.leftView = label
        textfieldEmail.leftViewMode = .always
        contentView.addSubview(textfieldEmail)
        
        textfieldEmail.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        textfieldEmail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        textfieldEmail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24 * QUtils.optimizeRatio()).isActive = true
        textfieldEmail.heightAnchor.constraint(equalToConstant: 64 * QUtils.optimizeRatio()).isActive = true
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        contentView.addSubview(seperator)
        
        seperator.bottomAnchor.constraint(equalTo: textfieldEmail.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이메일을 입력해주시면\n문자로 임시 비밀번호를 보내드립니다."
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 *  QUtils.optimizeRatio(), weight: .regular)
        label.numberOfLines = 2
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)), for: .normal)
        buttonCancel.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), for: .highlighted)
        buttonCancel.setTitle("취소", for: .normal)
        buttonCancel.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonCancel.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonCancel.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonCancel.titleLabel?.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)
        contentView.addSubview(buttonCancel)
        
        buttonCancel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 32 * QUtils.optimizeRatio()).isActive = true
        buttonCancel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        buttonCancel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        buttonCancel.heightAnchor.constraint(equalToConstant: 64 * QUtils.optimizeRatio()).isActive = true
        buttonCancel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        buttonConfirm.translatesAutoresizingMaskIntoConstraints = false
        buttonConfirm.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .normal)
        buttonConfirm.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1)), for: .highlighted)
        buttonConfirm.setTitle("확인", for: .normal)
        buttonConfirm.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonConfirm.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonConfirm.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonConfirm.titleLabel?.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)
        contentView.addSubview(buttonConfirm)
        
        buttonConfirm.topAnchor.constraint(equalTo: buttonCancel.topAnchor).isActive = true
        buttonConfirm.leadingAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        buttonConfirm.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        buttonConfirm.heightAnchor.constraint(equalToConstant: 64 * QUtils.optimizeRatio()).isActive = true
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
            _ = textfieldEmail.resignFirstResponder()
            
            guard let text = textfieldEmail.text, text.count > 0 else {
                let alertController = UIAlertController(title: "", message: "이메일을 입력하세요", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                break
            }
            
            var params = [String:Any]()
            params["sms_type"] = "pw"
            params["email"] = text
            
            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.Account.Find, method: .get, params: params) { (isSucceed, errMessage, response) in
                guard isSucceed else {
                    let alertController = UIAlertController(title: "", message: errMessage ?? kStringErrorUnknown, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
                self.pressedButton(self.buttonCancel)
            }
            break
            
        default: break
        }
    }
}
