//
//  BooksModuleBuilder.swift
//  BooksApp
//
//  Created by Alsu Faizova on 11.05.2023.
//

import UIKit

final class BooksModuleBuilder {
    
    func build() -> UIViewController {
        let presenter = BooksPresenter(networkService: NetworkService())
        let viewController = BooksViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
