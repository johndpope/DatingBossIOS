//
//  UserProfileStatsView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 30/12/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class UserProfileStatsView: UIView {
    private let labelSum = UILabel()
    private let circularViewSum =  CircleIndicatorView(lineWidth: 8.0)
    
    private let labelPointOfView = UILabel()
    private let barIndicatorViewPointOfView = BarIndicatorView()
    private let labelCharacter = UILabel()
    private let barIndicatorViewCharacter = BarIndicatorView()
    private let labelStyle = UILabel()
    private let barIndicatorViewStyle = BarIndicatorView()
    
    private var timer: Timer?
    
    private var valueSum: Int = 0
    private var valuePointOfView: Int = 0
    private var valueCharacter: Int = 0
    private var valueStyle: Int = 0
    
    let data: UserData
    
    init(frame: CGRect = CGRect.zero, data uData: UserData) {
        data = uData
        super.init(frame: frame)
        
        circularViewSum.translatesAutoresizingMaskIntoConstraints = false
        circularViewSum.value = 0.0
        self.addSubview(circularViewSum)
        
        circularViewSum.topAnchor.constraint(equalTo: self.topAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        circularViewSum.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        circularViewSum.widthAnchor.constraint(equalToConstant: 92 * QUtils.optimizeRatio()).isActive = true
        circularViewSum.heightAnchor.constraint(equalToConstant: 92 * QUtils.optimizeRatio()).isActive = true
        circularViewSum.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24 * QUtils.optimizeRatio()).isActive = true
        
        var containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        containerView.centerXAnchor.constraint(equalTo: circularViewSum.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: circularViewSum.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: circularViewSum.widthAnchor, constant: -20).isActive = true
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "퍼센트"
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12 * QUtils.optimizeRatio(), weight: .regular)
        label.sizeToFit()
        containerView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        labelSum.translatesAutoresizingMaskIntoConstraints = false
        labelSum.text = "0%"
        labelSum.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelSum.font = UIFont.systemFont(ofSize: 18 * QUtils.optimizeRatio(), weight: .bold)
        labelSum.sizeToFit()
        containerView.addSubview(labelSum)

        labelSum.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 2 * QUtils.optimizeRatio()).isActive = true
        labelSum.heightAnchor.constraint(equalToConstant: labelSum.frame.size.height).isActive = true
        labelSum.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        labelSum.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)

        containerView.leadingAnchor.constraint(equalTo: circularViewSum.trailingAnchor, constant: 28 * QUtils.optimizeRatio()).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24 * QUtils.optimizeRatio()).isActive = true
        containerView.centerYAnchor.constraint(equalTo: circularViewSum.centerYAnchor).isActive = true

        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "가치관 "
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        containerView.addSubview(label)

        label.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true

        labelPointOfView.translatesAutoresizingMaskIntoConstraints = false
        labelPointOfView.textColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        labelPointOfView.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        containerView.addSubview(labelPointOfView)

        labelPointOfView.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        labelPointOfView.leadingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true

        barIndicatorViewPointOfView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(barIndicatorViewPointOfView)

        barIndicatorViewPointOfView.topAnchor.constraint(equalTo: labelPointOfView.bottomAnchor, constant: 4 * QUtils.optimizeRatio()).isActive = true
        barIndicatorViewPointOfView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        barIndicatorViewPointOfView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        barIndicatorViewPointOfView.heightAnchor.constraint(equalToConstant: 5 * QUtils.optimizeRatio()).isActive = true

        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "성격 "
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        containerView.addSubview(label)

        label.topAnchor.constraint(equalTo: barIndicatorViewPointOfView.bottomAnchor, constant: 11 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true

        labelCharacter.translatesAutoresizingMaskIntoConstraints = false
        labelCharacter.textColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        labelCharacter.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        containerView.addSubview(labelCharacter)

        labelCharacter.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        labelCharacter.leadingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true

        barIndicatorViewCharacter.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(barIndicatorViewCharacter)

        barIndicatorViewCharacter.topAnchor.constraint(equalTo: labelCharacter.bottomAnchor, constant: 4 * QUtils.optimizeRatio()).isActive = true
        barIndicatorViewCharacter.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        barIndicatorViewCharacter.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        barIndicatorViewCharacter.heightAnchor.constraint(equalToConstant: 5 * QUtils.optimizeRatio()).isActive = true

        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "연애스타일 "
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        containerView.addSubview(label)

        label.topAnchor.constraint(equalTo: barIndicatorViewCharacter.bottomAnchor, constant:  11 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true

        labelStyle.translatesAutoresizingMaskIntoConstraints = false
        labelStyle.textColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        labelStyle.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        containerView.addSubview(labelStyle)

        labelStyle.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        labelStyle.leadingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true

        barIndicatorViewStyle.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(barIndicatorViewStyle)

        barIndicatorViewStyle.topAnchor.constraint(equalTo: labelStyle.bottomAnchor, constant: 4 * QUtils.optimizeRatio()).isActive = true
        barIndicatorViewStyle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        barIndicatorViewStyle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        barIndicatorViewStyle.heightAnchor.constraint(equalToConstant: 5 * QUtils.optimizeRatio()).isActive = true
        barIndicatorViewStyle.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func startAnimating() {
        timer?.invalidate()
        timer = nil
        
        valueSum = 0
        
        valuePointOfView = 0
        valueCharacter = 0
        valueStyle = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.008, repeats: true, block: { (aTimer) in
            if self.valueSum < self.data.sim_sum {
                self.valueSum += 1
                self.circularViewSum.value = CGFloat(self.valueSum) / 100
                self.labelSum.text = "\(self.valueSum)%"
            }
            
            if self.valuePointOfView < self.data.sim_values {
                self.valuePointOfView += 1
                self.barIndicatorViewPointOfView.value =  CGFloat(self.valuePointOfView) / 100_
                self.labelPointOfView.text = "\(self.valuePointOfView)%"
            }
            
            if self.valueCharacter < self.data.sim_character {
                self.valueCharacter += 1
                self.barIndicatorViewCharacter.value =  CGFloat(self.valueCharacter) / 100_
                self.labelCharacter.text = "\(self.valueCharacter)%"
            }
            
            if self.valueStyle < self.data.sim_style {
                self.valueStyle += 1
                self.barIndicatorViewStyle.value =  CGFloat(self.valueStyle) / 100_
                self.labelStyle.text = "\(self.valueStyle)%"
            }
            
            if self.valueSum == self.data.sim_sum,
                self.valuePointOfView == self.data.sim_values,
                self.valueCharacter == self.data.sim_character,
                self.valueStyle == self.data.sim_style {
                self.timer?.invalidate()
                self.timer = nil
            }
            
            self.layoutIfNeeded()
        })
    }
}
