//
//  CategoryViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class CategoryViewController: BaseMainViewController {
    private let theTableView = UITableView()
    
    private var tableData = [CategoryData]()
    
    override init(navigationViewEffect effect: UIVisualEffect? = nil) {
        super.init(navigationViewEffect: effect)
        
        showCherriesOnNavigation = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        let requesting = {() -> Void in
            guard indexPath.row < self.tableData.count else { return }
            
            LoadingIndicatorManager.shared.showIndicatorView()
            
            let data = self.tableData[indexPath.row]
            
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
                
                if let cherry_quantity = responseData["cherry_quantity"] as? Int {
                    MyData.shared.cherry_quantity = cherry_quantity
                    NotificationCenter.default.post(name: NotificationName.Cherry.Changed, object: cherry_quantity)
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
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Service.Free + "\(MyData.shared.mem_idx)", method: .get, headerValues: nil, params: nil) { (isSucceed, errMessage, response) in
            guard let responseData = response as? [String:Any], (responseData["category"] as? Int ?? 0) > 0 else {
                requesting()
                return
            }
            
            let alertController = AlertPopupViewController(withTitle: "무료 카테고리", message: "1일 1뢰 무료 카테고리를 사용합니다.")
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                requesting()
            }))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
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
