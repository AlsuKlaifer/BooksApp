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
    var isFavorite: Bool
    var bookStorage: BookStorageProtocol

    // MARK: - Initialization

    init(book: Book, bookStorage: BookStorageProtocol) {
        self.book = book
        self.bookStorage = bookStorage
        self.isFavorite = ((bookStorage.getBookModel(with: book.id)?.isFavorite) != nil)
    }

    // MARK: - Presenter
    
    func addToFavorite() {
        guard (bookStorage.getBookModel(with: book.id)) != nil else {
            isFavorite = true
            return bookStorage.create(book)
        }
        bookStorage.updateFavorite(with: book.id)
        isFavorite.toggle()
        
        //For check
        let allbooks = bookStorage.readBookModels()
        allbooks.forEach { print("id: \($0.id), isFavorite: \($0.isFavorite)") }
    }
    
    
    func addToReaded() {}
    
    private func delete(bookModel: BookModel) {
        if !bookModel.isFavorite && !bookModel.isReaded {
            bookStorage.delete(id: book.id)
        }
    }
}

extension DescriptionPresenter: DescriptionViewOutput {}
