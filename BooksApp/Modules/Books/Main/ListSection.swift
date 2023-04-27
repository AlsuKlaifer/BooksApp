//
//  ListSection.swift
//  BooksApp
//
//  Created by Alsu Faizova on 27.04.2023.
//

import Foundation

enum ListSection {
    case new([Book])
    case category([Book])
    case popular([Book])
    
    var items: [Book] {
        switch self {
        case .new(let items),
            .category(let items),
            .popular(let items):
            return items
        }
    }
    
    var count: Int {
        return items.count
    }
    
    var title: String {
        switch self {
        case .new(_):
            return ""
        case .category(_):
            return "Recommend"
        case .popular(_):
            return "Popular"
        }
    }
}
