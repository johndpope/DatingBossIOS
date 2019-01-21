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
        let requesting = {(free: Bool) -> Void in
            guard indexPath.row < self.tableData.count else { return }
            
            LoadingIndicatorManager.shared.showIndicatorView()
            
            let data = self.tableData[indexPath.row]
            
            var params = [String:Any]()
            params["category_idx"] = data.category_idx
            
            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.Category.GetList + "\(MyData.shared.mem_idx)", params: params) { (isSucceed, errMessage, response) in
                LoadingIndicatorManager.shared.hideIndicatorView()
                guard isSucceed, let responseData = response as? [String:Any], let mem_idx = responseData["mem_idx"] as? Int else {
                    let alertController = AlertPopupViewController(withTitle: "카테고리 결과", message: "카테고리에 맞는 회원이 없습니다.\n다른 카테고리를 선택하세요." + (free ? "" : "\n(체리 차감 안됨)"))
                    alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
                    alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
                    alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "확인", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
                    UIApplication.appDelegate().window?.addSubview(alertController.view)
                    self.addChild(alertController)
                    alertController.show()
                    return
                }
                
                if let cherry_quantity = responseData["cherry_quantity"] as? Int {
                    MyData.shared.cherry_quantity = cherry_quantity
                    NotificationCenter.default.post(name: NotificationName.Cherry.Changed, object: cherry_quantity)
                }
                
                let alertController = AlertPopupViewController(withTitle: "카테고리 결과", message: "카테고리에 맞는 회원을 찾았습니다." + (free ? " (무료)" : "\n체리 1개가 차감되었습니다."))
                alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
                alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
                alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "확인", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: {(action) -> Void in
                    LoadingIndicatorManager.shared.showIndicatorView()
                    
                    let userData = UserData()
                    userData.mem_idx = mem_idx
                    userData.reloadData { (isSucceed) in
                        LoadingIndicatorManager.shared.hideIndicatorView()
                        
                        (UIApplication.appDelegate().window?.rootViewController as? MainViewController)?.favouriteViewController.needToReload = true
                        
                        let viewController = UserProfileViewController(data: userData)
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                }))
                UIApplication.appDelegate().window?.addSubview(alertController.view)
                self.addChild(alertController)
                alertController.show()
            }
        }
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Service.Free + "\(MyData.shared.mem_idx)", method: .get, headerValues: nil, params: nil) { (isSucceed, errMessage, response) in
            var titleString = "유료 카테고리"
            var message = "체리 1개를 사용하여 확인하시겠습니까?\n내가 가진 체리 \(MyData.shared.cherry_quantity)개"
            var isFree = false
            
            if let responseData = response as? [String:Any], (responseData["category"] as? Int ?? 0) > 0 {
                titleString = "무료 카테고리"
                message = "1일 1회 무료 카테고리를 사용합니다."
                isFree = true
            }
            
            let alertController = AlertPopupViewController(withTitle: titleString, message: message)
            alertController.titleColour = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
            alertController.messageColour = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "취소", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "확인", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                requesting(isFree)
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
