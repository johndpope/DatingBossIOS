//
//  PreferLooksNoDataViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 20/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class PreferLooksNoDataViewController: UIViewController {
    private let imageViewHeart = UIImageView()
    
    private var timerBump: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentView)
        
        contentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        let circleView = CircleIndicatorView(frame: CGRect.zero, backgroundColour: .clear, indicatorColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), lineWidth: 4 * QUtils.optimizeRatio())
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.value = 1.0
        contentView.addSubview(circleView)
        
        circleView.widthAnchor.constraint(equalToConstant: 64 * QUtils.optimizeRatio()).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: 64 * QUtils.optimizeRatio()).isActive = true
        circleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        circleView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        imageViewHeart.translatesAutoresizingMaskIntoConstraints = false
        imageViewHeart.image = UIImage(named: "img_heart")
        imageViewHeart.contentMode = .scaleAspectFit
        self.view.addSubview(imageViewHeart)
        
        imageViewHeart.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        imageViewHeart.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        imageViewHeart.widthAnchor.constraint(equalToConstant: 32 * QUtils.optimizeRatio()).isActive = true
        imageViewHeart.heightAnchor.constraint(equalToConstant: 32 * QUtils.optimizeRatio()).isActive = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이상형 외모 설정을 위한 사진이 없습니다.\n내일 새로운 사진이 제공됩니다."
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18 * QUtils.optimizeRatio(), weight: .bold)
        label.numberOfLines = 2
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        self.bumping()
        self.timerBump = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.bumping), userInfo: nil, repeats: true)
    }
    
    @objc private func bumping() {
        imageViewHeart.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.2, options: .curveEaseOut, animations: {
            self.imageViewHeart.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
