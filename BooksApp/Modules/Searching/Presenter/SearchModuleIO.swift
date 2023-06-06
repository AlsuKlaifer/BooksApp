//
//  SearchModuleIO.swift
//  BooksApp
//
//  Created by Alsu Faizova on 06.06.2023.
//

import UIKit

protocol SearchModuleInput {}

protocol SearchModuleOutput {
    func didSelectBook(module: SearchModuleInput, book: Book)
    func createResultModule(module: SearchModuleInput) -> UIViewController
}
