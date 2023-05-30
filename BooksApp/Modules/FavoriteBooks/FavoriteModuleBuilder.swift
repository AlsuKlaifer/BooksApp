//
//  FavoriteModuleBuilder.swift
//  BooksApp
//
//  Created by Alsu Faizova on 25.05.2023.
//

import UIKit

final class FavoriteModuleBuilder {
    
    private let output: FavoriteModuleOutput
    
    init(output: FavoriteModuleOutput) {
        self.output = output
    }
    
    func build() -> UIViewController {
        let presenter = FavoritePresenter(output: output, bookStorage: BookStorage(parser: BookParser()), bookParser: BookParser())
        let viewController = FavoriteViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
