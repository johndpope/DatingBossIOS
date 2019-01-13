//
//  InstanceMessageManager.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 13/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class InstanceMessageManager: NSObject {
    static let shared = InstanceMessageManager()
    
    private var messageView: UILabel?
    
    private var timer: Timer?
    
    func showMessage(_ message: String, margin: CGFloat = 0) {
        if messageView != nil {
            timer?.invalidate()
            timer = nil
            
            messageView?.layer.removeAllAnimations()
            
            messageView?.removeFromSuperview()
        }
        
        messageView = UILabel()
        messageView?.translatesAutoresizingMaskIntoConstraints = false
        messageView?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        messageView?.clipsToBounds = true
        messageView?.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        messageView?.alpha = 0
        messageView?.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIApplication.appDelegate().window?.addSubview(messageView!)
        
        messageView?.bottomAnchor.constraint(equalTo: UIApplication.appDelegate().window!.safeAreaLayoutGuide.bottomAnchor, constant: -16 * QUtils.optimizeRatio() - margin).isActive = true
        messageView?.centerXAnchor.constraint(equalTo: UIApplication.appDelegate().window!.centerXAnchor).isActive = true
        messageView?.heightAnchor.constraint(equalToConstant: (messageView?.layer.cornerRadius ?? 0) * 2).isActive = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = message
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .regular)
        label.numberOfLines = 2
        messageView?.addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: messageView!.leadingAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        label.trailingAnchor.constraint(equalTo: messageView!.trailingAnchor, constant: -24 * QUtils.optimizeRatio()).isActive  = true
        label.centerYAnchor.constraint(equalTo: messageView!.centerYAnchor).isActive = true
        label.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.size.width * 0.75).isActive = true
        
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.2, options: .curveEaseOut, animations: {
            self.messageView?.alpha = 1
            self.messageView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (complete) in
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (timer) in
                self.timer?.invalidate()
                self.timer = nil
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.messageView?.alpha = 0
                    self.messageView?.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                }, completion: { (complete) in
                    self.messageView?.removeFromSuperview()
                    self.messageView = nil
                })
            })
        }
    }
}
