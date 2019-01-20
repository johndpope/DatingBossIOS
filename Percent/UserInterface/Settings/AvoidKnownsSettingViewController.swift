//
//  AvoidKnownsSettingViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class AvoidKnownsSettingViewController: BaseViewController {
    private var noDataViewController: AvoidKnownsNoDataViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "지인 만나지 않기"
        
        showNoDataView()
    }
    
    private func showNoDataView() {
        guard noDataViewController == nil else { return }
        
        noDataViewController = AvoidKnownsNoDataViewController()
        noDataViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(noDataViewController!)
        self.view.addSubview(noDataViewController!.view)
        
        noDataViewController!.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        noDataViewController!.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        noDataViewController!.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        noDataViewController!.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}
