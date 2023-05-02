//
//  MockData.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.04.2023.
//

import Foundation

struct MockData {

    static let shared = MockData()

    private let new: ListSection = {
        .new([
            .init(title: "Book 1", author: "Author 1", image: "sun.max.fill"),
            .init(title: "Book 2", author: "Author 2", image: "sun.max.fill"),
            .init(title: "Book 3", author: "Author 3", image: "sun.max.fill"),
            .init(title: "Book 4", author: "Author 4", image: "sun.max.fill"),
            .init(title: "Book 5", author: "Author 5", image: "sun.max.fill")
        ])
    }()

    private let popular: ListSection = {
        .popular([
            .init(title: "Book 1", author: "Author 1", image: "book.closed.fill"),
            .init(title: "Book 2", author: "Author 2", image: "book.closed.fill"),
            .init(title: "Book 3", author: "Author 3", image: "book.closed.fill"),
            .init(title: "Book 4", author: "Author 4", image: "book.closed.fill"),
            .init(title: "Book 5", author: "Author 5", image: "book.closed.fill"),
            .init(title: "Book 6", author: "Author 5", image: "book.closed.fill"),
            .init(title: "Book 7", author: "Author 5", image: "book.closed.fill"),
            .init(title: "Book 8", author: "Author 5", image: "book.closed.fill")
        ])
    }()

    private let category: ListSection = {
        .category([
            .init(title: "Category 1", author: "", image: ""),
            .init(title: "Category 2", author: "", image: ""),
            .init(title: "Category 3", author: "", image: ""),
            .init(title: "Category 4", author: "", image: ""),
            .init(title: "Category 5", author: "", image: "")
        ])
    }()

    var data: [ListSection] {
        [new, category, popular]
    }
}
