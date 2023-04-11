//
//  SignOutViewIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 09.04.2023.
//

import Foundation

// view
protocol SignOutViewInput: AnyObject {
    func showAlert(_ message: String)
}

// presenter
protocol SignOutViewOutput: AnyObject {
    func signOut()
}
