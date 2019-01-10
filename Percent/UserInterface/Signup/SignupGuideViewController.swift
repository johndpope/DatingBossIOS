//
//  SignupGuideViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 12/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

struct SignupGuideData {
    let title: String
    let content: String
}

class SignupGuideViewController: BaseSignupViewController {
    private let theTableView = UITableView()
    
    private let buttonCancel = UIButton(type: .custom)
    private let buttonConfirm = UIButton(type: .custom)
    
    private var tableData = [SignupGuideData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "가입 절차"
        
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
        buttonConfirm.setTitle("시작", for: .normal)
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
        theTableView.register(SignupGuideTableViewCell.self, forCellReuseIdentifier: "SignupGuideTableViewCell")
        self.view.addSubview(theTableView)
        
        theTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        theTableView.bottomAnchor.constraint(equalTo: buttonCancel.topAnchor, constant: -7 * QUtils.optimizeRatio()).isActive = true
        theTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        theTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 24 * QUtils.optimizeRatio()))
        
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        leftNavigationItemView?.isHidden = true
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonCancel:
            self.dismiss(animated: true, completion: nil)
            break
            
        case buttonConfirm:
            UserPayload.shared.clear()
            
            let viewController = SignupTermsViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            break
            
        default: break
        }
    }
    
    private func reloadData() {
        tableData.removeAll()
        
        tableData.append(SignupGuideData(title: "프로필 작성", content: "약관 동의 / 본인 인증 / 기본 정보 입력"))
        tableData.append(SignupGuideData(title: "가치관 설문 작성", content: "가치관이 맞아야 연애와 결혼에 대한 만족도가 높아집니다."))
        tableData.append(SignupGuideData(title: "성격 설문 작성", content: "성격이 맞아야 다툼없는 연애와 결혼생활을 할 수 있습니다."))
        tableData.append(SignupGuideData(title: "연애스타일 설문 작성", content: "연애 스타일이 비슷하면 상대를 배려하며 즐거운 연애를 할 수 있습니다."))
        tableData.append(SignupGuideData(title: "이상형 설정", content: "이상형 설정을 수행하시면 인공지능 알고리즘으로 분석하여 이상형에 가장 가까운 이성을 우선으로 추천해드립니다."))
        
        theTableView.reloadData()
    }
}

extension SignupGuideViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = self.tableView(tableView, cellForRowAt: indexPath) as? SignupGuideTableViewCell else { return 0 }
        cell.data = tableData[indexPath.row]
        var height = cell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        if height < 64 * QUtils.optimizeRatio() {
            height = 64 * QUtils.optimizeRatio()
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SignupGuideTableViewCell") as? SignupGuideTableViewCell else { return UITableViewCell() }
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? SignupGuideTableViewCell)?.data = tableData[indexPath.row]
    }
}
