//
//  CollectionViewCell.swift
//  itvTask
//
//  Created by Jahongir Nematov on 6/14/19.
//  Copyright © 2019 Jahongir Nematov. All rights reserved.
//

import UIKit
import SnapKit

protocol allMoviesDelegate {
    func didTapAllButton(title: String)
}

class CategoryCell: UICollectionViewCell {
    
    private let cellId = "itemCellId"
    var itemData : [Item]? {
        didSet {
            setupView()
            DispatchQueue.main.async {
                self.itemCollectionView.reloadData()
            }
        }
    }
    var mainController : MainController?
    var delegate : allMoviesDelegate?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let itemCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        return label
    }()
    
    let allButton : UIButton = {
        let button = UIButton()
        button.setTitle("All", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.isHidden = true
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    let dividerLineView1 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    
    let dividerLineView2 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    
    @objc func allButtonAction() {
        delegate?.didTapAllButton(title: "movies")
    }
    
    
    func setupView() {
        backgroundColor = .clear
        
        itemCollectionView.dataSource = self
        itemCollectionView.delegate = self
        itemCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: cellId)
        
        allButton.addTarget(self, action: #selector(allButtonAction), for: .touchUpInside)
        
        addSubview(itemCollectionView)
        addSubview(dividerLineView1)
        addSubview(categoryLabel)
        addSubview(dividerLineView2)
        addSubview(allButton)
        
        itemCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLabel.snp.bottom)
            make.bottom.right.left.equalToSuperview()
        }
        
        dividerLineView1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(itemCollectionView.snp.bottom).offset(8)
            make.height.equalTo(1)
        }
        
        dividerLineView2.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(itemCollectionView.snp.top).offset(-8)
            make.height.equalTo(1)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(50)
        }
        
        allButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(dividerLineView2.snp.top).offset(-5)
            make.width.equalTo(50)
        }
        
        
    }
    
    
}

extension CategoryCell : UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = itemData?.count{
            return count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemCell
        cell.item = itemData?[indexPath.item]
        return cell
    }
}

extension CategoryCell {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = itemData?[indexPath.item] {
            mainController?.showDetailInformation(item: item)
        }
    }
    
}

extension CategoryCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize : CGRect = UIScreen.main.bounds
        
        //Ipad
        if screenSize.width > 750 {
            return CGSize(width: frame.width/3 - 14, height: frame.height-54)
        
        }
        
        return CGSize(width: frame.width/2 - 14, height: frame.height-54)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
