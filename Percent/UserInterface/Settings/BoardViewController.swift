//
//  BoardViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 29/11/2018.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

enum BoardType {
    case Notice
    case FAQ
    case Event
}

class BoardViewController: BaseViewController {
    private let type: BoardType
    
    init(navigationViewEffect effect: UIVisualEffect? = nil, type bType: BoardType) {
        type = bType
        super.init(navigationViewEffect: effect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private let theTableView = UITableView()
    
    private var tableData = [BoardData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theTableView.translatesAutoresizingMaskIntoConstraints = false
        theTableView.separatorStyle = .none
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.register(BoardTableViewCell.self, forCellReuseIdentifier: "BoardTableViewCell")
        theTableView.register(BoardExpandedTableViewCell.self, forCellReuseIdentifier: "BoardExpandedTableViewCell")
        self.view.addSubview(theTableView)
        
        theTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        theTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        theTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        reloadData()
    }
    
    private func reloadData() {
        var board_type: String?
        
        switch type {
        case .Notice:
            self.title = "공지사항"
            board_type = "notice"
            break
            
        case .FAQ:
            self.title = "FAQ"
            board_type = "fnq"
            break
            
        case .Event:
            self.title = "이벤트"
            board_type = "event"
            break
        }
        
        var params = [String:Any]()
        params["board_type"] = board_type
        
        let httpClient = QHttpClient()
        httpClient.request(to: RequestUrl.Service.Board + "\(MyData.shared.mem_idx)", params: params) { (isSucceed, errMessage, response) in
            guard isSucceed, let responseData = response as? [[String:Any]] else { return }
            
            self.tableData.removeAll()
            self.tableData.append(contentsOf: responseData.map({ (item) -> BoardData in
                return BoardData(with: item)
            }))
            
            self.theTableView.reloadData()
        }
    }
}

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        theTableView.performBatchUpdates({
            let data = self.tableData[indexPath.row]
            data.isExpanded = !data.isExpanded
            self.tableData[indexPath.row] = data
            
            self.theTableView.reloadRows(at: [indexPath], with: .fade)
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = tableData[indexPath.row]
        
        guard data.isExpanded, let cell = self.tableView(tableView, cellForRowAt: indexPath) as? BoardTableViewCell else { return BoardTableViewCell.heightCollapsed }
        cell.data = data
        return cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tableData[indexPath.row]
        guard data.isExpanded else { return tableView.dequeueReusableCell(withIdentifier: "BoardTableViewCell") as? BoardTableViewCell ?? UITableViewCell() }
        
        return tableView.dequeueReusableCell(withIdentifier: "BoardExpandedTableViewCell") as? BoardExpandedTableViewCell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? BoardTableViewCell)?.data = tableData[indexPath.row]
    }
}
