//
//  ItemCell.swift
//  itvTask
//
//  Created by Jahongir Nematov on 6/14/19.
//  Copyright © 2019 Jahongir Nematov. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ItemCell: UICollectionViewCell {
    
    var item : Item? {
        didSet {
            setDetails()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let itemImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let itemTitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        label.numberOfLines = 2
        return label
    }()
    
    func setDetails() {
        if let title = item?.title {
            self.itemTitleLabel.text = title
        }
        
        if let posterUrl = item?.posterUrl {
            let url = URL(string: posterUrl)
            self.itemImageView.kf.indicatorType = .activity
            self.itemImageView.kf.setImage(with: url)
        }
    }
    
    
    func setupView() {
        backgroundColor = .clear
        
        addSubview(itemImageView)
        addSubview(itemTitleLabel)
        
        itemImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            
        }
        
        itemTitleLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(itemImageView.self)
            make.height.equalTo(70)
        }
        
    }
}
