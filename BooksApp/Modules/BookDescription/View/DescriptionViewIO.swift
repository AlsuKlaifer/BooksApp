//
//  DescriptionViewIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 08.05.2023.
//

import Foundation

// view
protocol DescriptionViewInput: AnyObject {}

// presenter
protocol DescriptionViewOutput: AnyObject {
    var book: Book { get }
    var isFavorite: Bool { get }
    var isRead: Bool { get }
    func addToFavorite()
    func addToRead()
}
