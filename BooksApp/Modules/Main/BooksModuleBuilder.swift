//
//  BooksModuleBuilder.swift
//  BooksApp
//
//  Created by Alsu Faizova on 11.05.2023.
//

import UIKit

final class BooksModuleBuilder {
    
    private let output: BooksModuleOutput
    
    init(output: BooksModuleOutput) {
        self.output = output
    }
    
    func build() -> UIViewController {
        let presenter = BooksPresenter(output: output, networkService: NetworkService())
        let viewController = BooksViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
