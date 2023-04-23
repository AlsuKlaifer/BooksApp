//
//  ProfileCoordinator.swift
//  BooksApp
//
//  Created by Alsu Faizova on 13.04.2023.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        let viewController = SignOutModuleBuilder(output: self).build()
        viewController.tabBarItem = UITabBarItem.init(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        navigationController.viewControllers = [viewController]
    }
}

extension ProfileCoordinator: SignOutModuleOutput {}
