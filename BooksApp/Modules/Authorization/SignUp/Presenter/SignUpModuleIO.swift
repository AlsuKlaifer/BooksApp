//
//  SignUpModuleIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 03.04.2023.
//

import Foundation

protocol SignUpModuleOutput: AnyObject {
    func moduleWantsToEndAuth(_ module: SignUpModuleInput)
}

protocol SignUpModuleInput: AnyObject {}
