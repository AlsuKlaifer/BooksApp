//
//  BooksCoordinator.swift
//  BooksApp
//
//  Created by Alsu Faizova on 13.04.2023.
//

import UIKit

final class BooksCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = BooksModuleBuilder(output: self).build()
        viewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        navigationController.viewControllers = [viewController]
    }
}

extension BooksCoordinator: BooksModuleOutput {
    
    func didSelectBook(module: BooksModuleInput, book: Book) {
        let viewController = DescriptionModuleBuilder().build(book: book)
        navigationController.pushViewController(viewController, animated: true)
    }
}
