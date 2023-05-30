//
//  Сonversion.swift
//  BooksApp
//
//  Created by Alsu Faizova on 22.05.2023.
//

import Foundation

protocol BookParserProtocol {
    func parseToBookModel(book: Book, bookModel: BookModel)
    func parseToBook(bookModel: BookModel) -> Book
}

final class BookParser: BookParserProtocol {

    func parseToBookModel(book: Book, bookModel: BookModel) {
        bookModel.id = book.id
        bookModel.title = book.volumeInfo.title
        bookModel.author = book.volumeInfo.authors?.first
        bookModel.publishedDate = book.volumeInfo.publishedDate
        bookModel.descriptions = book.volumeInfo.description
        bookModel.image = book.volumeInfo.imageLinks.thumbnail
        bookModel.pages = book.volumeInfo.pageCount as? NSNumber
        bookModel.category = book.volumeInfo.categories?.first
        bookModel.rating = book.volumeInfo.averageRating as? NSNumber
        bookModel.language = book.volumeInfo.language
        bookModel.isEpub = book.accessInfo.epub.isAvailable
        bookModel.isPdf = book.accessInfo.pdf.isAvailable
        bookModel.link = book.selfLink
        bookModel.isFavorite = false
        bookModel.isRead = false
    }
    
    func parseToBook(bookModel: BookModel) -> Book {
        return Book(
            id: bookModel.id,
            selfLink: bookModel.link ?? "",
            volumeInfo: VolumeInfo(
                title: bookModel.title,
                authors: [bookModel.author ?? ""],
                publishedDate: bookModel.publishedDate ?? "",
                description: bookModel.descriptions,
                imageLinks: ImageLinks(
                    thumbnail: bookModel.image ?? "https://img.favpng.com/5/25/0/black-and-white-book-clip-art-png-favpng-0dJ3ic2KDk33bxzbGX3qYBUY4.jpg"),
                pageCount: bookModel.pages as? Int,
                categories: [bookModel.category ?? ""],
                averageRating: bookModel.rating as? Double,
                language: bookModel.language ?? ""
            ),
            accessInfo: AccessInfo(
                epub: Pdf(isAvailable: bookModel.isEpub),
                pdf: Pdf(isAvailable: bookModel.isPdf),
                webReaderLink: bookModel.link ?? ""
            )
        )
    }
}
