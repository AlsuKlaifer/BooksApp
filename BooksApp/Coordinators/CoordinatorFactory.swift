//
//  CoordinatorFactory.swift
//  BooksApp
//
//  Created by Alsu Faizova on 12.04.2023.
//

import UIKit

class CoordinatorFactory {
    
    func createAuthCoordinator(navigationController: UINavigationController) -> AuthCoordinator {
        AuthCoordinator.init(navigationController: navigationController)
    }
}
