//
//  ChatListViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class ChatListViewController: BaseMainViewController {
    private let headerView = ChatListSegmentView()
    
    private let theTableView = UITableView()
    private var tableData = [ChatListType:[ChatListData]]()
    
    override init(navigationViewEffect effect: UIVisualEffect? = nil) {
        super.init(navigationViewEffect: effect)
        
        showCherriesOnNavigation = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "채팅"
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.delegate = self
        self.view.addSubview(headerView)
        
        headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 48 * QUtils.optimizeRatio()).isActive = true
        
        theTableView.translatesAutoresizingMaskIntoConstraints = false
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.separatorStyle = .none
        self.view.addSubview(theTableView)
        
        theTableView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        theTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        theTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        loadNavigationItems()
        
        reloadData()
    }
    
    override func reloadData(_ completion: (() -> Void)? = nil) {
        super.reloadData(completion)
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Chat + "\(MyData.shared.mem_idx)", method: .get, params: nil) { (isSucceed, errMessage, response) in
            self.tableData.removeAll()
            
            guard isSucceed else {
                self.theTableView.reloadData()
                return
            }
        }
    }
}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section == 0 ? .Requesting : .Requested]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ChatListTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListTableViewCell") as? ChatListTableViewCell else { return UITableViewCell()}
        
        return cell
    }
}

extension ChatListViewController: ChatListSegmentViewDelegate {
    func chatListSegmentView(_ segmentView: ChatListSegmentView, didSelect type: ChatListType) {
        guard type != segmentView.selectedType else {
            self.theTableView.setContentOffset(CGPoint.zero, animated: true)
            return
        }
        
        self.theTableView.reloadData()
    }
}
