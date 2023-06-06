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
    private let firestoreManager: FirestoreManagerProtocol

    init(
        loginService: AuthorizationServiceProtocol,
        output: SignOutModuleOutput,
        firestoreManager: FirestoreManagerProtocol
    ) {
        self.loginService = loginService
        self.output = output
        self.firestoreManager = firestoreManager
    }
}

extension SignOutPresenter: SignOutViewOutput {
    
    func signOut() {
        loginService.signOut { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success:
                return
            case .failure(let error):
                self.view?.showAlert(error.localizedDescription)
            }
        }
    }
    
    func changePassword() {
        output.moduleWantsToChangePassword(self)
    }
    
    func getUser(completion: @escaping (User?) -> Void) {
        let id = loginService.getUser()
        firestoreManager.getUser(collection: "users", document: id) { user in
            completion(user)
        }
    }
}

extension SignUpPresenter: SignOutModuleInput {}

extension SignOutPresenter: SignOutModuleInput {}
