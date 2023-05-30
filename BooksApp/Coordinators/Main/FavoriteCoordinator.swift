//
//  FavoriteCoordinator.swift
//  BooksApp
//
//  Created by Alsu Faizova on 13.04.2023.
//

import UIKit

final class FavoriteCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = FavoriteModuleBuilder(output: self).build()
        viewController.tabBarItem = UITabBarItem(title: "My books", image: UIImage(systemName: "bookmark"), tag: 1)
        navigationController.viewControllers = [viewController]
    }
}

extension FavoriteCoordinator: FavoriteModuleOutput {
    func didSelectBook(module: FavoriteModuleInput, book: Book) {
        let viewController = DescriptionModuleBuilder(book: book).build()
        navigationController.pushViewController(viewController, animated: true)
    }
}
