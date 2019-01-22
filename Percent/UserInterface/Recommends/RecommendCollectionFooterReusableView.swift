//
//  RecommendCollectionFooterReusableView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 23/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

protocol RecommendCollectionFooterReusableViewDelegate {
    func recommendCollectionFooterReusableView(_ view: RecommendCollectionFooterReusableView, didSelectButton button: UIButton)
}

class RecommendCollectionFooterReusableView: UICollectionReusableView {
    class var height: CGFloat {
        return 152 * QUtils.optimizeRatio()
    }
    
    let buttonGuide = UIButton(type: .custom)
    let buttonPrefer = UIButton(type: .custom)
    let buttonAvoidKnowns = UIButton(type: .custom)
    
    var delegate: RecommendCollectionFooterReusableViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttonGuide.translatesAutoresizingMaskIntoConstraints = false
        buttonGuide.clipsToBounds = true
        buttonGuide.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .normal)
        buttonGuide.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.6862745098, green: 0.1843137255, blue: 0.2156862745, alpha: 1)), for: .highlighted)
        buttonGuide.setTitle("이용 방법", for: .normal)
        buttonGuide.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonGuide.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonGuide.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonGuide.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonGuide.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        buttonGuide.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8 * QUtils.optimizeRatio(), bottom: 0, right: 0)
        buttonGuide.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8 * QUtils.optimizeRatio())
        self.addSubview(buttonGuide)
        
        buttonGuide.topAnchor.constraint(equalTo: self.topAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        buttonGuide.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonGuide.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        buttonGuide.heightAnchor.constraint(equalToConstant: buttonGuide.layer.cornerRadius * 2).isActive = true
        
        buttonPrefer.translatesAutoresizingMaskIntoConstraints = false
        buttonPrefer.clipsToBounds = true
        buttonPrefer.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.6862745098, green: 0.1843137255, blue: 0.2156862745, alpha: 1)), for: .normal)
        buttonPrefer.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .highlighted)
        buttonPrefer.setTitle("이상형 설정", for: .normal)
        buttonPrefer.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonPrefer.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonPrefer.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonPrefer.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonPrefer.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.addSubview(buttonPrefer)
        
        buttonPrefer.topAnchor.constraint(equalTo: buttonGuide.bottomAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        buttonPrefer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonPrefer.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -4 * QUtils.optimizeRatio()).isActive = true
        buttonPrefer.heightAnchor.constraint(equalToConstant: buttonPrefer.layer.cornerRadius * 2).isActive = true
        
        buttonAvoidKnowns.translatesAutoresizingMaskIntoConstraints = false
        buttonAvoidKnowns.clipsToBounds = true
        buttonAvoidKnowns.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.9764705882, green: 0.3921568627, blue: 0.4352941176, alpha: 1)), for: .normal)
        buttonAvoidKnowns.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.6862745098, green: 0.1843137255, blue: 0.2156862745, alpha: 1)), for: .highlighted)
        buttonAvoidKnowns.setTitle("지인 만나지 않기", for: .normal)
        buttonAvoidKnowns.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonAvoidKnowns.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonAvoidKnowns.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonAvoidKnowns.layer.cornerRadius = buttonPrefer.layer.cornerRadius
        buttonAvoidKnowns.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.addSubview(buttonAvoidKnowns)
        
        buttonAvoidKnowns.centerYAnchor.constraint(equalTo: buttonPrefer.centerYAnchor).isActive = true
        buttonAvoidKnowns.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 4 * QUtils.optimizeRatio()).isActive = true
        buttonAvoidKnowns.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        buttonAvoidKnowns.heightAnchor.constraint(equalTo: buttonPrefer.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @objc private func pressedButton(_ sender: UIButton) {
        delegate?.recommendCollectionFooterReusableView(self, didSelectButton: sender)
    }
}

