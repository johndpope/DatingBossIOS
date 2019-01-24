//
//  RecommandNoDataCollectionViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 23/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class RecommandNoDataCollectionViewCell: UICollectionViewCell {
    class var sectionInset: UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    class var minimumInteritemSpacing: CGFloat {
        return 0
    }
    
    class var itemSize: CGSize {
        get {
            var size = CGSize.zero
            size.width = UIScreen.main.bounds.size.width
            size.height = 250 * QUtils.optimizeRatio()
            return size
        }
    }
    
    private let imageViewHeart = UIImageView()
    
    private var timerBump: Timer!
    
    var showSubViews: Bool = true {
        didSet {
            for subView in self.subviews {
                subView.isHidden = !showSubViews
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentView)
        
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
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
        contentView.addSubview(imageViewHeart)
        
        imageViewHeart.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        imageViewHeart.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        imageViewHeart.widthAnchor.constraint(equalToConstant: 32 * QUtils.optimizeRatio()).isActive = true
        imageViewHeart.heightAnchor.constraint(equalToConstant: 32 * QUtils.optimizeRatio()).isActive = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "추천 회원이 없습니다."
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18 * QUtils.optimizeRatio(), weight: .bold)
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 24 * QUtils.optimizeRatio()).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20 * QUtils.optimizeRatio()).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        self.bumping()
        self.timerBump = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.bumping), userInfo: nil, repeats: true)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @objc private func bumping() {
        imageViewHeart.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.2, options: .curveEaseOut, animations: {
            self.imageViewHeart.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
