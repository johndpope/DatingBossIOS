//
//  SignupNavigationBarView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 12/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

let kHeightSignupNavigationBarView = CGFloat(66)

private let kTagLabelStep = 1001

class SignupNavigationBarView: UIView {
    private let contentView = UIView()
    
    private var labelsStep = [UILabel]()
    private let barIndicatorView = UIView()
    private let imageViewIndicator = UIImageView()
    
    private var constraintIndicatorBar: NSLayoutConstraint!
    
    private var stepValue = 1
    var step: Int {
        get {
            return stepValue
        } set {
            if stepValue < 1 {
                stepValue = 1
            } else if stepValue > 5 {
                stepValue = 5
            }
            
            updateValue()
        }
    }
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        self.addSubview(backView)
        
        backView.bottomAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backView.heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.size.height).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentView)
        
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32 * QUtils.optimizeRatio()).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32 * QUtils.optimizeRatio()).isActive = true
        
        for i in 0 ..< 5 {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "STEP\(i + 1)"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 10 * QUtils.optimizeRatio(), weight: .bold)
            contentView.addSubview(label)
            
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
            label.centerXAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ((UIScreen.main.bounds.size.width - 64 * QUtils.optimizeRatio()) * CGFloat(i) / 4)).isActive = true
            
            labelsStep.append(label)
        }
        
        let barView = UIView()
        barView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(barView)
        
        barView.topAnchor.constraint(equalTo: labelsStep[0].bottomAnchor, constant: 15 * QUtils.optimizeRatio()).isActive = true
        barView.leadingAnchor.constraint(equalTo: labelsStep[0].leadingAnchor).isActive = true
        barView.trailingAnchor.constraint(equalTo: labelsStep[4].trailingAnchor).isActive = true
        barView.heightAnchor.constraint(equalToConstant: 4 * QUtils.optimizeRatio()).isActive = true
        
        let backgroundIndicatorView = UIView()
        backgroundIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        backgroundIndicatorView.clipsToBounds = true
        backgroundIndicatorView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)
        backgroundIndicatorView.layer.cornerRadius = 2 * QUtils.optimizeRatio()
        barView.addSubview(backgroundIndicatorView)
        
        backgroundIndicatorView.topAnchor.constraint(equalTo: barView.topAnchor).isActive = true
        backgroundIndicatorView.bottomAnchor.constraint(equalTo: barView.bottomAnchor).isActive = true
        backgroundIndicatorView.leadingAnchor.constraint(equalTo: barView.leadingAnchor).isActive = true
        backgroundIndicatorView.trailingAnchor.constraint(equalTo: barView.trailingAnchor).isActive = true
        
        barIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        barIndicatorView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        barView.addSubview(barIndicatorView)
        
        barIndicatorView.topAnchor.constraint(equalTo: barView.topAnchor).isActive = true
        barIndicatorView.bottomAnchor.constraint(equalTo: barView.bottomAnchor).isActive = true
        barIndicatorView.leadingAnchor.constraint(equalTo: barView.leadingAnchor).isActive = true
        constraintIndicatorBar = barIndicatorView.trailingAnchor.constraint(equalTo: barView.leadingAnchor)
        constraintIndicatorBar.isActive = true
        
        imageViewIndicator.translatesAutoresizingMaskIntoConstraints = false
        imageViewIndicator.image = UIImage(named: "img_intro_heart")
        imageViewIndicator.contentMode = .scaleAspectFit
        barView.addSubview(imageViewIndicator)
        
        imageViewIndicator.centerXAnchor.constraint(equalTo: barIndicatorView.trailingAnchor).isActive = true
        imageViewIndicator.centerYAnchor.constraint(equalTo: barIndicatorView.centerYAnchor).isActive = true
        imageViewIndicator.widthAnchor.constraint(equalToConstant: 16 * QUtils.optimizeRatio()).isActive = true
        imageViewIndicator.heightAnchor.constraint(equalToConstant: 16 * QUtils.optimizeRatio()).isActive = true
        
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func updateValue(animated: Bool = true) {
        labelsStep[0].textColor = self.stepValue == 1 ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        labelsStep[1].textColor = self.stepValue == 2 ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        labelsStep[2].textColor = self.stepValue == 3 ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        labelsStep[3].textColor = self.stepValue == 4 ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        labelsStep[4].textColor = self.stepValue == 5 ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        
        print(self.labelsStep[0].frame)
        print(self.labelsStep[0].center)
        
        let animations = {() -> Void in
            self.constraintIndicatorBar.constant = self.labelsStep[self.stepValue - 1].center.x - self.labelsStep[0].frame.origin.x
            
            self.layoutIfNeeded()
        }
        
        guard animated else {
            animations()
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: animations)
    }
}
