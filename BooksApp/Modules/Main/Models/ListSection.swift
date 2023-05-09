//
//  ListSection.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.04.2023.
//

import Foundation

enum ListSection: Hashable {
    case new([ListItem])
    case category([ListItem])
    case popular([ListItem])

    var items: [ListItem] {
        switch self {
        case .new(let items),
            .category(let items),
            .popular(let items):
        return items
        }
    }
}

enum ListItem: Hashable {
    case book(Book)
    case category(String)
}
