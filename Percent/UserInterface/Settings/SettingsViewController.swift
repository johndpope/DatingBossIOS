//
//  SettingsViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 24/11/2018.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit
//img_settings_1@3x.png
//img_settings_2@3x.png
//img_settings_3@3x.png
//img_settings_4@3x.png
//img_settings_5@3x.png
//img_settings_6@3x.png
//img_settings_7@3x.png
//img_settings_8@3x.png
//img_settings_9@3x.png


class SettingsViewController: BaseViewController {
    private let theTableView = UITableView()
    
    private var keys = [String]()
    private var tableData = [String:[SettingsData]]()
    private var backupData = [String:[SettingsData]]()
    
    private let buttonReset = UIButton(type: .custom)
    private let buttonSave = UIButton(type: .custom)
    
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
        
        buttonReset.translatesAutoresizingMaskIntoConstraints = false
        buttonReset.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)), for: .normal)
        buttonReset.setTitle("원래대로", for: .normal)
        buttonReset.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonReset.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonReset.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        self.view.addSubview(buttonReset)
        
//        buttonReset.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
//        buttonReset.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
//        buttonReset.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
//        buttonReset.heightAnchor.constraint(equalToConstant: 48 * QUtils.optimizeRatio()).isActive = true
//
//        buttonSave.translatesAutoresizingMaskIntoConstraints = false
//        buttonSave.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1)), for: .normal)
//        buttonSave.setTitle("설정 저장", for: .normal)
//        buttonSave.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
//        buttonSave.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
//        buttonSave.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
//        self.view.addSubview(buttonSave)
//
//        buttonSave.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
//        buttonSave.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
//        buttonSave.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
//        buttonSave.heightAnchor.constraint(equalToConstant: 48 * QUtils.optimizeRatio()).isActive = true
//
        reloadData()
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonReset:
            reloadData()
            break
            
        case buttonSave:
            break
            
        default: break
        }
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
            
            self.keys.append("aKey")
            
            var dataArray = [SettingsData]()
            dataArray.append(contentsOf: responseData.map({ (item) -> SettingsData in
                return SettingsData(with: item)
            }))
            self.tableData["aKey"] = dataArray
            self.backupData["aKey"] = dataArray
            
            self.theTableView.reloadData()
        }
    }
    
    @objc private func pressedSwitchButton(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? SettingsTableViewSwitchCell,
            let indexPath = cell.indexPath else { return }
        
        let key = keys[indexPath.section]
        guard var dataArray = tableData[key] else { return }
        
        let data = dataArray[indexPath.row]
        let value = !data.value
        
        let completion = {() -> Void in
            data.value = value
            dataArray[indexPath.row] = data
            self.tableData[key] = dataArray
            
            cell.switchView.set(on: value, animated: true)
        }
        
        LoadingIndicatorManager.shared.showIndicatorView()
        
        var params = [String:Any]()
        params["setup_code"] = data.setup_code
        params["setup_value"] = data.value ? "y" : "n"
        
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
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 46 * QUtils.optimizeRatio()
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        var frame = CGRect.zero
//        frame.size.width = tableView.frame.size.width
//        frame.size.height = 46 * QUtils.optimizeRatio()
//        let headerView = UIView(frame: frame)
//
//        let labelTitle = UILabel()
//        labelTitle.translatesAutoresizingMaskIntoConstraints = false
//        labelTitle.text = keys[section]
//        labelTitle.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
//        labelTitle.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
//        headerView.addSubview(labelTitle)
//
//        labelTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
//        labelTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
//
//        return headerView
//    }
    
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
