//
//  SignupProfileSpecsViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 17/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

import AVFoundation
import Photos

import MobileCoreServices

class SignupProfileSpecsViewController: BaseEditProfileViewController {
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonConfirm:
            uploadProfile { (isSucceed) in
                guard isSucceed else { return }
                
                var params = [String:Any]()
                params["sign_up_fl"] = "s"
                
                let httpClient = QHttpClient()
                httpClient.request(to: RequestUrl.Account.ChangeStatus + "\(MyData.shared.mem_idx)", method: .patch, params: params, completion: nil)
                
                let viewController = SignupStepViewController(step: 2)
                viewController.delegate = self
                self.present(viewController, animated: true, completion: nil)
            }
            break
            
        case buttonCancel:
            let alertController = AlertPopupViewController(withTitle: "회원가입 중단", message: "회원가입을 중단하시겠습니까?")
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                let viewController = LoginViewController()
                UIApplication.appDelegate().changeRootViewController(viewController)
            }))
            self.view.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
            break
            
        default: break
        }
    }
    
    @objc override func signupStepViewController(doneProgress viewController: SignupStepViewController) {
        guard viewController.step != currentStep else {
            super.signupStepViewController(doneProgress: viewController)
            return
        }
        
        let viewController = SignupSurveyViewController(depth: 0)
        self.navigationController?.pushViewController(viewController, animated: false)
        
        viewController.dismiss(animated: true, completion: nil)
    }
    
    @objc override func signupStepViewController(titleOf viewController: SignupStepViewController) -> String? {
        guard viewController.step != currentStep else {
            return "프로필 설정"
        }
        return AppDataManager.shared.data["survey1"]?.first?.code_name
    }
}
