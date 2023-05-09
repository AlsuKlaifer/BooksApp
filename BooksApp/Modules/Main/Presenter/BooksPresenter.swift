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

    // Properties
    var dataSource: [ListItem] = []
    private let sections = MockData.shared
    var data: [ListSection] = []
    private var isLoading = false

    // MARK: - Initialization

    init(networkService: INetworkService) {
        self.networkService = networkService
    }

    // MARK: - Presenter

    func viewDidLoad() {
        obtainData()
        print("DATASOURSE", dataSource)
    }

    // MARK: - Private

    private func obtainData() {
        guard !isLoading else { return }
        isLoading = true
        networkService.getNewBooks { [weak self] (models: [Book]) in
            guard let self else { return }
            let items = models.map { book -> ListItem in
                return ListItem.book(Book(
                    kind: book.kind,
                    id: book.id,
                    etag: book.etag,
                    selfLink: book.selfLink,
                    volumeInfo: book.volumeInfo,
                    saleInfo: book.saleInfo,
                    accessInfo: book.accessInfo))
            }
            self.dataSource += items
            self.data = [self.sections.new, self.sections.category, ListSection.popular(self.dataSource)]
            self.view?.getListSections(sections: self.data)
            self.isLoading = false
        }
    }
}
