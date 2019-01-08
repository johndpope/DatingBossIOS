//
//  FindEmailPopupViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 08/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class FindEmailPopupViewController: BasePopupViewController {
    private let textfieldPhone = UITextField()
    
    private let buttonCancel = UIButton(type:.custom)
    private let buttonConfirm = UIButton(type:.custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = "이메일 찾기"
        labelTitle.textColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        
        var label = UILabel()
        label.text = "휴대폰 번호  "
        label.textColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 *  QUtils.optimizeRatio(), weight: .regular)
        label.sizeToFit()
        
        textfieldPhone.translatesAutoresizingMaskIntoConstraints = false
        textfieldPhone.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        textfieldPhone.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .regular)
        textfieldPhone.keyboardType = .phonePad
        textfieldPhone.autocorrectionType = .no
        textfieldPhone.borderStyle = .none
        textfieldPhone.leftView = label
        textfieldPhone.leftViewMode = .always
        contentView.addSubview(textfieldPhone)
        
        textfieldPhone.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        textfieldPhone.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        textfieldPhone.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24 * QUtils.optimizeRatio()).isActive = true
        textfieldPhone.heightAnchor.constraint(equalToConstant: 64 * QUtils.optimizeRatio()).isActive = true
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        contentView.addSubview(seperator)
        
        seperator.bottomAnchor.constraint(equalTo: textfieldPhone.bottomAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "휴대폰 번호를 입력해주시면\n문자로 이메일을 보내드립니다."
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
            _ = textfieldPhone.resignFirstResponder()
            
            guard let text = textfieldPhone.text, text.count > 0 else {
                let alertController = UIAlertController(title: nil, message: "휴대폰 번호를 입력하세요", preferredStyle: .alert)
                self.present(alertController, animated: true) {
                    _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (timer) in
                        timer.invalidate()
                        alertController.dismiss(animated: true, completion: {
                            _ = self.textfieldPhone.becomeFirstResponder()
                        })
                    })
                }
                break
            }
            
            var params = [String:Any]()
            params["sms_type"] = "email"
            params["phone"] = text
            
            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.Account.Find, params: params) { (isSucceed, errMessage, response) in
                guard let responseData = response as? [String:Any], let status = responseData["Status"] as? String, status != "Failed" else {
                    let alertController = UIAlertController(title: "", message: "가입 이력이 없는 번호입니다.", preferredStyle: .alert)
                    self.present(alertController, animated: true) {
                        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (timer) in
                            timer.invalidate()
                            alertController.dismiss(animated: true, completion: nil)
                        })
                    }
                    return
                }
                
                let alertController = UIAlertController(title: "", message: "문자로 이메일을 보내드렸습니다.", preferredStyle: .alert)
                self.present(alertController, animated: true) {
                    _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (timer) in
                        timer.invalidate()
                        alertController.dismiss(animated: true, completion: {() -> Void in
                            self.pressedButton(self.buttonCancel)
                        })
                    })
                }
            }
            break
            
        default: break
        }
    }
}
