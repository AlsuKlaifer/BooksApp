//
//  MockData.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.04.2023.
//

import Foundation

struct MockData {

    static let shared = MockData()
    
    let category: ListSection = {
        .category([
            ListItem.category("Category 1"),
            ListItem.category("Category 2"),
            ListItem.category("Category 3"),
            ListItem.category("Category 4"),
            ListItem.category("Category 5")
        ])
    }()
}
