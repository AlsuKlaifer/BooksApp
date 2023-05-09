//
//  MockData.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.04.2023.
//

import Foundation

struct MockData {

    static let shared = MockData()
    
//    var data: [ListSection] { [new, category, popular] }

    let new: ListSection = {
        .new([
//        ListItem.book(Book(title: "Book 1", author: "Author 1", image: "sun.max.fill")),
//        ListItem.book(Book(title: "Book 2", author: "Author 2", image: "sun.max.fill")),
//        ListItem.book(Book(title: "Book 3", author: "Author 3", image: "sun.max.fill")),
//        ListItem.book(Book(title: "Book 4", author: "Author 4", image: "sun.max.fill")),
//        ListItem.book(Book(title: "Book 5", author: "Author 5", image: "sun.max.fill")),
    ]) }()

    private let popular: ListSection = {
        .popular([
//            ListItem.book(Book(title: "Book 1", author: "Author 1", image: "book.closed.fill")),
//            ListItem.book(Book(title: "Book 2", author: "Author 2", image: "book.closed.fill")),
//            ListItem.book(Book(title: "Book 3", author: "Author 3", image: "book.closed.fill")),
//            ListItem.book(Book(title: "Book 4", author: "Author 4", image: "book.closed.fill")),
//            ListItem.book(Book(title: "Book 5", author: "Author 5", image: "book.closed.fill")),
//            ListItem.book(Book(title: "Book 6", author: "Author 5", image: "book.closed.fill")),
//            ListItem.book(Book(title: "Book 7", author: "Author 5", image: "book.closed.fill")),
//            ListItem.book(Book(title: "Book 8", author: "Author 5", image: "book.closed.fill"))
        ])
    }()
    
    let category: ListSection = {
        .category([
            ListItem.category("Category 1"),
            ListItem.category("Category 2"),
            ListItem.category("Category 3"),
            ListItem.category("Category 4"),
            ListItem.category("Category 5")
        ])
    }()
    
    let section: ListSection = {
        .category(
            ["1", "2", "3"].map({ item in
                ListItem.category(item)
            })
        )
    }()
}
