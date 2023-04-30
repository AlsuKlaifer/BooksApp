//
//  ChangePasswordModuleBuilder.swift
//  BooksApp
//
//  Created by Alsu Faizova on 09.04.2023.
//

import UIKit

final class ChangePaswordModuleBuilder {
    
    private let output: ChangePasswordModuleOutput
    
    init(output: ChangePasswordModuleOutput) {
        self.output = output
    }
    
    func build() -> UIViewController {
        let presenter = ChangePasswordPresenter(loginService: AuthorizationService(), output: output)
        let view = ChangePasswordViewController(output: presenter)
        presenter.view = view
        return view
    }
}
