//
//  AppCoordinator.swift
//  BooksApp
//
//  Created by Alsu Faizova on 03.04.2023.
//

import UIKit
import FirebaseAuth

class AppCoordinator {
    var window: UIWindow?
    private var navigationController: UINavigationController?
    
    func start(_ scene: UIWindowScene) {
        let window = UIWindow(windowScene: scene)
        self.window = window
        
        Auth.auth().addStateDidChangeListener { _, user in
            if user == nil {
                let loginViewController = LoginModuleBuilder(output: self).build()
                self.navigationController = UINavigationController(rootViewController: loginViewController)
                self.navigationController?.navigationBar.prefersLargeTitles = true
                window.rootViewController = self.navigationController
            } else {
                let signOutViewController = SignOutModuleBuilder(output: self).build()
                window.rootViewController = signOutViewController
            }
        }
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: SignOutModuleOutput {
}

extension AppCoordinator: LoginModuleOutput {
    func moduleWantsToSignUp(_ module: LoginModuleInput) {
        let signUpViewController = SignUpModuleBuilder(output: self).build()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    func moduleWantsToEndAuth(_ module: LoginModuleInput) {
        let presenter = SignOutPresenter(loginService: AuthorizationService(), output: self)
        let signOutViewController = SignOutViewController(output: presenter)
        presenter.view = signOutViewController
        window?.rootViewController = signOutViewController
        window?.makeKeyAndVisible()
    }
}

extension AppCoordinator: SignUpModuleOutput {
    func moduleWantsToEndAuth(_ module: SignUpModuleInput) {
        let presenter = SignOutPresenter(loginService: AuthorizationService(), output: self)
        let signOutViewController = SignOutViewController(output: presenter)
        presenter.view = signOutViewController
        window?.rootViewController = signOutViewController
        window?.makeKeyAndVisible()
    }
}
