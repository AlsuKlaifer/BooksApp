//
//  LoginModuleBuilder.swift
//  BooksApp
//
//  Created by Alsu Faizova on 09.04.2023.
//

import UIKit

final class LoginModuleBuilder {
    private let output: LoginModuleOutput
    
    init(output: LoginModuleOutput) {
        self.output = output
    }
    
    func build() -> UIViewController {
        let presenter = LoginPresenter(loginService: AuthorizationService(), output: output)
        let view = LoginViewController(output: presenter)
        presenter.view = view
        return view
    }
}
