//
//  SearchModuleBuilder.swift
//  BooksApp
//
//  Created by Alsu Faizova on 06.06.2023.
//

import UIKit

final class SearchModuleBuilder {
    
    private let output: SearchModuleOutput
    
    init(output: SearchModuleOutput) {
        self.output = output
    }
    
    func build() -> UIViewController {
        let presenter = SearchPresenter(
            output: output,
            bookStorage: BookStorage(parser: BookParser()),
            networkService: NetworkService()
        )
        let viewController = SearchViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
    
    func buildResult() -> UIViewController {
//        let presenter = SearchPresenter(
//            output: output,
//            bookStorage: BookStorage(parser: BookParser()),
//            networkService: NetworkService()
//        )
//        let viewController = SearchResultsViewController(presenter: presenter)
//        presenter.resultView = viewController
//        return viewController
        return UIViewController()
    }
}
