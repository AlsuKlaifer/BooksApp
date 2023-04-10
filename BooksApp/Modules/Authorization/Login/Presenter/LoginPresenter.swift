//
//  LoginPresenter.swift
//  BooksApp
//
//  Created by Alsu Faizova on 02.04.2023.
//

import Foundation
import FirebaseAuth

class LoginPresenter {
    weak var view: LoginViewInput?
    
    private let output: LoginModuleOutput
    private let loginService: AuthorizationServiceProtocol
    
    init(loginService: AuthorizationServiceProtocol, output: LoginModuleOutput) {
        self.loginService = loginService
        self.output = output
    }
}

extension LoginPresenter: LoginViewOutput {
    func login(_ email: String, _ password: String) {
        loginService.login(login: email, password: password) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success:
                self.output.moduleWantsToEndAuth(self)
            case .failure(let error):
                self.view?.showAlert(error.localizedDescription)
            }
        }
    }
    
    func signUp() {
        output.moduleWantsToSignUp(self)
    }
}

extension LoginPresenter: LoginModuleInput {}
