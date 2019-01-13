//
//  SignupTermsViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 12/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit


class SignupTermsViewController: BaseSignupViewController {
    private let theTableView = UITableView()
    
    private let buttonAgreeAll = UIButton(type: .custom)
    
    private let buttonCancel = UIButton(type: .custom)
    private let buttonConfirm = UIButton(type: .custom)
    
    private var tableData = [TermsData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "약관 동의"
        
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.clipsToBounds = true
        buttonCancel.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)), for: .normal)
        buttonCancel.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), for: .highlighted)
        buttonCancel.setTitle("취소", for: .normal)
        buttonCancel.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonCancel.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonCancel.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonCancel.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonCancel.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.view.addSubview(buttonCancel)
        
        buttonCancel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -7 * QUtils.optimizeRatio()).isActive = true
        buttonCancel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonCancel.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        buttonCancel.heightAnchor.constraint(equalToConstant: buttonCancel.layer.cornerRadius * 2).isActive = true
        
        buttonConfirm.translatesAutoresizingMaskIntoConstraints = false
        buttonConfirm.clipsToBounds = true
        buttonConfirm.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .normal)
        buttonConfirm.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1)), for: .highlighted)
        buttonConfirm.setTitle("본인인증", for: .normal)
        buttonConfirm.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonConfirm.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonConfirm.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonConfirm.layer.cornerRadius = buttonCancel.layer.cornerRadius
        buttonConfirm.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.view.addSubview(buttonConfirm)
        
        buttonConfirm.topAnchor.constraint(equalTo: buttonCancel.topAnchor).isActive = true
        buttonConfirm.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        buttonConfirm.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        buttonConfirm.heightAnchor.constraint(equalTo: buttonCancel.heightAnchor).isActive = true
        
        theTableView.translatesAutoresizingMaskIntoConstraints = false
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.separatorStyle = .none
        theTableView.register(SignupTermsTableViewCell.self, forCellReuseIdentifier: "SignupTermsTableViewCell")
        self.view.addSubview(theTableView)
        
        theTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        theTableView.bottomAnchor.constraint(equalTo: buttonCancel.topAnchor, constant: -7 * QUtils.optimizeRatio()).isActive = true
        theTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        theTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 16 * QUtils.optimizeRatio()))
        
        let tableFooterView = UIView()
        tableFooterView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 96 * QUtils.optimizeRatio())
        
        buttonAgreeAll.frame = CGRect(x: 16 * QUtils.optimizeRatio(), y: 24 * QUtils.optimizeRatio(), width: UIScreen.main.bounds.size.width - 32 * QUtils.optimizeRatio(), height: 48 * QUtils.optimizeRatio())
        buttonAgreeAll.clipsToBounds = true
        buttonAgreeAll.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        buttonAgreeAll.layer.borderWidth = 1
        buttonAgreeAll.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonAgreeAll.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), for: .normal)
        buttonAgreeAll.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .highlighted)
        buttonAgreeAll.setTitle("약관에 모두 동의", for: .normal)
        buttonAgreeAll.setTitleColor(#colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), for: .normal)
        buttonAgreeAll.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .highlighted)
        buttonAgreeAll.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        buttonAgreeAll.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        tableFooterView.addSubview(buttonAgreeAll)
        
        theTableView.tableFooterView = tableFooterView
    }
    
    func reloadData(_ completion: (() -> Void)? = nil) {
        LoadingIndicatorManager.shared.showIndicatorView()
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Service.GetTerms, method: .get, headerValues: nil, params: nil) { (isSucceed, errMessage, response) in
            LoadingIndicatorManager.shared.hideIndicatorView()
            
            guard isSucceed, let responseData = response as? [[String:Any]] else {
                InstanceMessageManager.shared.showMessage(kStringErrorUnknown, margin: self.buttonCancel.frame.size.height + 8 * QUtils.optimizeRatio())
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
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonAgreeAll:
            for i in 0 ..< tableData.count {
                let data = tableData[i]
                data.isAgreed = true
                tableData[i] = data
            }
            theTableView.reloadData()
            break
            
        case buttonCancel:
            self.navigationController?.popViewController(animated: true)
            break
            
        case buttonConfirm:
            var errMessage: String?
            
            for item in tableData {
                if item.isAgreed == false {
                    errMessage = "모든 약관에 동의해주세요"
                    break
                }
            }
            
            guard errMessage == nil else {
                InstanceMessageManager.shared.showMessage(errMessage!, margin: buttonCancel.frame.size.height + 8 * QUtils.optimizeRatio())
                return
            }
            
            let viewController = SignupIdViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            break
            
        default:
            break
        }
    }
    
    @objc private func pressedCellButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        let data = tableData[sender.tag]
        data.isAgreed = sender.isSelected
        tableData[sender.tag] = data
    }
}

extension SignupTermsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = SignupTermsDetailViewController(data: tableData[indexPath.row])
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64 * QUtils.optimizeRatio()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SignupTermsTableViewCell") as? SignupTermsTableViewCell else { return UITableViewCell() }
        
        let data = tableData[indexPath.row]
        
        var text = data.terms_title
        if data.indispensable_fl == false {
            text += " (선택사항)"
        }
        
        cell.labelTitle.text = text
        
        cell.buttonConfirm.tag = indexPath.row
        cell.buttonConfirm.isSelected = data.isAgreed
        cell.buttonConfirm.addTarget(self, action: #selector(self.pressedCellButton(_:)), for: .touchUpInside)
        return cell
    }
}
