//
//  LittleItemCell.swift
//  itvTask
//
//  Created by Jahongir Nematov on 6/16/19.
//  Copyright © 2019 Jahongir Nematov. All rights reserved.
//

import UIKit
import SnapKit

class LittleItemCell : ItemCell {
    
    override func setupView() {

        addSubview(itemImageView)
        
        itemImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
    }
}
