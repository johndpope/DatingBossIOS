//
//  SignupIdVieWController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 09/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

import WebKit

class SignupIdViewController: BaseSignupViewController {
    private var theWebView: WKWebView!
    
    override init(navigationViewEffect effect: UIVisualEffect? = nil) {
        super.init(navigationViewEffect: effect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "본인 인증"
        
        let contentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        contentController.add(self, name: "idAuth")
        config.userContentController = contentController
        
        theWebView = WKWebView(frame: CGRect.zero, configuration: config)
        theWebView.translatesAutoresizingMaskIntoConstraints = false
        theWebView.navigationDelegate = self
        theWebView.uiDelegate = self
        self.view.addSubview(theWebView)
        
        theWebView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        theWebView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        theWebView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theWebView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        let urlRequest = URLRequest(url: URL(string: "http://www.lovecenthome.com/IdAuth/checkplus_main_ios.jsp")!)
        theWebView.load(urlRequest)
    }
}

extension SignupIdViewController: WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as?  [String:Any] else { return }
        
        UserPayload.shared.clear()
        
        UserPayload.shared.name = dict["name"] as? String
        UserPayload.shared.phone = dict["phone"] as? String
        
        if let dateString = dict["birth"] as? String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            UserPayload.shared.birthDate = formatter.date(from: dateString)?.timeIntervalSince1970
        }
        
        UserPayload.shared.gender = Gender(rawValue: dict["sex"] as? String ?? "m") ?? .male
        
        UserPayload.shared.commit()
        
        let viewController = SignupStepViewController(step: 1)
        viewController.delegate = self
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
}

extension SignupIdViewController: SignupStepViewControllerDelegate {
    func signupStepViewController(doneProgress viewController: SignupStepViewController) {
        let newVc = SignupProfileViewController()
        self.navigationController?.pushViewController(newVc, animated: false)
        
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func signupStepViewController(titleOf viewController: SignupStepViewController) -> String? {
        return "프로필"
    }
}
