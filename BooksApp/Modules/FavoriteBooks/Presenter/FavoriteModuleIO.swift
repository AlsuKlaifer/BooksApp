//
//  FavoriteModuleIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 25.05.2023.
//

import Foundation

protocol FavoriteModuleInput {}

protocol FavoriteModuleOutput {
    func didSelectBook(module: FavoriteModuleInput, book: Book)
}
