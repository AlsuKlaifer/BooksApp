//
//  AuthorizationService.swift
//  BooksApp
//
//  Created by Alsu Faizova on 02.04.2023.
//

import Foundation
import FirebaseAuth

class AuthorizationService: AuthorizationServiceProtocol {
    
    func login(login: String, password: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        Auth.auth().signIn(withEmail: login, password: password) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func signUp(login: String, password: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        Auth.auth().createUser(withEmail: login, password: password) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func signOut(completion: @escaping ((Result<Void, Error>) -> Void)) {
        do {
            try Auth.auth().signOut()
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func changePassword(password: String, newPassword: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        guard let user = Auth.auth().currentUser else { return }
        guard let email = user.email else { return }
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        Auth.auth().currentUser?.reauthenticate(with: credential) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }
    
    func getUser() -> String {
        guard let user = Auth.auth().currentUser else { return "" }
        return user.uid
    }
}
