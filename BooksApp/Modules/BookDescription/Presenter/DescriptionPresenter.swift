//
//  DescriptionPresenter.swift
//  BooksApp
//
//  Created by Alsu Faizova on 15.05.2023.
//

import Foundation

final class DescriptionPresenter {
    
    // Dependencies
    weak var view: DescriptionViewInput?

    // Properties
    var book: Book

    // MARK: - Initialization

    init(book: Book) {
        self.book = book
    }

    // MARK: - Presenter

    func viewDidLoad() {}
}

extension DescriptionPresenter: DescriptionViewOutput {}
