//
//  LoginModuleIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 03.04.2023.
//

import Foundation

protocol LoginModuleOutput: AnyObject {
    func moduleWantsToEndAuth(_ module: LoginModuleInput)
    func moduleWantsToSignUp(_ module: LoginModuleInput)
}

protocol LoginModuleInput: AnyObject {}
