//
//  ListSection.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.04.2023.
//

import Foundation

enum ListSection: Hashable {
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
}
