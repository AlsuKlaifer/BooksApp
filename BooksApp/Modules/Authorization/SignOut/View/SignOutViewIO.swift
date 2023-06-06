//
//  SignOutViewIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 09.04.2023.
//

import Foundation

// view
protocol SignOutViewInput: AnyObject {
//    var name: String { get set }
//    var email: String { get set }
    func showAlert(_ message: String)
}

// presenter
protocol SignOutViewOutput: AnyObject {
    func signOut()
    func changePassword()
    func getUser(completion: @escaping (User?) -> Void)
}
