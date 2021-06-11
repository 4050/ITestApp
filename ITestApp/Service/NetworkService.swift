//
//  NetworkService.swift
//  ITestApp
//
//  Created by Stanislav on 08.06.2021.
//

import Foundation

class NetworkService {

    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let urlString = URL(string: urlString) else { return }
        let request = URLRequest(url: urlString)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func createDataTask(from requst: URLRequest,
                                completion: @escaping (Data?, Error?) -> Void)
        -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: requst, completionHandler: { (data, _, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
}
