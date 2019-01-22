//
//  SettingsViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 24/11/2018.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
    private let theTableView = UITableView()
    
    private var keys = [String]()
    private var tableData = [String:[SettingsData]]()
    private var backupData = [String:[SettingsData]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "설정"
        
        theTableView.translatesAutoresizingMaskIntoConstraints = false
        theTableView.separatorStyle = .none
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")
        theTableView.register(SettingsTableViewSwitchCell.self, forCellReuseIdentifier: "SettingsTableViewSwitchCell")
        self.view.addSubview(theTableView)
        
        theTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        theTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        theTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        reloadData()
    }
    
    func reloadData() {
        LoadingIndicatorManager.shared.showIndicatorView()
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Service.Settings + "\(MyData.shared.mem_idx)", method: .get, params: nil) { (isSucceed, errMessage, response) in
            LoadingIndicatorManager.shared.hideIndicatorView()
            
            guard isSucceed, let responseData = response as? [[String:Any]] else { return }
            
            self.keys.removeAll()
            self.tableData.removeAll()
            self.backupData.removeAll()
            
            var aDataArray = [SettingsData](), bDataArray = [SettingsData]()
            
            for i in 0 ..< responseData.count {
                let item = SettingsData(with: responseData[i])
                guard let setup_code = item.setup_code else { continue }
                switch setup_code {
                case "060", "070", "080":
                    bDataArray.append(item)
                    break
                    
                default:
                    aDataArray.append(item)
                    break
                }
            }
            
            var key = "푸시 알림"
            self.keys.append(key)
            self.tableData[key] = aDataArray
            self.backupData[key] = aDataArray
            
            key = "회원 관리"
            self.keys.append(key)
            self.tableData[key] = bDataArray
            self.backupData[key] = bDataArray
            
            self.theTableView.reloadData()
        }
    }
    
    @objc private func pressedSwitchButton(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? SettingsTableViewSwitchCell,
            let indexPath = cell.indexPath else { return }
        
        if indexPath.section == 0 {
            guard let dataArray = self.tableData[self.keys[1]] else { return }
            
            var liveAccount = false
            for item in dataArray {
                guard item.setup_code == "060" else { continue }
                liveAccount = !item.value
            }
            
            guard liveAccount else { return }
        }
        
        let key = keys[indexPath.section]
        guard var dataArray = tableData[key] else { return }
        
        let data = dataArray[indexPath.row]
        let value = !data.value
        
        let completion = {() -> Void in
            data.value = value
            dataArray[indexPath.row] = data
            self.tableData[key] = dataArray
            
            cell.switchView.set(on: value, animated: true)
            
            guard data.setup_code == "060", var dataArray = self.tableData[self.keys[0]] else { return }
            
            for i in 0 ..< dataArray.count {
                let data = dataArray[i]
                data.value = !value
                dataArray[i] = data
            }
            self.tableData[self.keys[0]] = dataArray
            
            for cell in self.theTableView.visibleCells {
                guard let theCell = cell as? SettingsTableViewSwitchCell, theCell.indexPath?.section == 0 else { continue }
                theCell.switchView.set(on: !value, animated: true)
            }
        }
        
        LoadingIndicatorManager.shared.showIndicatorView()
        
        var params = [String:Any]()
        params["setup_code"] = data.setup_code
        params["setup_value"] = value ? "y" : "n"
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Service.Settings + "\(MyData.shared.mem_idx)", params: params) { (isSucceed, errMessage, response) in
            LoadingIndicatorManager.shared.hideIndicatorView()
            
            guard isSucceed else { return }
            
            completion()
        }
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = keys[indexPath.section]
        guard let dataArray = tableData[key] else { return }
        let data = dataArray[indexPath.row]
        
        guard data.toggle == false, let sType = data.type else { return }
        
        switch sType {
        case SettingsType.Destroy:
            let alertController = UIAlertController(title: "설정", message: "정말 서비스 탈퇴를 하시겠습니까?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "확인", style: .cancel, handler: { (action) -> Void in
                
            }))
            self.present(alertController, animated: true, completion: nil)
            break
            
        default: break
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46 * QUtils.optimizeRatio()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8 * QUtils.optimizeRatio()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var frame = CGRect.zero
        frame.size.width = tableView.frame.size.width
        frame.size.height = 46 * QUtils.optimizeRatio()
        let headerView = UIView(frame: frame)
        
        headerView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)

        let labelTitle = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.text = keys[section]
        labelTitle.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelTitle.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        headerView.addSubview(labelTitle)

        labelTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        labelTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true

        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var frame = CGRect.zero
        frame.size.width = tableView.frame.size.width
        frame.size.height = 8 * QUtils.optimizeRatio()
        let footerView = UIView(frame: frame)
        footerView.backgroundColor = .clear
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys[section]
        return tableData[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56 * QUtils.optimizeRatio()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = keys[indexPath.section]
        guard let dataArray = tableData[key] else { return UITableViewCell() }
        
        let data = dataArray[indexPath.row]
        
        var theCell: SettingsTableViewCell!
        
        if data.toggle {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewSwitchCell") as? SettingsTableViewSwitchCell else { return UITableViewCell() }
            cell.button.addTarget(self, action: #selector(self.pressedSwitchButton(_:)), for: .touchUpInside)
            theCell = cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as? SettingsTableViewCell else { return UITableViewCell() }
            theCell = cell
        }
        theCell.indexPath = indexPath
        
        return theCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let key = keys[indexPath.section]
        (cell as? SettingsTableViewCell)?.data = tableData[key]?[indexPath.row]
    }
}
