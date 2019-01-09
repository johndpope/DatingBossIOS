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
    private let theWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "본인 인증"
        
        theWebView.translatesAutoresizingMaskIntoConstraints = false
        theWebView.navigationDelegate = self
        theWebView.uiDelegate = self
        self.view.addSubview(theWebView)
        
        theWebView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        theWebView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        theWebView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theWebView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        let urlRequest = URLRequest(url: URL(string: "http://www.lovecenthome.com/IdAuth/checkplus_main.jsp")!)
        theWebView.load(urlRequest)
    }
}

extension SignupIdViewController: WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        print("navigationAction.allHTTPHeaderFields")
//        print(navigationAction.request.allHTTPHeaderFields)
//
//        print("navigationAction.allHTTPHeaderFields")
//        print(navigationAction.request.)
//
//        decisionHandler(.allow)
//    }
//
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let urlString = navigationResponse.response.url?.absoluteString, urlString.range(of: "www.bossofdating.com/IdAuth/checkplus_success.jsp") != nil else {
            decisionHandler(.allow)
            return
        }
        
        let viewController = SignupStepViewController(step: 1)
        self.navigationController?.present(viewController, animated: true, completion: nil)
        
        decisionHandler(.allow)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("userContentController")
        print(message.body)
    }
}
