//
//  LoginView.swift
//  BooksApp
//
//  Created by Alsu Faizova on 02.04.2023.
//

import Foundation

// view
protocol LoginViewInput: AnyObject {
    func showAlert(_ message: String)
}

// presenter
protocol LoginViewOutput: AnyObject {
    func login(_ email: String, _ password: String)
    func signUp()
}
