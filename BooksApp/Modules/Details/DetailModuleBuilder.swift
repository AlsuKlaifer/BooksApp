//
//  DetailModuleBuilder.swift
//  BooksApp
//
//  Created by Alsu Faizova on 01.06.2023.
//

import UIKit

final class DetailModuleBuilder {
    
    private let book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    func build() -> DetailViewController {
        let presenter = DetailPresenter(book: book)
        let viewController = DetailViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
