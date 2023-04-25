//
//  ChangePasswordPresenter.swift
//  BooksApp
//
//  Created by Alsu Faizova on 09.04.2023.
//

import Foundation

class ChangePasswordPresenter {
    
    weak var view: ChangePasswordViewInput?

    private let output: ChangePasswordModuleOutput
    private let loginService: AuthorizationServiceProtocol

    init(loginService: AuthorizationServiceProtocol, output: ChangePasswordModuleOutput) {
        self.loginService = loginService
        self.output = output
    }
}

extension ChangePasswordPresenter: ChangePasswordViewOutput {
    
    func changePassword(password: String, newPassword: String) {
        loginService.changePassword(password: password, newPassword: newPassword) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success:
                self.output.moduleWantsToEnd(self)
            case .failure(let error):
                self.view?.showAlert(error.localizedDescription)
            }
        }
    }
}

extension ChangePasswordPresenter: ChangePasswordModuleInput {}
