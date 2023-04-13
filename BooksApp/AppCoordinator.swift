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
        
    func start(_ scene: UIWindowScene) {
        let window = UIWindow(windowScene: scene)
        self.window = window
        
        Auth.auth().addStateDidChangeListener { _, user in
            if user == nil {
                self.showAuthFlow()
            } else {
                self.showMainFlow()
            }
        }
    }
    
    func showAuthFlow() {
        let authCoordinator = CoordinatorFactory().createAuthCoordinator(navigationController: UINavigationController())
        authCoordinator.start()
        window?.rootViewController = authCoordinator.navigationController
        window?.makeKeyAndVisible()
    }
    
    func showMainFlow() {
        let signOutViewController = SignOutModuleBuilder(output: self).build()
        window?.rootViewController = signOutViewController
        window?.makeKeyAndVisible()
    }
}

extension AppCoordinator: SignOutModuleOutput {}
