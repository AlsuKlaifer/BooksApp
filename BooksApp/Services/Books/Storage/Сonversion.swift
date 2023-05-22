//
//  Сonversion.swift
//  BooksApp
//
//  Created by Alsu Faizova on 22.05.2023.
//

import Foundation

protocol ConversionProtocol {
    func converseToBookModel(book: Book) -> BookModel
}

final class Conversion: ConversionProtocol {

    static let shared = Conversion()

    func converseToBookModel(book: Book) -> BookModel {
        let bookModel = BookModel()
        bookModel.id = book.id
        bookModel.title = book.volumeInfo.title
        bookModel.author = book.volumeInfo.authors?.first
        bookModel.publishedDate = book.volumeInfo.publishedDate
        bookModel.descriptions = book.volumeInfo.description
        bookModel.image = book.volumeInfo.imageLinks.thumbnail
        bookModel.pages = book.volumeInfo.pageCount as? NSNumber
        bookModel.category = book.volumeInfo.categories?.first
        bookModel.rating = book.volumeInfo.averageRating ?? 4.0
        bookModel.language = book.volumeInfo.language
        bookModel.isEpub = book.accessInfo.epub.isAvailable
        bookModel.isPdf = book.accessInfo.pdf.isAvailable
        bookModel.link = book.selfLink
        return bookModel
    }
}
