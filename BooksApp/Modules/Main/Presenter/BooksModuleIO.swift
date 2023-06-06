//
//  BooksModuleIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 16.05.2023.
//

import UIKit

protocol BooksModuleOutput {
    func didSelectBook(module: BooksModuleInput, book: Book)
    func moduleWantsToSearch(module: BooksModuleInput)
}

protocol BooksModuleInput {}
