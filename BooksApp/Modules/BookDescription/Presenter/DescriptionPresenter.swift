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
    var isRead: Bool
    var bookStorage: BookStorageProtocol

    // MARK: - Initialization

    init(book: Book, bookStorage: BookStorageProtocol) {
        self.book = book
        self.bookStorage = bookStorage
        self.isFavorite = bookStorage.getBookModel(with: book.id)?.isFavorite ?? false
        self.isRead = bookStorage.getBookModel(with: book.id)?.isReaded ?? false
    }

    // MARK: - Presenter
    
    func addToFavorite() {
        guard let bookModel = bookStorage.getBookModel(with: book.id) else {
            isFavorite = true
            return bookStorage.create(book)
        }
        bookStorage.updateFavorite(with: book.id)
        isFavorite.toggle()
//        delete(bookModel: bookModel)
        
        //For check
        let allbooks = bookStorage.readBookModels()
        allbooks.forEach { print("id: \($0.id), isFavorite: \($0.isFavorite), isReaded: \($0.isReaded)") }
    }
    
    func addToRead() {
        guard let bookModel = bookStorage.getBookModel(with: book.id) else {
            isRead = true
            return bookStorage.create(book)
        }
        bookStorage.updateRead(with: book.id)
        isRead.toggle()
//        delete(bookModel: bookModel)
        
        let allbooks = bookStorage.readBookModels()
        allbooks.forEach { print("id: \($0.id), isFavorite: \($0.isFavorite), isReaded: \($0.isReaded)") }
    }
    
    private func delete(bookModel: BookModel) {
        if !bookModel.isFavorite && !bookModel.isReaded {
            bookStorage.delete(id: book.id)
        }
    }
}

extension DescriptionPresenter: DescriptionViewOutput {}
