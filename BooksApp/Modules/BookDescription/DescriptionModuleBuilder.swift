//
//  DescriptionModuleBuilder.swift
//  BooksApp
//
//  Created by Alsu Faizova on 16.05.2023.
//

import UIKit

final class DescriptionModuleBuilder {
    
    private let book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    func build() -> UIViewController {
        let presenter = DescriptionPresenter(book: book, bookStorage: BookStorage(conversion: Conversion.shared))
        let viewController = DescriptionViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
