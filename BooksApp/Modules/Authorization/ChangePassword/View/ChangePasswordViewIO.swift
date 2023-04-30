//
//  ChangePasswordViewIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 09.04.2023.
//

import Foundation

// view
protocol ChangePasswordViewInput: AnyObject {
    func showAlert(_ message: String)
}

// presenter
protocol ChangePasswordViewOutput: AnyObject {
    func changePassword(password: String, newPassword: String)
}
