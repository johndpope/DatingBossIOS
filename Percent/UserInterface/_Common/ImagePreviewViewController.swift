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
    private let scrollViewImages = UIScrollView()
    
    private let buttonClose = UIButton(type: .custom)
    
    private let imageArray: [Any]
    
    private let index: Int
    
    init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil, images: [Any], preselectedIndex: Int = 0) {
        imageArray = images
        index = preselectedIndex
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
        
        scrollViewImages.translatesAutoresizingMaskIntoConstraints = false
        scrollViewImages.alwaysBounceHorizontal = false
        scrollViewImages.isPagingEnabled = true
        theScrollView.addSubview(scrollViewImages)
        
        scrollViewImages.centerXAnchor.constraint(equalTo: theScrollView.centerXAnchor).isActive = true
        scrollViewImages.centerYAnchor.constraint(equalTo: theScrollView.centerYAnchor).isActive = true
        scrollViewImages.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        scrollViewImages.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        
        for i in 0 ..< imageArray.count {
            var frame = CGRect.zero
            frame.size.width = UIScreen.main.bounds.size.width
            frame.size.height = UIScreen.main.bounds.size.width
            frame.origin.x = frame.size.width * CGFloat(i)
            
            let imageView = UIImageView(frame: frame)
            imageView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            if let image = imageArray[i] as? UIImage {
                imageView.image = image
            } else if let imageUrl = imageArray[i] as? String {
                imageView.pin_setImage(from: URL(string: imageUrl))
            } else if let imageUrl = imageArray[i] as? URL {
                imageView.pin_setImage(from: imageUrl)
            } else if let imageUrl = (imageArray[i] as? PictureData)?.imageUrl {
                imageView.pin_setImage(from: imageUrl)
            }
            scrollViewImages.addSubview(imageView)
        }
        
        var contentSize = scrollViewImages.contentSize
        contentSize.width = UIScreen.main.bounds.size.width * CGFloat(imageArray.count)
        scrollViewImages.contentSize = contentSize
        
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        buttonClose.setImage(UIImage.navigationCloseImage.recolour(with: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).resize(maxWidth: 25 * QUtils.optimizeRatio()), for: .normal)
        buttonClose.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        self.view.addSubview(buttonClose)
        
        buttonClose.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIApplication.shared.statusBarFrame.size.height).isActive = true
        buttonClose.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        buttonClose.widthAnchor.constraint(equalToConstant: 55).isActive = true
        buttonClose.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        self.view.layoutIfNeeded()
        
        var contentOffset = scrollViewImages.contentOffset
        contentOffset.x = UIScreen.main.bounds.size.width * CGFloat(index)
        scrollViewImages.setContentOffset(contentOffset, animated: false)
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
        guard scrollView == theScrollView else { return nil }
        return scrollViewImages
    }
}
