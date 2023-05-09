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
        
        let presenter = BooksPresenter(networkService: NetworkService())
        let viewController = BooksViewController(presenter: presenter)
        presenter.view = viewController
        viewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        navigationController.viewControllers = [viewController]
    }
}
