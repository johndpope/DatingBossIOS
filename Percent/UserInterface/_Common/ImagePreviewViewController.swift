//
//  ImagePreviewViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 16/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController {
    private let theScrollView = UIScrollView()
    private let theImageView = UIImageView()
    
    private let buttonClose = UIButton(type: .custom)
    
    private let image: UIImage
    
    init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil, image anImage: UIImage) {
        image = anImage
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.view.alpha = 0
        
        theScrollView.translatesAutoresizingMaskIntoConstraints = false
        theScrollView.delegate = self
        theScrollView.minimumZoomScale = 1.0
        theScrollView.maximumZoomScale = 3.0
        self.view.addSubview(theScrollView)
        
        theScrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        theScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        theScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        theScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        theImageView.image = image
        theScrollView.addSubview(theImageView)
        
        theImageView.centerXAnchor.constraint(equalTo: theScrollView.centerXAnchor).isActive = true
        theImageView.centerYAnchor.constraint(equalTo: theScrollView.centerYAnchor).isActive = true
        theImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        theImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * image.size.height / image.size.width).isActive = true
        
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        buttonClose.setImage(UIImage.navigationCloseImage.recolour(with: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).resize(maxWidth: 25 * QUtils.optimizeRatio()), for: .normal)
        buttonClose.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        self.view.addSubview(buttonClose)
        
        buttonClose.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIApplication.shared.statusBarFrame.size.height).isActive = true
        buttonClose.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        buttonClose.widthAnchor.constraint(equalToConstant: 55).isActive = true
        buttonClose.heightAnchor.constraint(equalToConstant: 46).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc private func pressedButton(_ sender: UIButton) {
        hide { (complete) in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    func show() {
        UIView.animate(withDuration: 0.3) {
            self.view.alpha = 1.0
        }
    }
    
    func hide(_ completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0.0
        }, completion: completion)
    }
}

extension ImagePreviewViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return theImageView
    }
}
