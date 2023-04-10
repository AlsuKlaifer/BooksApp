//
//  SignUpViewIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 09.04.2023.
//

import Foundation

// view
protocol SignUpViewInput: AnyObject {
    func showAlert(_ message: String)
}

// presenter
protocol SignUpViewOutput: AnyObject {
    func signUp(_ email: String, _ password: String)
}
