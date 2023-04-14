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
    
    func moduleWantsToEndAuth(_ module: LoginModuleInput) {
        let presenter = SignOutPresenter(loginService: AuthorizationService(), output: self)
        let signOutViewController = SignOutViewController(output: presenter)
        presenter.view = signOutViewController
    }
    
    func moduleWantsToSignUp(_ module: LoginModuleInput) {
        let signUpViewController = SignUpModuleBuilder(output: self).build()
        self.navigationController.pushViewController(signUpViewController, animated: true)
    }
}

extension AuthCoordinator: SignUpModuleOutput {
    
    func moduleWantsToEndAuth(_ module: SignUpModuleInput) {
        let presenter = SignOutPresenter(loginService: AuthorizationService(), output: self)
        let signOutViewController = SignOutViewController(output: presenter)
        presenter.view = signOutViewController
    }
}

extension AuthCoordinator: SignOutModuleOutput {}
