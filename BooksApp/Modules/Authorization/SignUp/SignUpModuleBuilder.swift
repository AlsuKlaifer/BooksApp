//
//  SignUpModuleBuilder.swift
//  BooksApp
//
//  Created by Alsu Faizova on 09.04.2023.
//

import UIKit

final class SignUpModuleBuilder {
    
    private let output: SignUpModuleOutput
    
    init(output: SignUpModuleOutput) {
        self.output = output
    }
    
    func build() -> UIViewController {
        let presenter = SignUpPresenter(loginService: AuthorizationService(), output: output)
        let view = SignUpViewController(output: presenter)
        presenter.view = view
        return view
    }
}
