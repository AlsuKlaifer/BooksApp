//
//  CacheManager.swift
//  BooksApp
//
//  Created by Alsu Faizova on 08.05.2023.
//

import UIKit
import Alamofire

final class CacheManager {

    static let shared = CacheManager()
    private let cache = NSCache<NSString, UIImage>()

    private init() { }

    func image(forUrl urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }

        let request = AF.download(urlString)
        request.responseData { [weak self] (response: AFDownloadResponse<Data>) in
            guard let data: Data = response.value,
                let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            self?.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
    }
}
