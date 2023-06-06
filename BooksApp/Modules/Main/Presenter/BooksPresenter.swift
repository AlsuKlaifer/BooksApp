//
//  BooksPresenter.swift
//  BooksApp
//
//  Created by Alsu Faizova on 08.05.2023.
//

import Foundation

final class BooksPresenter: BooksViewOutput {

    // Dependencies
    weak var view: BooksViewInput?
    private let networkService: INetworkService
    private let output: BooksModuleOutput

    // Properties
    var dataSourcePopular: [ListItem] = []
    var dataSourceNew: [ListItem] = []
    var data: [ListSection] = []
    var bookStorage: BookStorageProtocol

    // MARK: - Initialization

    init(output: BooksModuleOutput, networkService: INetworkService, bookStorage: BookStorageProtocol) {
        self.bookStorage = bookStorage
        self.output = output
        self.networkService = networkService
    }

    // MARK: - Presenter

    func viewDidLoad() {
        data = [ListSection.new([]), MockData.shared.category, ListSection.popular([])]
        obtainData()
    }

    // MARK: - Private

    private func obtainData() {
        networkService.getPopularBooks { [weak self] books in
            guard let self else { return }
            let items = books.map { book -> ListItem in
                return ListItem.book(Book(
                    id: book.id,
                    selfLink: book.selfLink,
                    volumeInfo: book.volumeInfo,
                    accessInfo: book.accessInfo))
            }
            self.dataSourcePopular += items
            self.data[2] = ListSection.popular(self.dataSourcePopular)
            self.view?.reloadData()
        }
        
        networkService.getNewBooks { [weak self] books in
            guard let self else { return }
            let items = books.map { book -> ListItem in
                return ListItem.book(Book(
                    id: book.id,
                    selfLink: book.selfLink,
                    volumeInfo: book.volumeInfo,
                    accessInfo: book.accessInfo))
            }
            self.dataSourceNew += items
            self.data[0] = ListSection.new(self.dataSourceNew)
            self.view?.reloadData()
        }
    }
    
    func getCategory(category: String) {
        networkService.getCategoryBooks(category: category) { [weak self] books in
            guard let self else { return }
            let items = books.map { book -> ListItem in
                return ListItem.book(Book(
                    id: book.id,
                    selfLink: book.selfLink,
                    volumeInfo: book.volumeInfo,
                    accessInfo: book.accessInfo))
            }
            self.dataSourcePopular = items
            self.data[2] = ListSection.popular(self.dataSourcePopular)
            self.view?.reloadData()
        }
    }
    
    func didSelectItem(item: ListItem) {
        switch item {
        case .book(let book):
            output.didSelectBook(module: self, book: book)
        case .category(let category):
            getCategory(category: category)
        }
    }
    
    func updateFavorite(item: ListItem) {
        switch item {
        case .book(let book):
            guard let bookModel = bookStorage.getBookModel(with: book.id) else {
                let newBook = bookStorage.create(book)
                bookStorage.updateFavorite(with: newBook.id)
                return
            }
            bookStorage.updateFavorite(with: book.id)
            if !bookModel.isFavorite && !bookModel.isRead {
                bookStorage.delete(id: bookModel.id)
            }
        default:
            return
        }
    }
    
    func getFavorite(item: ListItem) -> Bool {
        switch item {
        case .book(let book):
            guard let bookModel = bookStorage.getBookModel(with: book.id) else { return false }
            return bookModel.isFavorite
        default:
            return false
        }
    }
    
    func openSearchScreen() {
        output.moduleWantsToSearch(module: self)
    }
}

extension BooksPresenter: BooksModuleInput {}
