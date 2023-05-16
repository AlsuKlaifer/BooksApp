//
//  DescriptionModuleBuilder.swift
//  BooksApp
//
//  Created by Alsu Faizova on 16.05.2023.
//

import UIKit

final class DescriptionModuleBuilder {
    
    func build(book: Book) -> UIViewController {
        let presenter = DescriptionPresenter(book: book)
        let viewController = DescriptionViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
