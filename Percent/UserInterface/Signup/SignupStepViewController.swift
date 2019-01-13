//
//  SignupStepViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 09/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

protocol SignupStepViewControllerDelegate {
    func signupStepViewController(doneProgress viewController: SignupStepViewController)
    func signupStepViewController(titleOf viewController: SignupStepViewController) -> String?
}

class SignupStepViewController: UIViewController {
    private let step: Int
    
    var delegate: SignupStepViewControllerDelegate?
    
    init(step value: Int) {
        step = value
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let circleView = CircleIndicatorView(frame: CGRect.zero, backgroundColour: .clear, indicatorColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), lineWidth: 6 * QUtils.optimizeRatio())
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.value = 0
        self.view.addSubview(circleView)
        
        circleView.widthAnchor.constraint(equalToConstant: 120 * QUtils.optimizeRatio()).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: 120 * QUtils.optimizeRatio()).isActive = true
        circleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        circleView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentView)
        
        contentView.leadingAnchor.constraint(equalTo: circleView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: circleView.trailingAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "STEP"
        label.textColor = #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 22 * QUtils.optimizeRatio(), weight: .bold)
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        let bottomAnchor = label.bottomAnchor
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = step < 10 ? "0\(step)" : "\(step)"
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 40 * QUtils.optimizeRatio(), weight: .regular)
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = delegate?.signupStepViewController(titleOf: self)
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .regular)
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 28 * QUtils.optimizeRatio()).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        var value = CGFloat(0.0)
        _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            value += 0.01
            circleView.value = value
            
            if value >= 1.0 {
                timer.invalidate()
                
                _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (aTimer) in
                    self.delegate?.signupStepViewController(doneProgress: self)
                })
            }
        })
    }
}
