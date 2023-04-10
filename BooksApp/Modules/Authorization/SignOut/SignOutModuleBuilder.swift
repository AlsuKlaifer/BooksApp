//
//  SignOutModuleBuilder.swift
//  BooksApp
//
//  Created by Alsu Faizova on 09.04.2023.
//

import UIKit

final class SignOutModuleBuilder {
    private let output: SignOutModuleOutput
    
    init(output: SignOutModuleOutput) {
        self.output = output
    }
    
    func build() -> UIViewController {
        let presenter = SignOutPresenter(loginService: AuthorizationService(), output: output)
        let view = SignOutViewController(output: presenter)
        presenter.view = view
        return view
    }
}
