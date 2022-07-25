//
//  ImageLoader.swift
//  Picterest
//
//  Created by yc on 2022/07/26.
//

import UIKit

enum ImageLoaderError: Error {
    case unknown
}

class ImageLoader {
    static let shared = ImageLoader()
    private init() {}
    
    func downloadImage(
        urlString: String,
        completion: @escaping (Result<UIImage, ImageLoaderError>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.unknown))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.unknown))
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(.unknown))
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data) else {
                completion(.failure(.unknown))
                return
            }
            
            completion(.success(image))
        }.resume()
    }
}
