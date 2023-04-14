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
        navigationController.navigationBar.prefersLargeTitles = true
        let viewController = FavoriteViewController()
        viewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "bookmark"), tag: 1)
        navigationController.viewControllers = [viewController]
    }
}
