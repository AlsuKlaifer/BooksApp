//
//  UIImageView+Extensions.swift
//  BooksApp
//
//  Created by Alsu Faizova on 08.05.2023.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from urlString: String) {
        CacheManager.shared.image(forUrl: urlString) { [weak self] (image: UIImage?) in
            self?.image = image
        }
    }
}
