//
//  LittleCategoryCell.swift
//  itvTask
//
//  Created by Jahongir Nematov on 6/15/19.
//  Copyright © 2019 Jahongir Nematov. All rights reserved.
//

import UIKit

class LittleCategoryCell : CategoryCell {
    
    private let littleItemCellId = "littleItemCellId"
    
    override func setupView() {
        super.setupView()
        itemCollectionView.register(LittleItemCell.self, forCellWithReuseIdentifier: littleItemCellId)
    }
    
}

extension LittleCategoryCell {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: littleItemCellId, for: indexPath) as! LittleItemCell
        cell.item = itemData?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize : CGRect = UIScreen.main.bounds
        
        //Ipad
        if screenSize.width > 750 {
            return CGSize(width: frame.width/5 - 12, height: frame.height-54)
        }
        
        return CGSize(width: frame.width/3 - 15, height: frame.height-54)
    }
    
}
