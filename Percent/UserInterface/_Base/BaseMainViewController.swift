//
//  BaseMainViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 02/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class BaseMainViewController: BaseViewController {
    internal let buttonProfile = ProfileButton()
    
    private let ghostView = UIView()
    
    private let buttonWake = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ghostView.translatesAutoresizingMaskIntoConstraints = false
        ghostView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(ghostView)
        
        ghostView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        ghostView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        ghostView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        ghostView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        ghostView.addSubview(contentView)
        
        contentView.centerXAnchor.constraint(equalTo: ghostView.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: ghostView.centerYAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "img_hibernate")
        contentView.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80 * QUtils.optimizeRatio()).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "휴면 상태입니다.\n휴면상태에서는 서비스를 이용하실 수 없습니다."
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        label.numberOfLines = 0
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        buttonWake.translatesAutoresizingMaskIntoConstraints = false
        buttonWake.clipsToBounds = true
        buttonWake.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.6529199481, green: 0.2550097108, blue: 0.2336317599, alpha: 1)), for: .normal)
        buttonWake.setTitle("휴면 해제", for: .normal)
        buttonWake.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonWake.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonWake.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonWake.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24 * QUtils.optimizeRatio(), bottom: 0, right: 24 * QUtils.optimizeRatio())
        buttonWake.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        buttonWake.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        contentView.addSubview(buttonWake)
        
        buttonWake.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonWake.heightAnchor.constraint(equalToConstant: buttonWake.layer.cornerRadius * 2).isActive = true
        buttonWake.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        buttonWake.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateGhostMode()
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonProfile:
            let viewController = MyPageViewController()
            let navController = UINavigationController(rootViewController: viewController)
            self.present(navController, animated: true, completion: nil)
            break
            
        case buttonWake:
            var params = [String:Any]()
//            params["ghost_fl"] = "n"
            params["setup_value"] = "n"
            params["setup_code"] = "060"
            
            let httpClient = QHttpClient()
            httpClient.request(to: RequestUrl.Service.Settings + "\(MyData.shared.mem_idx)", params: params) { (isSucceed, errMessage, response) in
                guard let status = (response as? [String:Any])?["Status"] as? String, status == "OK" else { return }
                
                MyData.shared.ghost_fl = false
                
                self.updateGhostMode()
                self.reloadData()
            }
            break
            
        default:
            break
        }
    }
    
    override func loadNavigationItems() {
        buttonProfile.member_idx = MyData.shared.mem_idx
        buttonProfile.imageName = MyData.shared.picture_name
        buttonProfile.translatesAutoresizingMaskIntoConstraints = false
        buttonProfile.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        self.navigationView.contentView.addSubview(buttonProfile)
        
        buttonProfile.reloadData()
        
        buttonProfile.bottomAnchor.constraint(equalTo: self.navigationView.contentView.bottomAnchor).isActive = true
        buttonProfile.leadingAnchor.constraint(equalTo: self.navigationView.contentView.leadingAnchor, constant: 6 * QUtils.optimizeRatio()).isActive = true
        buttonProfile.widthAnchor.constraint(equalToConstant: 60 * QUtils.optimizeRatio()).isActive = true
        buttonProfile.heightAnchor.constraint(equalToConstant: kHeightNavigationView).isActive = true
    }
    
    func reloadData() {
        
    }
    
    private func updateGhostMode() {
        self.view.bringSubviewToFront(ghostView)
        ghostView.isHidden = !MyData.shared.ghost_fl
    }
}
