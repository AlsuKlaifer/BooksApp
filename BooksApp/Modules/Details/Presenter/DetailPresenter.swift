//
//  DetailPresenter.swift
//  BooksApp
//
//  Created by Alsu Faizova on 01.06.2023.
//

import Foundation

final class DetailPresenter {
    
    // Dependencies
    weak var view: DetailViewInput?

    // Properties
    var book: Book
    
    // MARK: - Initialization

    init(book: Book) {
        self.book = book
    }
}

extension DetailPresenter: DetailViewOutput {}
