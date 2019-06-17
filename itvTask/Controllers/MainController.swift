//
//  ViewController.swift
//  itvTask
//
//  Created by Jahongir Nematov on 6/14/19.
//  Copyright © 2019 Jahongir Nematov. All rights reserved.
//

import UIKit

class MainController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellId"
    private let littleCategoryCellId = "littleCategoryCellId"

    var moviesData   : [Item]?
    var channelsData : [Item]?
    var clipsData    : [Item]?
    var count : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupView()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    func setupView() {
        collectionView.backgroundColor = .black
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LittleCategoryCell.self, forCellWithReuseIdentifier: littleCategoryCellId)
    }
    
    func getData() {
        NetworkingService.shared.getDatas(urlString: Constants.urlString1, category: Constants.categories[0], categoryId: 1) { (response) in
            self.channelsData = response
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        NetworkingService.shared.getDatas(urlString: Constants.urlString2, category: Constants.categories[1], categoryId: 2) { (response) in
            self.moviesData = response
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        NetworkingService.shared.getDatas(urlString: Constants.urlString3, category: Constants.categories[2], categoryId: 3) { (response) in
            self.clipsData = response
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func showDetailInformation(item : Item) {
        if item.categoryId == 2 {
            let detailController = DetailController()
            detailController.item = item
            navigationController?.pushViewController(detailController, animated: true)
        }
    }

}

extension MainController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: littleCategoryCellId, for: indexPath) as! LittleCategoryCell
        if indexPath.item == 0 {
            cell.categoryLabel.text = "Channels"
            cell.itemData = self.channelsData
        }
        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
            cell.categoryLabel.text = "Movies"
            cell.allButton.isHidden = false
            cell.itemData = self.moviesData
            cell.mainController = self
            cell.delegate = self
            return cell
        }
        if indexPath.item == 2 {
            cell.categoryLabel.text = "Clips"
            cell.itemData = self.clipsData
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (moviesData?.count) != nil {
            return 3
        }
        return 0
    }
    
}

extension MainController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize : CGRect = UIScreen.main.bounds
        
        let width = view.frame.width
        
        //Ipad
        if screenSize.width > 750 {
            if indexPath.item == 0 {
                return CGSize(width: width, height: width/5 + 40)
            }
            if indexPath.item == 1 {
                return CGSize(width: width, height: width * 10/21 + 40)
            }
            if indexPath.item == 2 {
                return CGSize(width: width, height: width * 10/35 + 40)
            }
        }
        
        if indexPath.item == 0 {
            return CGSize(width: view.frame.width, height: view.frame.width/3 + 40)
        }
        if indexPath.item == 1 {
            return CGSize(width: view.frame.width, height: view.frame.width * 5/7 + 40)
        }
        if indexPath.item == 2 {
            return CGSize(width: view.frame.width, height: view.frame.width * 10/21 + 40)
        }
        
        return CGSize(width: view.frame.width, height: view.frame.width)
        
        
        
    }
}


extension MainController : allMoviesDelegate {
    
    func didTapAllButton(title: String) {
        let layout = UICollectionViewFlowLayout()
        let moviesController = MoviesCollectionViewController(collectionViewLayout: layout)
        navigationController?.pushViewController(moviesController, animated: true)
    }
    
}
