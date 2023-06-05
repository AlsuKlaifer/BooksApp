//
//  Section.swift
//  BooksApp
//
//  Created by Alsu Faizova on 05.06.2023.
//

import Foundation

enum Section {
    case read([BookModel])
    case favorite([BookModel])

    var items: [BookModel] {
        switch self {
        case .read(let items),
        .favorite(let items):
            return items
        }
    }
}
