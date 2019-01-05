//
//  LoadingIndicatorView.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 10/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

import Lottie

class LoadingIndicatorManager: NSObject {
    static let shared = LoadingIndicatorManager()
    
    private var indicatorView: LoadingIndicatorView?
    
    private var isAnimating: Bool {
        return indicatorView != nil
    }
    
    func showIndicatorView() {
        guard isAnimating == false, let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return }
        
        indicatorView = LoadingIndicatorView()
        indicatorView?.translatesAutoresizingMaskIntoConstraints = false
        indicatorView?.beginAnimating()
        window.addSubview(indicatorView!)
        
        indicatorView?.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
        indicatorView?.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
        indicatorView?.leadingAnchor.constraint(equalTo: window.leadingAnchor).isActive = true
        indicatorView?.trailingAnchor.constraint(equalTo: window.trailingAnchor).isActive = true
    }
    
    func hideIndicatorView() {
        guard isAnimating == true else { return }
        
        indicatorView?.stopAnimating()
        indicatorView?.removeFromSuperview()
        indicatorView = nil
    }
}

private class LoadingIndicatorView: UIView {
    private let indicatorView = LOTAnimationView()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.setAnimation(named: "loader")
        self.addSubview(indicatorView)
        
        indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func beginAnimating() {
        indicatorView.loopAnimation = true
        indicatorView.play()
    }
    
    func stopAnimating() {
        indicatorView.stop()
    }
}
