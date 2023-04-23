//
//  SignUpPresenter.swift
//  BooksApp
//
//  Created by Alsu Faizova on 09.04.2023.
//

import Foundation

class SignUpPresenter {
    
    weak var view: SignUpViewInput?
    
    private let output: SignUpModuleOutput
    private let loginService: AuthorizationServiceProtocol
    
    init(loginService: AuthorizationServiceProtocol, output: SignUpModuleOutput) {
        self.loginService = loginService
        self.output = output
    }
}

extension SignUpPresenter: SignUpViewOutput {
    
    func signUp(_ email: String, _ password: String) {
        loginService.signUp(login: email, password: email) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success:
                break
            case .failure(let error):
                self.view?.showAlert(error.localizedDescription)
            }
        }
    }
}

extension SignUpPresenter: SignUpModuleInput {}
