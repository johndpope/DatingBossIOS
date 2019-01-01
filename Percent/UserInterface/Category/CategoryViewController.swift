//
//  CategoryViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class CategoryViewController: BaseViewController {
    private let theTableView = UITableView()
    
    private var tableData = [CategoryData]()
    
    override func viewDidLoad() {
        self.title = "카테고리"
        
        super.viewDidLoad()
        
        theTableView.translatesAutoresizingMaskIntoConstraints = false
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        theTableView.separatorStyle = .none
        self.view.addSubview(theTableView)
        
        theTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        theTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        theTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        reloadData()
    }
    
    func reloadData() {
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Category.GetList + "\(MyData.shared.mem_idx)", method: .get, params: nil) { (isSucceed, errMessage, response) in
            self.tableData.removeAll()
            
            if let responseData = response as? [[String:Any]] {
                self.tableData.append(contentsOf: responseData.map({ (item) -> CategoryData in
                    return CategoryData(with: item)
                }))
            }
            
            self.theTableView.reloadData()
        }
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < tableData.count else { return }
        
        LoadingIndicatorManager.shared.showIndicatorView()
        
        let data = tableData[indexPath.row]
        
        var params = [String:Any]()
        params["category_idx"] = data.category_idx
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Category.GetList + "\(MyData.shared.mem_idx)", params: params) { (isSucceed, errMessage, response) in
            guard isSucceed, let responseData = response as? [String:Any], let mem_idx = responseData["mem_idx"] as? Int else {
                LoadingIndicatorManager.shared.hideIndicatorView()
                
                let alertController = UIAlertController(title: "카테고리", message: "추천 상대를 찾을 수 없습니다.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: kStringConfirm, style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            let userData = UserData()
            userData.mem_idx = mem_idx
            userData.reloadData { (isSucceed) in
                LoadingIndicatorManager.shared.hideIndicatorView()
                
                let viewController = UserProfileViewController(data: userData)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CategoryTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as? CategoryTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? CategoryTableViewCell)?.data = tableData[indexPath.row]
    }
}
