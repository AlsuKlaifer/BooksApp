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

    // MARK: - Initialization

    init(output: BooksModuleOutput, networkService: INetworkService) {
        self.output = output
        self.networkService = networkService
    }

    // MARK: - Presenter

    func viewDidLoad() {
        obtainData()
        data = [ListSection.new([]), MockData.shared.category]
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
            self.data.append(ListSection.popular(self.dataSourcePopular))
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
    
    func didSelectItem(item: ListItem) {
        switch item {
        case .book(let book):
            output.didSelectBook(module: self, book: book)
        case .category(let category):
            return
        }
    }
}

extension BooksPresenter: BooksModuleInput {}
