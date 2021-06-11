//
//  ResponseDrinkModel.swift
//  ITestApp
//
//  Created by Stanislav on 09.06.2021.
//

import Foundation

class ResponseDrinkModel {
    
     private let networkDataFetch = NetworkDataFetcher()
     private let imageDownloadService = ImageDownloadService()
    
    func getCategoryDrink(urlString: String, completion: @escaping (DrinkCategory?) -> Void) {
        networkDataFetch.drinkCategoryFetch(urlString: urlString) {(response, error) in
            completion(response)
        }
    }
    
    func getDrink(urlString: String, completion: @escaping (DrinkModel?) -> Void) {
        networkDataFetch.drinkFetch(urlString: urlString) {(response, error) in
            completion(response)
        }
    }
    
    func downloadImage(url: String, completion: @escaping (Data?) -> Void){
           imageDownloadService.fetchImage(urlString: url) { (data) in
               completion(data)
           }
       }
    
}
