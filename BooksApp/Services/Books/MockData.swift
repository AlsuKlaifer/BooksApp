//
//  MockData.swift
//  BooksApp
//
//  Created by Alsu Faizova on 27.04.2023.
//

import Foundation

struct MockData {
    
    static let shared = MockData()
    
    private let new: ListSection = {
        .new([
            .init(title: "Book 1", author: "Author 1", image: "text.book.closed"),
            .init(title: "Book 2", author: "Author 2", image: "text.book.closed"),
            .init(title: "Book 3", author: "Author 3", image: "text.book.closed"),
            .init(title: "Book 4", author: "Author 4", image: "text.book.closed"),
            .init(title: "Book 5", author: "Author 5", image: "text.book.closed")
        ])
    }()
    
    private let popular: ListSection = {
        .popular([
            .init(title: "Book 1", author: "Author 1", image: "book.closed.fill"),
            .init(title: "Book 2", author: "Author 2", image: "book.closed.fill"),
            .init(title: "Book 3", author: "Author 3", image: "book.closed.fill"),
            .init(title: "Book 4", author: "Author 4", image: "book.closed.fill"),
            .init(title: "Book 5", author: "Author 5", image: "book.closed.fill")
        ])
    }()
    
    private let category: ListSection = {
        .category([
            .init(title: "Category 1", author: "Author 1", image: "book.closed"),
            .init(title: "Category 2", author: "Author 2", image: "book.closed"),
            .init(title: "Category 3", author: "Author 3", image: "book.closed"),
            .init(title: "Category 4", author: "Author 4", image: "book.closed"),
            .init(title: "Category 5", author: "Author 5", image: "book.closed")
        ])
    }()
    
    var data: [ListSection] {
        [new, category, popular]
    }
}
