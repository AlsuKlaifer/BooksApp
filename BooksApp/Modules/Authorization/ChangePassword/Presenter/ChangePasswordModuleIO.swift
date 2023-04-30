//
//  ChangePasswordModuleIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 03.04.2023.
//

import Foundation

protocol ChangePasswordModuleOutput: AnyObject {
    func moduleWantsToEnd(_ module: ChangePasswordModuleInput)
}

protocol ChangePasswordModuleInput: AnyObject {}
