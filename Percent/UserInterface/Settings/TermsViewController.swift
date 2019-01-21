//
//  TermsViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 21/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class TermsViewController: BaseViewController {
    private let theTableView = UITableView()
    
    private var tableData = [TermsData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "이용약관 / 개인정보 취급 방침"
        
        theTableView.translatesAutoresizingMaskIntoConstraints = false
        theTableView.separatorStyle = .none
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.register(TermsTableViewCell.self, forCellReuseIdentifier: "TermsTableViewCell")
        self.view.addSubview(theTableView)
        
        theTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        theTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        theTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        reloadData()
    }
    
    private func reloadData(_ completion: (() -> Void)? = nil) {
        LoadingIndicatorManager.shared.showIndicatorView()
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Service.GetTerms, method: .get, headerValues: nil, params: nil) { (isSucceed, errMessage, response) in
            LoadingIndicatorManager.shared.hideIndicatorView()
            
            guard isSucceed, let responseData = response as? [[String:Any]] else {
                InstanceMessageManager.shared.showMessage(kStringErrorUnknown)
                return
            }
            
            self.tableData.removeAll()
            
            self.tableData.append(contentsOf: responseData.map({ (item) -> TermsData in
                return TermsData(with: item)
            }))
            
            self.theTableView.reloadData()
            
            completion?()
        }
    }
    
}

extension TermsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = TermsDetailViewController(data: tableData[indexPath.row])
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TermsTableViewCell.heightCollapsed
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "TermsTableViewCell") as? TermsTableViewCell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? TermsTableViewCell)?.data = tableData[indexPath.row]
    }
}
