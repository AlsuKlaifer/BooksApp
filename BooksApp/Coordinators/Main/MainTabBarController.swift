//
//  MainTabBarController.swift
//  BooksApp
//
//  Created by Alsu Faizova on 13.04.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    let booksCoordinator = BooksCoordinator(navigationController: UINavigationController())
    let favoriteCoordinator = FavoriteCoordinator(navigationController: UINavigationController())
    let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .systemBackground
        self.tabBar.tintColor = .label
    
        booksCoordinator.start()
        favoriteCoordinator.start()
        profileCoordinator.start()
        
        viewControllers = [
            booksCoordinator.navigationController,
            favoriteCoordinator.navigationController,
            profileCoordinator.navigationController
        ]
    }
}
