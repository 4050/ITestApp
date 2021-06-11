//
//  ImageDownloadService.swift
//  ITestApp
//
//  Created by Stanislav on 09.06.2021.
//

import Foundation

class ImageDownloadService {
    func fetchImage(urlString: String, completion: @escaping (_ data: Data?) -> ()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!){ (data, _, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("Error fetching the image!")
                    completion(nil)
                } else {
                    completion(data)
                }
            }
        }.resume()
    }
}
