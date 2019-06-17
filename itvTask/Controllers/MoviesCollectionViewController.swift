//
//  MoviesCollectionViewController.swift
//  itvTask
//
//  Created by Jahongir Nematov on 6/15/19.
//  Copyright © 2019 Jahongir Nematov. All rights reserved.
//

import UIKit

class MoviesCollectionViewController: UICollectionViewController {

    private let moviesCellId = "moviesCellId"
    
    var moviesData : [Item] = []
    var pager = 1
    var loadMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies(page: 1)
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
    
    func setupView() {
        self.title = "Movies"
        collectionView.backgroundColor = .black
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: moviesCellId)
    }
    
    func getMovies(page : Int) {
        let urlString = Constants.mainUrlString + "2/list?items=15&page=\(page)&" + Constants.tokenString

        NetworkingService.shared.getDatas(urlString: urlString, category: "movies", categoryId: 2) { (response) in
            self.moviesData.append(contentsOf: response)
            self.collectionView.reloadData()
            self.loadMore = false
        }
    }
    
    


}

extension MoviesCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moviesCellId, for: indexPath) as! ItemCell
        cell.item = moviesData[indexPath.item]
        return cell
    }
}


extension MoviesCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = DetailController()
        detailController.item = moviesData[indexPath.item]
        navigationController?.pushViewController(detailController, animated: true)
    }
    
}

extension MoviesCollectionViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height * 2 {
            if !loadMore {
                pager += 1
                loadMorePage(page: pager)
            }
        }
    }
    
    func loadMorePage(page : Int) {
        loadMore = true
        getMovies(page: page)
        
    }
}

extension MoviesCollectionViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize : CGRect = UIScreen.main.bounds
        
        let width = view.frame.width
        //iPad
        if screenSize.width > 750 {
            
            return CGSize(width: (width - 50)/4, height: (width - 50)*5/14 )
        }
        
        
        return CGSize(width: (width - 30)/2, height: (width - 30)*5/7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    
}
