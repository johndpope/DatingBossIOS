//
//  TermsDetailViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 21/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

import WebKit

class TermsDetailViewController: BaseViewController {
    private let theWebView = WKWebView()
    
    private let data: TermsData
    
    init(navigationViewEffect effect: UIVisualEffect? = nil, data tData: TermsData) {
        data = tData
        super.init(navigationViewEffect: effect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = data.terms_title
        
        theWebView.translatesAutoresizingMaskIntoConstraints = false
        theWebView.scrollView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        self.view.addSubview(theWebView)
        
        theWebView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        theWebView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        theWebView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        theWebView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
        theWebView.loadHTMLString(data.terms_text ?? "", baseURL: nil)
    }
}
