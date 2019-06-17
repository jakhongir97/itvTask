//
//  Networking.swift
//  itvTask
//
//  Created by Jahongir Nematov on 6/14/19.
//  Copyright © 2019 Jahongir Nematov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct NetworkingService {
    
    static var shared = NetworkingService()
    private init() {}
    
    mutating func getDatas (urlString : String ,category : String , categoryId : Int , success successBlock: @escaping ([Item]) -> Void) {
        Alamofire.request(urlString).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                var itemData : [Item] = []
                let json = JSON(value)
                let data = json["data"]
                data[category].array?.forEach({ (item) in
                    let item = Item(title: item["title"].stringValue, posterUrl: item["files"]["poster_url"].stringValue, id: item["id"].intValue, categoryId: 2)
                    itemData.append(item)
                })
                successBlock(itemData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    mutating func getMovieDetails (urlString : String ,category : String , categoryId : Int , success successBlock: @escaping (Details) -> Void) {
        Alamofire.request(urlString).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                let item = data["movie"]
                let rate = Rate(imdb: item["rates"]["imdb"].doubleValue, kinopoisk: item["rates"]["kinopoisk"].doubleValue, itv: item["rates"]["itv"].doubleValue)
                let itemDetail = Details(posterUrl: item["files"]["poster_url"].stringValue, rate: rate, genres: item["genres_str"].stringValue, title: item["title"].stringValue, description: item["description"].stringValue, videoUrl: item["files"]["video_sd"]["video_url"].stringValue)
                successBlock(itemDetail)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
