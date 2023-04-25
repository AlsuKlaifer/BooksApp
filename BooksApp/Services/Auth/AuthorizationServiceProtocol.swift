//
//  AuthorizationServiceProtocol.swift
//  BooksApp
//
//  Created by Alsu Faizova on 02.04.2023.
//

import Foundation

protocol AuthorizationServiceProtocol {
    func login(login: String, password: String, completion: @escaping ((Result<Void, Error>) -> Void))
    func signUp(login: String, password: String, completion: @escaping ((Result<Void, Error>) -> Void))
    func signOut(completion: @escaping ((Result<Void, Error>) -> Void))
    
    func changePassword(password: String, newPassword: String, completion: @escaping ((Result<Void, Error>) -> Void))
}
