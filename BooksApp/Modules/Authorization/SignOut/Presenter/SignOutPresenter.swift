//
//  SignOutPresenter.swift
//  BooksApp
//
//  Created by Alsu Faizova on 09.04.2023.
//

import Foundation

class SignOutPresenter {
    weak var view: SignOutViewInput?

    private let output: SignOutModuleOutput
    private let loginService: AuthorizationServiceProtocol

    init(loginService: AuthorizationServiceProtocol, output: SignOutModuleOutput) {
        self.loginService = loginService
        self.output = output
    }
}

extension SignOutPresenter: SignOutViewOutput {
    func signOut() {
        loginService.signOut { [weak self] error in
            guard let self else { return }
            
            if let error = error {
                self.view?.showAlert(error.localizedDescription)
            }
        }
    }
}

extension SignUpPresenter: SignOutModuleInput { }
