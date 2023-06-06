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
            ListItem.category("Popular"),
            ListItem.category("Fantastic"),
            ListItem.category("IT"),
            ListItem.category("Psychology"),
            ListItem.category("Classic")
        ])
    }()
}
