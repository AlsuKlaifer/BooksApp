//
//  SearchPresenter.swift
//  BooksApp
//
//  Created by Alsu Faizova on 06.06.2023.
//

import UIKit

final class SearchPresenter: SearchViewOutput {

    // Dependencies
    weak var view: SearchViewInput?
//    weak var resultView: SearchViewInput?
    
    private let output: SearchModuleOutput
    private let bookStorage: BookStorageProtocol
    private let networkService: INetworkService

    // Properties
    var data: [Book] = []

    // MARK: - Initialization

    init(output: SearchModuleOutput, bookStorage: BookStorageProtocol, networkService: INetworkService) {
        self.output = output
        self.bookStorage = bookStorage
        self.networkService = networkService
    }

    // MARK: - Presenter

    func viewDidLoad() {
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }
    
    func getBooks(type: String, orderBy: String?, filter: String?, startIndex: Int) {
        networkService.getSearchView(type: type, orderBy: orderBy, filter: filter, startIndex: startIndex) { [weak self] books in
            self?.data = books
            DispatchQueue.main.async { [weak self] in
                self?.view?.reloadData()
            }
        }
    }
    
    func willDisplay(type: String, orderBy: String?, filter: String?, startIndex: Int, completion: @escaping () -> Void) {
        networkService.getSearchView(type: type, orderBy: orderBy, filter: filter, startIndex: startIndex) { [weak self] books in
            completion()
            self?.data.append(contentsOf: books)
            DispatchQueue.main.async { [weak self] in
                self?.view?.reloadData()
            }
        }
    }
    
    func search(with: String, type: String, orderBy: String?, filter: String?) {
        networkService.search(with: with, type: type, orderBy: orderBy, filter: filter) { [weak self] books in
            self?.data = books
            DispatchQueue.main.async {
//                self?.resultView?.reloadData()
            }
        }
    }

    func didSelectItem(book: Book) {
        output.didSelectBook(module: self, book: book)
    }

    func updateFavorite(book: Book) {
        guard let bookModel = bookStorage.getBookModel(with: book.id) else {
            let newBook = bookStorage.create(book)
            bookStorage.updateFavorite(with: newBook.id)
            return
        }
        bookStorage.updateFavorite(with: book.id)
        if !bookModel.isFavorite && !bookModel.isRead {
            bookStorage.delete(id: bookModel.id)
        }
    }
    
    func getFavorite(book: Book) -> Bool {
        guard let bookModel = bookStorage.getBookModel(with: book.id) else { return false }
        return bookModel.isFavorite
    }
    
    func createResultModule() -> UIViewController {
        return output.createResultModule(module: self)
    }
}

extension SearchPresenter: SearchModuleInput { }
