//
//  AvoidKnownsContactsViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

import Contacts

struct LocalContact {
    var name: String!
    var phone: String?
}

class AvoidKnownsContactsViewController: BaseViewController {
    private let theTableView = UITableView()
    
    private var tableData = [LocalContact]()
    private var selectedIndex = [Int]()
    
    private let buttonCancel = UIButton(type: .custom)
    private let buttonConfirm = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "지인 만나지 않기"
        
        theTableView.translatesAutoresizingMaskIntoConstraints = false
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.separatorStyle = .none
        theTableView.register(AvoidKnownsContactsTableViewCell.self, forCellReuseIdentifier: "AvoidKnownsContactsTableViewCell")
        self.view.addSubview(theTableView)
        
        theTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        theTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        theTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
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
        buttonConfirm.setTitle("등록", for: .normal)
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
        
        let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: buttonCancel.layer.cornerRadius * 2 + 16 * QUtils.optimizeRatio()))
        theTableView.tableFooterView = tableFooterView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadData()
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonCancel:
            self.navigationController?.popViewController(animated: true)
            break
            
        case buttonConfirm:
            guard selectedIndex.count > 0 else {
                InstanceMessageManager.shared.showMessage("선택된 항목이 없습니다.", margin: buttonConfirm.frame.size.height + 8 * QUtils.optimizeRatio())
                break
            }
            
            LoadingIndicatorManager.shared.showIndicatorView()
            
            var avoidList = [[String:Any]]()
            for index in selectedIndex {
                let item = tableData[index]
                guard let phone = item.phone?.replacingOccurrences(of: "-", with: "") else { continue }
                avoidList.append(["avoid_phone":phone])
            }
            var params = [String:Any]()
            params["avoidList"] = avoidList
            
            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.Avoid + "\(MyData.shared.mem_idx)", params: params) { (isSucceed, errMessage, response) in
                LoadingIndicatorManager.shared.hideIndicatorView()
                
                InstanceMessageManager.shared.showMessage("전화번호가 등록되었습니다.", margin: self.buttonConfirm.frame.size.height + 8 * QUtils.optimizeRatio())
                
                self.navigationController?.popViewController(animated: true)
            }
            break
            
        default: break
        }
    }
    
    private func reloadData() {
        LoadingIndicatorManager.shared.showIndicatorView()
        
        DispatchQueue.main.async {
            self.selectedIndex.removeAll()
            self.tableData.removeAll()
            
            let status = CNContactStore.authorizationStatus(for: .contacts)
            
            if status == .denied { return }
            let contactStore = CNContactStore()
            
            var keysToFetch = [CNKeyDescriptor]()
            keysToFetch.append(CNContactFormatter.descriptorForRequiredKeys(for: .fullName))
            keysToFetch.append(CNContactPhoneNumbersKey as CNKeyDescriptor)
            
            let request = CNContactFetchRequest(keysToFetch: keysToFetch)
            
            let formatter = CNContactFormatter()
            formatter.style = .fullName
            
            var output = [LocalContact]()
            
            do {
                try contactStore.enumerateContacts(with: request) { contact, stop in
                    if let name = formatter.string(from: contact),
                        let phone = contact.phoneNumbers.first?.value.stringValue,
                        phone.hasPrefix("01"),
                        phone.count == 11 {
                        let data = LocalContact(name: name, phone: phone)
                        output.append(data)
                    }
                }
            } catch let fetchError {
                print(fetchError)
            }
            
            if output.count > 0 {
                self.tableData.append(contentsOf: output.sorted(by: { (a, b) -> Bool in
                    return a.name < b.name
                }))
            }
            
            for i in 0 ..< self.tableData.count {
                self.selectedIndex.append(i)
            }
            
            LoadingIndicatorManager.shared.hideIndicatorView()
            
            self.theTableView.reloadData()
        }
    }
}

extension AvoidKnownsContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = selectedIndex.firstIndex(of: indexPath.row) {
            _ = selectedIndex.remove(at: index)
        } else {
            selectedIndex.append(indexPath.row)
        }
        
        theTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AvoidKnownsContactsTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AvoidKnownsContactsTableViewCell") as? AvoidKnownsContactsTableViewCell else { return UITableViewCell() }
        cell.data = tableData[indexPath.row]
        cell.isSelectedCell = selectedIndex.firstIndex(of: indexPath.row) != nil
        return cell
    }
}

