//
//  DetailController.swift
//  itvTask
//
//  Created by Jahongir Nematov on 6/14/19.
//  Copyright © 2019 Jahongir Nematov. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import BMPlayer

class DetailController : UIViewController {
    
    let player = BMPlayer()
    
    var itemDetail : Details? {
        didSet {
            setupInfo()
        }
    }
    
    var item : Item? {
        didSet {
            if let categoryId = item?.categoryId, let id = item?.id {
                let urlString = Constants.mainUrlString + "\(categoryId)/show/\(id)?\(Constants.tokenString)"
                fetchDetailInfo(urlString: urlString)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
//    override open var shouldAutorotate: Bool {
//        return false
//    }
    
    func fetchDetailInfo (urlString : String) {
        NetworkingService.shared.getMovieDetails(urlString: urlString, category: "movies", categoryId: 2) { (response) in
            self.itemDetail = response
        }
        
    }
    
    func setupInfo() {
        if let posterUrl = itemDetail?.posterUrl {
            let url = URL(string: posterUrl)
            self.itemImageView.kf.indicatorType = .activity
            self.itemImageView.kf.setImage(with: url)
        }
        
        if let title = itemDetail?.title {
            itemTitleLabel.text = title
        }
        
        if let genre = itemDetail?.genres {
            itemGenreLabel.text = genre
        }
        
        if let description = itemDetail?.description {
            
            itemDescriptionTextView.text = description.decodingHTMLEntities()
        }
        
        if let rate = itemDetail?.rate {
            itemItvLabel.text = String(rate.itv)
            itemKinopoiskLabel.text = String(rate.kinopoisk)
            itemImdbLabel.text = String(rate.imdb)
        }
        
    }
    
    @objc func play() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        player.isHidden = false
        playButton.isHidden = true
        var videoUrl = "https://itv.uz/uploads/video/222.mp4"
        if itemDetail?.videoUrl != "" {
            videoUrl = itemDetail!.videoUrl
        }
        let asset = BMPlayerResource(url: URL(string: videoUrl)!,name: "video")
        player.setVideo(resource: asset)
        player.play()
    }

    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = false
        //scrollView.contentSize = CGSize(width: 200, height: 1000)
        return scrollView
    }()
    
    let backView : UIView = {
        let backView = UIView()
        return backView
    }()
    
    let blackViewWithAlpha : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return view
    }()
    
    let itemImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let playButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let itemTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 2
        return label
    }()
    
    let itemItvLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let itemImdbLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    let itemKinopoiskLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let itvLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "iTV"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let imdbLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "IMDb"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    let kinopoiskLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "KinoPoisk"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
    let itemGenreLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.backgroundColor = .clear
        label.numberOfLines = 2
        return label
    }()
    
    let genreLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Genre: "
        label.textColor = .gray
        label.backgroundColor = .clear
        label.numberOfLines = 2
        return label
    }()
    
    let itemDescriptionTextView : UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.backgroundColor = .clear
        textView.isEditable = false
        
        return textView
    }()
    
    
    
    func setupView() {
        view.backgroundColor = .black
        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        
        player.isHidden = true
        
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(backView)
        self.backView.addSubview(itemImageView)
        self.backView.addSubview(genreLabel)
        self.backView.addSubview(itemGenreLabel)
        self.backView.addSubview(itemDescriptionTextView)
        self.itemImageView.addSubview(blackViewWithAlpha)
        self.itemImageView.addSubview(itemItvLabel)
        self.itemImageView.addSubview(itemImdbLabel)
        self.itemImageView.addSubview(itemKinopoiskLabel)
        self.itemImageView.addSubview(itemTitleLabel)
        self.itemImageView.addSubview(itvLabel)
        self.itemImageView.addSubview(imdbLabel)
        self.itemImageView.addSubview(kinopoiskLabel)
        self.view.addSubview(player)
        self.view.addSubview(playButton)
        
        player.snp.makeConstraints { (make) in
            //make.top.equalTo(self.view).offset(20)
            make.center.equalToSuperview()
            make.left.right.equalTo(self.view)
            // Note here, the aspect ratio 16:9 priority is lower than 1000 on the line, because the 4S iPhone aspect ratio is not 16:9
            //make.height.equalTo(player.snp.width).multipliedBy(9.0/16.0).priority(750)
            make.top.bottom.equalToSuperview()
        }
        
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true { return }
            let _ = self.navigationController?.popViewController(animated: true)
        }
        
        
        scrollView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        backView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        itemImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.width * 10/7)
        }
        
        playButton.snp.makeConstraints { (make) in
            make.center.equalTo(itemImageView)
            make.width.height.equalTo(100)
        }
        
        blackViewWithAlpha.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        itvLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(view.frame.width/3)
            make.height.equalTo(40)
        }
        
        imdbLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(view.frame.width/3)
            make.height.equalTo(40)
        }
        
        kinopoiskLabel.snp.makeConstraints { (make) in
            make.left.equalTo(itvLabel.snp.right)
            make.right.equalTo(imdbLabel.snp.left)
            make.bottom.equalToSuperview()
            make.width.equalTo(view.frame.width/3)
            make.height.equalTo(40)
        }
        
        itemItvLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalTo(itvLabel.snp.top)
            make.width.equalTo(view.frame.width/3)
            make.height.equalTo(40)
        }
        
        itemImdbLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.bottom.equalTo(itvLabel.snp.top)
            make.width.equalTo(view.frame.width/3)
            make.height.equalTo(40)
        }
        
        itemKinopoiskLabel.snp.makeConstraints { (make) in
            make.left.equalTo(itemItvLabel.snp.right)
            make.right.equalTo(itemImdbLabel.snp.left)
            make.bottom.equalTo(itvLabel.snp.top)
            make.width.equalTo(view.frame.width/3)
            make.height.equalTo(45)
        }
        
        itemTitleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(itemItvLabel.snp.top)
            make.height.equalTo(100)
        }
        
        genreLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(itemImageView.snp.bottom)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        itemGenreLabel.snp.makeConstraints { (make) in
            make.left.equalTo(genreLabel.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(itemImageView.snp.bottom)
            make.height.equalTo(100)
        }
        
        itemDescriptionTextView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(itemGenreLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(view.frame.width-20)

        }
        
    }
    
    
}
