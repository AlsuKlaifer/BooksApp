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
        self.isRead = bookStorage.getBookModel(with: book.id)?.isRead ?? false
    }

    // MARK: - Presenter
    
    func addToFavorite() {
        guard let bookModel = bookStorage.getBookModel(with: book.id) else {
            let newBook = bookStorage.create(book)
            bookStorage.updateFavorite(with: newBook.id)
            isFavorite = true
            return
        }
        bookStorage.updateFavorite(with: book.id)
        isFavorite.toggle()
        delete(bookModel: bookModel)
        
        //For check
        let allbooks = bookStorage.readBookModels()
        allbooks.forEach { print("id: \($0.id), isFavorite: \($0.isFavorite), isReaded: \($0.isRead)") }
    }
    
    func addToRead() {
        guard let bookModel = bookStorage.getBookModel(with: book.id) else {
            let newBook = bookStorage.create(book)
            bookStorage.updateRead(with: newBook.id)
            isRead = true
            return
        }
        bookStorage.updateRead(with: book.id)
        isRead.toggle()
        delete(bookModel: bookModel)
        
        //For check
        let allbooks = bookStorage.readBookModels()
        allbooks.forEach { print("id: \($0.id), isFavorite: \($0.isFavorite), isReaded: \($0.isRead)") }
    }
    
    private func delete(bookModel: BookModel) {
        if !isFavorite && !isRead {
            bookStorage.delete(id: bookModel.id)
        }
    }
}

extension DescriptionPresenter: DescriptionViewOutput {}
