//
//  SignOutModuleIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 03.04.2023.
//

import Foundation

protocol SignOutModuleOutput: AnyObject {
    func moduleWantsToChangePassword(_ model: SignOutModuleInput)
}

protocol SignOutModuleInput: AnyObject {}
