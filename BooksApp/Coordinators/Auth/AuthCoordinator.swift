//
//  AuthCoordinator.swift
//  BooksApp
//
//  Created by Alsu Faizova on 12.04.2023.
//

import UIKit

final class AuthCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LoginModuleBuilder(output: self).build()
        self.navigationController = UINavigationController(rootViewController: loginViewController)
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
}

extension AuthCoordinator: LoginModuleOutput {
    
    func moduleWantsToSignUp(_ module: LoginModuleInput) {
        let signUpViewController = SignUpModuleBuilder(output: self).build()
        self.navigationController.pushViewController(signUpViewController, animated: true)
    }
}

extension AuthCoordinator: SignUpModuleOutput {}

extension AuthCoordinator: SignOutModuleOutput {}

extension AuthCoordinator: AuthFlowInput {}
