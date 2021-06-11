//
//  NetworkDataFetcher.swift
//  ITestApp
//
//  Created by Stanislav on 08.06.2021.
//

import Foundation

class NetworkDataFetcher {

    private let networkService = NetworkService()

    func drinkCategoryFetch(urlString: String, completion: @escaping (DrinkCategory?, Error?) -> Void) {
        networkService.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("L10n.Error.errorReceivedRequestingData", error)
                completion(nil, error)
        }
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode(DrinkCategory.self, from: data)
            completion(response, nil)
        }
    }
    
    func drinkFetch(urlString: String, completion: @escaping (DrinkModel?, Error?) -> Void) {
        networkService.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("L10n.Error.errorReceivedRequestingData", error)
                completion(nil, error)
        }
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode(DrinkModel.self, from: data)
            completion(response, nil)
        }
    }

}
