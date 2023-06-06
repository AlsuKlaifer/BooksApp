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
    private let firestoreManager: FirestoreManagerProtocol

    init(
        loginService: AuthorizationServiceProtocol,
        output: SignUpModuleOutput,
        firestoreManager: FirestoreManagerProtocol
    ) {
        self.loginService = loginService
        self.output = output
        self.firestoreManager = firestoreManager
    }
}

extension SignUpPresenter: SignUpViewOutput {

    func signUp(name: String, _ email: String, _ password: String) {
        loginService.signUp(login: email, password: password) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success:
                let id = self.loginService.getUser()
                self.firestoreManager.writeUser(collection: "users", document: id, name: name, email: email)
            case .failure(let error):
                self.view?.showAlert(error.localizedDescription)
            }
        }
    }
}

extension SignUpPresenter: SignUpModuleInput { }
